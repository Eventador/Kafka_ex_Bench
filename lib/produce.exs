# run for this many iterations
messages_count = 20000

defmodule KafkaTest do
    # test configurables
    @test_message ~s({"a":"764efa883dda1e11db47671c4a3bbd9e","timestamp":1497898320,"c":"aBcDeFgHiJk","d":"This is a test","e":"764efa883dda1e11db47671c4a3bbd9e","f":"testing"})
    @topic "elixirtesting"
    @produce_timeout 250
    @report_threshold 40 # milliseconds

    def producer(n) do

	message = %KafkaEx.Protocol.Produce.Message{value: @test_message}
        messages = [message]
        rand_partition = 0 |> :lists.seq(100 - 1) |> Enum.shuffle |> hd

        produce_request = %KafkaEx.Protocol.Produce.Request{
          topic: @topic,
          partition: rand_partition,
          required_acks: -1,
          messages: messages}
        t_start = :os.system_time(:milli_seconds)
        KafkaEx.produce(produce_request, [worker_name: :kafka_ex, timeout: @produce_timeout])
        t_end = :os.system_time(:milli_seconds)
        #IO.puts "Message #{n} Took #{t_end - t_start} msec"
        if t_end - t_start >= @report_threshold do
            IO.puts "Message #{n} Took #{t_end - t_start} msec partition #{rand_partition}"
        end
    end

    def produce_message(n) when n <= 1 do   
        producer(n)
    end

    def produce_message(n) do
        producer(n)
        produce_message(n-1)
    end
    
end

run_start = :os.system_time(:milli_seconds)
KafkaTest.produce_message(messages_count)
run_end = :os.system_time(:milli_seconds)

messages_sec = (messages_count / (run_end - run_start))*1000
IO.puts "Run took #{run_end - run_start} ms, #{messages_count} messages, #{messages_sec} msg/sec"
