# frozen_string_literal: true

# producer = WaterDrop::Producer.new do |config|
#   config.deliver = Application.environment == :test ? false : true
#   config.kafka = {
#     'bootstrap.servers': 'localhost:9092',
#     'request.required.acks': 1
#   }
# end

PRODUCER_SETTINGS = {
  deliver: !(Application.environment == :test),
  kafka: {
    'bootstrap.servers': 'localhost:9092',
    'request.required.acks': 1
  }.freeze
}.freeze
