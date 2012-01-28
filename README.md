# RedisMQ

An implementation of topic exchanges using Redis.

## Installation

Add this line to your application's Gemfile:

    gem 'redismq'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redismq

## Usage

```ruby
require 'redismq'

client = RedisMQ::Client.new

# send all announcements to the customer.signup topic to the email queue
client.bind('customer.signup', 'email')

# pretend a customer signed up
client.publish('customer.signup', { id: 1 })
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
