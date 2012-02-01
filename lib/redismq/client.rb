require 'json'
require 'redis'
require 'uri'

module RedisMQ  
  class Client
    attr_accessor :redis

    def bind(topic, queue)
      redis.sadd(topic_key(topic), queue_key(queue))
    end

    def bpop(queue, timeout=0)
      (queue, message) = redis.blpop(queue_key(queue), timeout)
      parse_json(message)
    end

    def connect_to_redis
      url = ENV['REDISMQ_URL'] || ENV['REDISTOGO_URL'] || 'redis://localhost:6379'
      uri = URI.parse(url)
      Redis.new(host: uri.host, port: uri.port, password: uri.password)
    end
    
    def parse_json(json)
      JSON.parse(json, symbolize_names: true)
    end
    
    def pop(queue)
      result = redis.lpop(queue_key(queue))
      return nil if result.nil?
      parse_json(result)
    end

    def publish(topic, payload)
      message = { header: { topic: topic }, payload: payload }
      redis.smembers(topic_key(topic)).each do |queue|
        push(queue, message)        
      end
    end

    def push(queue, message)
      redis.rpush(queue, message.to_json)
    end

    def redis
      @redis ||= connect_to_redis
    end

    def queue_key(queue)
      "rmq:queue:#{queue}"
    end
    
    def topic_key(topic)
      "rmq:topic:#{topic}"
    end
  end
end
