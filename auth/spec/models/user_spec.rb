# frozen_string_literal: true

require 'application_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { validate_presence :name }
    it { validate_presence :email }
    it { validate_presence :role }
    it { validate_presence :password }
    it { validate_includes User::ALLOWED_ROLES, :role }
  end
end
