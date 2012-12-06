require 'rack'

module Rack
  class Revision
    File = ::File
    @@revision = nil

    def initialize(app, options={})
      @options = {
        :header   => options[:header].nil? ? 'X-Revision' : options[:header],
        :filename => options[:filename] || 'REVISION',
        :default  => options[:default]  || 'UNDEFINED' 
      }

      @app = app
    end
 
    def call(env)
      status, headers, body = @app.call(env)
      headers[@options[:header]] = revision if @options[:header]
      [status, headers, body]
    end

    def reset_revision
      @@revision = nil
    end
 
    protected
 
    def revision
      @@revision ||= read_revision
    end
 
    def read_revision
      File.exists?(detected_filename) ? File.read(detected_filename).strip : @options[:default]
    end

    def detected_filename
      @file ||= (@options[:filename] =~ /\A\// ? @options[:filename] : File.join(Dir.pwd, @options[:filename]))
    end
  end
end
