require 'rack'

module Rack
  class Revision
    VERSION = '0.1.0'

    File = ::File
    @@revision = nil
 
    def initialize(app)
      @app   = app
      @file  = File.join(Dir.pwd, 'REVISION')
    end
 
    def call(env)
      status, headers, body = @app.call(env)
      headers['X-Revision'] = revision
      [status, headers, body]
    end
 
    protected
 
    def revision
      @@revision ||= read_revision
    end
 
    def read_revision
      File.exists?(@file) ? File.read(@file).strip : 'Undefined'
    end
  end
end