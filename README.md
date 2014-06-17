# Rack::Revision

Rack::Revision is a quick drop-in component to enable code revision tracking. 
It adds `X-Revision` header with the code revision from capistrano's REVISION file.

[![Build Status](https://travis-ci.org/sosedoff/rack-revision.png?branch=master)](https://travis-ci.org/sosedoff/rack-revision)
[![Gem Version](https://badge.fury.io/rb/rack-revision.png)](http://badge.fury.io/rb/rack-revision)

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

- `:header`   - Sets a custom revision header. Default: `X-Revision`
- `:filename` - Sets a filename with revision data. Default: `REVISION`
- `:default`  - Sets a revision value if file does not exist. Default: UNDEFINED
- `:rack_env` - Sets a revision value to Rack's `env` hash. Default: `env['rack.app_revision']`

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

Copyright (c) 2012-2014 Dan Sosedoff <dan.sosedoff@gmail.com>