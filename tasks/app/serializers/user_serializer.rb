# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :name, :role
  has_many :tasks
end
