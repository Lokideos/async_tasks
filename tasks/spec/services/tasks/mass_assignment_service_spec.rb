# frozen_string_literal: true

RSpec.describe Tasks::MassAssignmentService, type: :service do
  subject { described_class }

  describe '#call' do
    let!(:task) { Fabricate(:task) }
    let!(:developer) { Fabricate(:user, role: 'developer') }

    it 'assigns all unassigned tasks to developers' do
      subject.call

      expect(task.user).to eq developer
    end

    it "updates task statuses to 'assigned'" do
      subject.call

      expect(task.reload.status).to eq Task::ASSIGNED_STATUS
    end

    context 'there are previously assigned tasks' do
      let!(:task_assignment) { Fabricate(:task_assignment) }

      it 'reassigns all assign tasks' do
        subject.call

        expect(TaskAssignment.map(:id)).to_not include task_assignment.id
      end
    end

    context 'there are closed tasks' do
      let!(:closed_task) { Fabricate(:task, status: Task::COMPLETED_STATUS) }
      let!(:task_assignment) { Fabricate(:task_assignment, task_id: task.id) }

      it 'does not reassign closed tasks' do
        expect { subject.call }.to_not change(task_assignment, :id)
      end

      it 'does not change status of closed tasks' do
        expect { subject.call }.to_not change(closed_task, :status)
      end
    end
  end
end
