# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :kafka_ex,
  brokers: [
    {"CUSTOMER-kafka0.pub.va.eventador.io", 9092},
    {"CUSTOMER-kafka1.pub.va.eventador.io", 9092},
    {"CUSTOMER-kafka2.pub.va.eventador.io", 9092},
  ],
  consumer_group: "kafka_ex",
  disable_default_worker: false,
  use_ssl: false,
  kafka_version: "0.10.2",
  sync_timeout: 3000

