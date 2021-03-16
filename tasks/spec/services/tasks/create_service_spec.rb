# frozen_string_literal: true

RSpec.describe Tasks::CreateService, type: :service do
  subject { described_class }

  context 'valid parameters' do
    it 'creates a new task' do
      expect { subject.call('title', 'description') }
        .to change(Task, :count).from(0).to(1)
    end

    it 'assigns task' do
      result = subject.call('title', 'description')

      expect(result.task).to be_kind_of(Task)
    end
  end

  context 'invalid parameters' do
    it 'does not create user' do
      expect { subject.call('title', '') }
        .not_to change(Task, :count)
    end

    it 'assigns user' do
      result = subject.call('title', '')

      expect(result.task).to be_kind_of(Task)
    end
  end
end
