# frozen_string_literal: true

RSpec.describe Task, type: :model do
  context 'associations' do
    it { have_one_to_one :task_assignment }
    it { have_one_through_one :user }
  end

  context 'validations' do
    it { validate_presence :title }
    it { validate_presence :description }
    it { validate_presence :status }
  end
end
