# frozen_string_literal: true

class UsersContract < Dry::Validation::Contract
  schema do
    required(:name).filled(:string)
    required(:email).filled(:string)
    required(:password_digest).filled(:string)
  end
end