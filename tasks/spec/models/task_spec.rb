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
    it { validate_includes Task::ALLOWED_STATUSES, :status }
  end

  describe '#user_id' do
    let!(:developer) { Fabricate(:user, role: 'developer') }
    let!(:task) { Fabricate(:task, status: Task::ASSIGNED_STATUS) }
    let!(:task_assignment) do
      Fabricate(:task_assignment, user: developer, task: task)
    end

    it 'returns id of associated user' do
      expect(task.user_id).to eq developer.id
    end
  end
end
