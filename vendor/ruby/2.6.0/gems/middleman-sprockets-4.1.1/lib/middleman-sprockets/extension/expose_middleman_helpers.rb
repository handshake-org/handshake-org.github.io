module Middleman
  module Sprockets
    class Extension
      module ExposeMiddlemanHelpers
        def mm_context
          @_mm_context ||= app.template_context_class.new(app, current_path: current_path)
        end

        def method_missing method, *args, &block
          if mm_context.respond_to?(method)
            return mm_context.send method, *args, &block
          end

          super
        end

        def respond_to? method, include_private=false
          super || mm_context.respond_to?(method, include_private)
        end
      end
    end
  end
end
