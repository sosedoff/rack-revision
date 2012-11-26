require 'rack'

module Rack
  class Revision
    VERSION = '0.1.0'

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
 
    protected
 
    def revision
      @@revision ||= read_revision
    end
 
    def read_revision
      File.exists?(@file) ? File.read(@file).strip : @options[:default]
    end
  end
end