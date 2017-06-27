# Kafka_ex Testing

To run:

```
First, update the brokers list:

$ vim config/config.exs

Then get dependencies and launch test:

$ mix deps.get
$ mix run lib/produce.exs
```

If you have kafkacat and jq installed, you can watch the data flowing (it's valid json)
like this:

```
kafkacat -C -b ADDRESS.OF.BROKER:9092 -t elixirtesting -o end | jq .
```
