require 'minitest/spec'
require 'minitest/autorun'

require 'redismq'

describe RedisMQ::Client do
  before do
    @client = RedisMQ::Client.new
    @client.flushdb
  end
end