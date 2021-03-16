# frozen_string_literal: true

RSpec.describe User, type: :model do
  context 'associations' do
    it { have_one_to_many :task_assignments }
    it { have_many_to_many :tasks }
  end

  context 'validations' do
    it { validate_presence :name }
    it { validate_presence :role }
    it { validate_includes User::USER_ROLES.values, :role }
  end

  describe '#tasks_ids' do
    let!(:developer) { Fabricate(:user, role: 'developer') }
    let!(:task) { Fabricate(:task, status: Task::ASSIGNED_STATUS) }
    let!(:task_assignment) do
      Fabricate(:task_assignment, user: developer, task: task)
    end

    it 'returns ids of associated tasks' do
      expect(developer.task_ids).to eq [task.id]
    end
  end
end
