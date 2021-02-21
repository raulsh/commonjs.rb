
require 'commonjs'
require 'pathname'

def env_with_path_value(path)
  CommonJS::Environment.new new_runtime, :path => path
end

if defined?(JRUBY_VERSION)
  require 'rhino'
  def new_runtime
    Rhino::Context.new
  end
else
  require 'mini_racer'
  module MiniRacer
    class JSError < StandardError
    end
    class Context
      def []=(key,value)
        @globals ||= {}
        @globals[key] = value
      end
      def [](key)
        @globals ||= {}
        @globals[key]
      end
    end
  end
  def new_runtime
    MiniRacer::Context.new
  end
end