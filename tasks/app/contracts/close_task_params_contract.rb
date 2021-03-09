# frozen_string_literal: true

class CloseTaskParamsContract < Dry::Validation::Contract
  params do
    required(:task_id).filled(:integer)
    required(:user_id).filled(:integer)
  end
end
