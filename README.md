[![Maintainability](https://api.codeclimate.com/v1/badges/c7c2d4123ee5665ce540/maintainability)](https://codeclimate.com/github/rodacato/bitsor/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c7c2d4123ee5665ce540/test_coverage)](https://codeclimate.com/github/rodacato/bitsor/test_coverage)
[![CircleCI](https://circleci.com/gh/rodacato/bitsor/tree/master.svg?style=svg)](https://circleci.com/gh/rodacato/bitsor/tree/master)

# Bitsor

Ruby wrapper for bitso.com API

**note: under development use it on your own risk**

## Quick start

Install via Rubygems

    gem install bitsor

... or add to your Gemfile

    gem "bitsor", "~> 0.1"

### Making requests

[API methods][] are available as module methods (consuming module-level
configuration) or as client instance methods.

```ruby
# Provide authentication credentials
Bitsor.configure do |c|
  c.client_id = 123456
  c.api_key = 'funky'
  c.api_secret = '4l1Th3c01Ns!'
end

# Fetch the user balance
Bitsor.balance
```
or

```ruby
# Provide authentication credentials
client = Bitsor::Client.new(client_id: 123456, api_key: 'defunkt', api_secret: '4l1Th3c01Ns!')

# Fetch the user balance
client.balance
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rodacato/bitsor.

## License

Copyright (c) 2009-2014 Wynn Netherland, Adam Stacoviak, Erik Michaels-Ober

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
