# encoding: utf-8

require "spec_helper"

describe MQ::Queue do
  include AMQP::Spec

  default_timeout 5

  amqp_before do
    @mq = MQ.new
  end

  # Queue.Declare
  it "should update MQ::Queue#name by the name generated by the broker" do
    @mq.queue("") do |queue, *args|
      queue.name.should_not be_empty
      done
    end
  end

  # TODO: this will require quite a lot of code, but it should be tested anyway.
  # should "be able to access consumer count" do
  # end

  # Queue.Bind
  it "should work with a callback" do
    exchange = MQ.fanout("fanout")
    @mq.queue("") do |queue, *args|
      queue.bind(exchange) do |*args|
        done
      end
    end
  end
end