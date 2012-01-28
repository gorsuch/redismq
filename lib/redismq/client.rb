require 'json'
require 'redis'
require 'uri'

module RedisMQ  
  class Client
    def bind(topic, queue)
      redis.sadd(topic_key(topic), queue_key(queue))
    end

    def bpop(queue, timeout=0)
      (queue, message) = redis.blpop(queue_key(queue), timeout)
      JSON.parse(message)
    end

    def connect_to_redis
      url = ENV['REDISMQ_URL'] || ENV['REDISTOGO_URL'] || "redis://localhost:6379"
      uri = URI.parse(url)
      Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    end

    def pop(queue)
      JSON.parse(redis.lpop(queue_key(queue)))
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
      "queue:#{queue}"
    end
    
    def queue_name(queue_key)
      queue_key.split(':').last
    end
     
    def topic_key(topic)
      "topic:#{topic}"
    end
  end
end