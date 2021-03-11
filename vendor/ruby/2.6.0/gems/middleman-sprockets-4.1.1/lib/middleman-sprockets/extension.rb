require 'sprockets'
require 'middleman-core/contracts'
require 'middleman-core/sitemap/resource'

require_relative 'resource'
require_relative 'resource_store'
require_relative 'interface'

module Middleman
  module Sprockets
    class Extension < Extension
      attr_reader :environment,
                  :interface,
                  :resources

      expose_to_config   sprockets: :environment
      expose_to_template sprockets: :environment

      option :supported_output_extensions,   ['.css', '.js'], 'Output extensions sprockets should process'
      option :imported_asset_path,           'assets',        'Where under source imported assets should be placed.'
      option :expose_middleman_helpers,      false,           'Whether to expose middleman helpers to sprockets.'

      Contract ::Middleman::Application, Hash, Maybe[Proc] => Any
      def initialize app, options_hash={}, &block
        super

        @resources   = ResourceStore.new
        @environment = ::Sprockets::Environment.new
        @interface   = Interface.new options, @environment

        use_sassc_if_available
      end

      Contract Any
      def after_configuration
        @environment.append_path((app.source_dir + app.config[:js_dir]).to_s)
        @environment.append_path((app.source_dir + app.config[:css_dir]).to_s)
        @environment.append_path(app.source_dir.to_s)

        append_paths_from_gems

        the_app = app
        the_env = environment

        @environment.context_class.send(:define_method, :app)  { the_app }
        @environment.context_class.send(:define_method, :data) { the_app.data }
        @environment.context_class.send(:define_method, :env)  { the_env }

        @environment.context_class.send(:include, ContextMethods)
        @environment.context_class.send(:prepend, ExposeMiddlemanHelpers) if options[:expose_middleman_helpers]
      end

      Contract ResourceList => ResourceList
      def manipulate_resource_list resources
        sprockets_resources, base_resources = resources.partition(&method(:processible?))
        ::Middleman::Util.instrument 'sprockets', name: 'manipulator.sprockets_resources' do
          sprockets_resources.map!(&method(:process_sprockets_resource))
        end

        ::Middleman::Util.instrument 'sprockets', name: 'manipulator.ignore_resources' do
          all_resources = base_resources + sprockets_resources + linked_resources!.to_a

          if app.extensions[:sitemap_ignore].respond_to?(:manipulate_resource_list)
            app.extensions[:sitemap_ignore].manipulate_resource_list all_resources
          else
            all_resources
          end
        end
      end

      Contract ::Middleman::Sitemap::Resource => Bool
      def processible? r
        !r.is_a?(Resource) && !r.file_descriptor.nil? && interface.processible?(r.source_file)
      end

      Contract String => Bool
      def check_asset path
        if environment[path]
          true
        else
          false
        end
      end

      Contract ::Sprockets::Asset => String
      def sprockets_asset_path sprockets_asset
        if options[:imported_asset_path].is_a?(String)
          File.join(options[:imported_asset_path], sprockets_asset.logical_path)
        else
          options[:imported_asset_path].call(sprockets_asset)
        end
      end

      private

        def linked_resources
          @_linked_resources ||= (@resources.resources
                                            .map(&:sprockets_asset)
                                            .map(&:links)
                                            .reduce(&:merge) || Set.new
                                 ).map do |path|
            asset = environment[path]
            generate_resource(sprockets_asset_path(asset),
                              asset.filename,
                              asset.logical_path)
          end
        end

        def linked_resources!
          @_linked_resources = nil
          linked_resources
        end

        Contract ::Middleman::Sitemap::Resource => Or[::Middleman::Sitemap::Resource, Resource]
        def process_sprockets_resource resource
          ::Middleman::Util.instrument 'sprockets', name: 'process_resource', resource: resource do
            sprockets_resource = generate_resource(
              resource.path,
              resource.source_file,
              source_file_relative_to_root(resource)
            )
            @resources.add sprockets_resource

            sprockets_resource.ignore! if resource.ignored?

            sprockets_resource
          end
        rescue => e
          logger.error("== Sprockets Debug: #{resource}")
          logger.error("== Sprockets Debug: #{sprockets_resource}") if defined?(sprockets_resource)
          raise e
        end

        Contract String, String, String => Resource
        def generate_resource path, source_file, sprockets_path
          ::Middleman::Util.instrument 'sprockets', name: 'generate_resource',
                                                    path: path,
                                                    sprockets_path: sprockets_path do
            Resource.new(app.sitemap, path, source_file, sprockets_path, environment)
          end
        end

        def use_sassc_if_available
          if defined?(::SassC)
            require 'sprockets/sassc_processor'
            environment.register_transformer 'text/sass', 'text/css', ::Sprockets::SasscProcessor.new
            environment.register_transformer 'text/scss', 'text/css', ::Sprockets::ScsscProcessor.new

            logger.info '== Sprockets will render css with SassC'
          end
        rescue LoadError
          logger.info "== Sprockets will render css with ruby sass\n" \
                      '   consider using Sprockets 4.x to render with SassC'
        end

        def source_file_relative_to_root resource
          Pathname.new(resource.source_file).relative_path_from(
            Pathname.new(File.join(@app.root, @app.config[:source]))
          ).to_s
        end

        # Backwards compatible means of finding all the latest gemspecs
        # available on the system
        #
        # @private
        # @return [Array] Array of latest Gem::Specification
        def rubygems_latest_specs
          # If newer Rubygems
          if ::Gem::Specification.respond_to? :latest_specs
            ::Gem::Specification.latest_specs(true)
          else
            ::Gem.source_index.latest_specs
          end
        end

        # Add any directories from gems with Rails-like paths to sprockets load path
        def append_paths_from_gems
          root_paths = rubygems_latest_specs.map(&:full_gem_path) << app.root
          base_paths = %w[assets app app/assets vendor vendor/assets lib lib/assets]
          asset_dirs = %w[javascripts js stylesheets css images img fonts]

          root_paths.product(base_paths.product(asset_dirs)).each do |root, (base, asset)|
            path = File.join(root, base, asset)
            environment.append_path(path) if File.directory?(path)
          end
        end
    end
  end
end

require_relative 'extension/context_methods'
require_relative 'extension/expose_middleman_helpers'
