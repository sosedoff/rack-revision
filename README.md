# Rack::Revision

Rack::Revision is a quick drop-in component to enable code revision tracking. 
It adds `X-Revision` header with the code revision from capistrano's REVISION file.

[![Build Status](https://img.shields.io/travis/sosedoff/rack-revision.svg)](https://travis-ci.org/sosedoff/rack-revision)
[![Gem Version](https://img.shields.io/gem/v/rack-revision.svg)](http://badge.fury.io/rb/rack-revision)

## Installation

Add dependency to your Gemfile:

```
gem "rack-revision"
```

Install gem:

```
bundle install
```

## Usage

Rack::Revision is implemented as a piece of Rack middleware and can be used with
any Rack-based application. If you have a `config.ru` rackup file you can 
drop the following snippet (for sinatra app):

```ruby
require "rack/revision"

# Basic example
use Rack::Revision

# With custom revision header
use Rack::Revision, :header => "X-CODE-VERSION"

# With custom filename and default value
use Rack::Revision, :filename => ".version", :default => "n/a"

# Execute application
run Sinatra::Application
```

Available options:

- `:header`   - Changes revision header name. Default: `X-Revision`
- `:filename` - Changes the revision filename. Default: `REVISION`
- `:rack_env` - Changes Rack environment key for revision. Default: `env['rack.app_revision']`
- `:env_var`  - Sets revision value from an environment variable. Default: `RACK_REVISION`
- `:default`  - Sets revision value if env var or a file with revision does not exist. Default: `UNDEFINED`

## Example

To see what the header might look like, run a curl command:

```
curl -i -X HEAD "http://yourdomain.com"
```

Example response:

```
HTTP/1.1 200 OK
Server: nginx/1.4.4
Content-Type: text/html; charset=utf-8
Connection: keep-alive
X-UA-Compatible: IE=Edge,chrome=1
ETag: "5e622b6dab40d3cb8ad8a4bd51627a59"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: ae07ad30bd857788bebfa1421576f96e
X-Runtime: 0.022007
X-Rack-Cache: miss
X-Revision: a3de2043d4cea6182e511c9c73f57f4f1e0dbc2b
```

## Test

Execute test suite:

```
rake test
```

## License

The MIT License

Copyright (c) 2012-2020 Dan Sosedoff <dan.sosedoff@gmail.com>