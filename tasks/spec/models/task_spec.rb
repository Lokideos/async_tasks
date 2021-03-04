# frozen_string_literal: true

RSpec.describe Task, type: :model do
  context 'validations' do
    it { validate_presence :title }
    it { validate_presence :description }
    it { validate_presence :status }
  end
end
