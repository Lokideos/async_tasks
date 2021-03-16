# frozen_string_literal: true

module EventProducer
  module_function

  def send_event(name, type, payload)
    p "#{name} event with type #{type} and #{payload} payload was sent ^_^"
  end
end
