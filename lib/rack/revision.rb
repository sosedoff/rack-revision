require 'rack'

module Rack
  class Revision
    File = ::File
    @@revision = nil

    def initialize(app, options={})
      initialize_options(options)

      @app = app
    end

    def call(env)
      if @options[:rack_env]
        env[@options[:rack_env]] = revision
      end

      status, headers, body = @app.call(env)

      if @options[:header]
        headers[@options[:header]] = revision
      end

      [status, headers, body]
    end

    def reset_revision
      @@revision = nil
    end

    protected

    def revision
      @@revision ||= (fetch_from_env || fetch_from_file || fetch_default)
    end

    def fetch_from_env
      ENV[@options[:env_var]]
    end

    def fetch_from_file
      if ::File.exist?(detected_filename)
        ::File.read(detected_filename).strip
      end
    end

    def fetch_default
      @options[:default]
    end

    def detected_filename
      @file ||= (@options[:filename] =~ /\A\// ? @options[:filename] : File.join(Dir.pwd, @options[:filename]))
    end

    def initialize_options(options)
      @options = {
        :header   => options[:header].nil? ? "X-Revision" : options[:header],
        :rack_env => options[:rack_env].nil? ? "rack.app_revision" : options[:rack_env],
        :env_var  => options[:env_var]  || "RACK_REVISION",
        :filename => options[:filename] || "REVISION",
        :default  => options[:default]  || "UNDEFINED"
      }
    end
  end
end
