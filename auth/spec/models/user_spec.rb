# frozen_string_literal: true

RSpec.describe User, type: :model do
  context 'associations' do
    it { have_one_to_many :session }
  end

  context 'validations' do
    it { validate_presence :name }
    it { validate_presence :email }
    it { validate_presence :role }
    it { validate_presence :password }
    it { validate_includes User::ALLOWED_ROLES, :role }
  end
end
