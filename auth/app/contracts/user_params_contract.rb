# frozen_string_literal: true

class UserParamsContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:email).filled(:string)
    required(:role).filled(:string)
    required(:password_digest).filled(:string)
  end
end
