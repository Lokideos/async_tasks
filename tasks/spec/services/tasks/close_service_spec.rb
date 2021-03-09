# frozen_string_literal: true

RSpec.describe Tasks::CloseService, type: :service do
  subject { described_class }

  let!(:task) { Fabricate(:task, status: Task::ASSIGNED_STATUS) }
  let!(:developer) { Fabricate(:user, role: 'developer') }

  before do
    Tasks::MassAssignmentService.call
  end

  context 'valid parameters' do
    it "updates task status to 'closed'" do
      subject.call(task.id, developer.id)

      expect(task.reload.status).to eq Task::CLOSED_STATUS
    end

    it 'assigns task' do
      result = subject.call(task.id, developer.id)

      expect(result.task).to be_kind_of(Task)
    end
  end

  context 'invalid parameters' do
    context 'task with given task_id does not exist' do
      let(:bad_task_id) { 0 }

      it 'adds an error' do
        result = subject.call(bad_task_id, developer.id)

        expect(result).to be_failure
        expect(result.errors).to include(I18n.t(:not_found, scope: 'services.tasks.close_service'))
      end
    end

    context 'user is trying to close another users task' do
      let(:bad_user_id) { 0 }

      it 'adds an error' do
        result = subject.call(task.id, bad_user_id)

        expect(result).to be_failure
        expect(result.errors)
          .to include(I18n.t(:unauthorized, scope: 'services.tasks.close_service'))
      end
    end
  end
end
