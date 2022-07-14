module Middleman
  module Sprockets
    class Extension
      module ContextMethods
        def current_resource
          app.extensions[:sprockets].resources.find_by_path(filename)
        end

        def current_path
          current_resource.destination_path if current_resource
        end

        def asset_path path, options={}
          # Handle people calling with the Middleman/Padrino asset path signature
          if path.is_a?(::Symbol) && !options.is_a?(::Hash)
            kind = path
            path = options
          else
            kind = {
              image: :images,
              font: :fonts,
              javascript: :js,
              stylesheet: :css
            }.fetch(options[:type], options[:type])
          end

          if File.extname(path).empty?
            path << { js: '.js', css: '.css' }.fetch(kind, '')
          end

          if app.extensions[:sprockets].check_asset(path)
            link_asset(path)

            File.join *[app.config[:http_prefix],
                        app.extensions[:sprockets].sprockets_asset_path(env[path])].compact
          else
            app.asset_path(kind, path)
          end

        end
      end
    end
  end
end
