# Rack::Revision

Rack::Revision is a quick drop-in component to enable code revision tracking. 
It adds `X-Revision` header with the code revision from capistrano's REVISION file.

## Installation

From rubygems:

```
gem install rack-revision
```

Or install with bundler:

```
gem 'rack-revision'
```

And run `bundle install`

## Usage

Rack::Revision is implemented as a piece of Rack middleware and can be used with
any Rack-based application. If you have a `config.ru` rackup file you can 
drop the following snippet (for sinatra app):

```ruby
require 'rack/revision'

# Basic example
use Rack::Revision

# With custom revision header
use Rack::Revision, :header => 'X-CODE-VERSION'

# With custom filename and default value
use Rack::Revision, :filename => '.version', :default => 'n/a'

run Sinatra::Application
```

Available options:

- `:header`   - Sets a custom revision header. Default: `X-Revision`
- `:filename` - Sets a filename with revision data. Default: `REVISION`
- `:default`  - Sets a revision value if file does not exist. Default: UNDEFINED
- `:rack_env` - Sets a revision value to Rack's `env` hash. Default: `env['rack.app_revision']`

## Test

Execute test suite:

```
rake test
```

## License

Copyright (c) 2012 Dan Sosedoff.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
