# frozen_string_literal: true

RSpec.describe TaskAssignment, type: :model do
  context 'associations' do
    it { have_many_to_one :tasks }
    it { have_many_to_one :users }
  end

  context 'validations' do
    it { validate_unique :task_id }
    let(:task) { Fabricate(:task) }
    let(:manager) { Fabricate(:user, role: 'manager') }
    let(:developer) { Fabricate(:user, role: 'developer') }

    it 'should be valid for user with developer role' do
      expect(TaskAssignment.new(task_id: task.id, user_id: developer.id)).to be_valid
    end

    it 'should not be valid for user with manager role' do
      expect(TaskAssignment.new(task_id: task.id, user_id: manager.id)).to_not be_valid
    end
  end
end
