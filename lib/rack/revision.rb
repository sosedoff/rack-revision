require 'rack'

module Rack
  class Revision
    File = ::File
    @@revision = nil

    def initialize(app, options={})
      @options = {
        :header   => options[:header]   || 'X-Revision',
        :filename => options[:filename] || 'REVISION',
        :default  => options[:default]  || 'UNDEFINED' 
      }

      @app = app
      @file = File.join(Dir.pwd, @options[:filename])
    end
 
    def call(env)
      status, headers, body = @app.call(env)
      headers[@options[:header]] = revision
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
      File.exists?(@file) ? File.read(@file).strip : @options[:default]
    end
  end
end