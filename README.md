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

### As a publisher

```ruby
require 'redismq'

client = RedisMQ::Client.new

# pretend a customer signed up, publish his info to the 'customer.signup' topic
client.publish('customer.signup', { id: 1 })
```

### As a consumer

```ruby
require 'redismq'

client = RedisMQ::Client.new

# ensure that all items sent to customer.signup wind up in the email queue
client.bind('customer.signup', 'email')

# assume that a message has been sent...
client.pop('email')
# {"header"=>{"topic"=>"customer.signup"}, "payload"=>{:id=>1}}

# or, block and wait for something to hit the queue
client.bpop('email')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
