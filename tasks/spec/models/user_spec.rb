# frozen_string_literal: true

RSpec.describe User, type: :model do
  context 'associations' do
    it { have_one_to_one :task_assignment }
    it { have_one_through_one :task }
  end

  context 'validations' do
    it { validate_presence :name }
    it { validate_presence :role }
    it { validate_includes User::USER_ROLES.values, :role }
  end
end
