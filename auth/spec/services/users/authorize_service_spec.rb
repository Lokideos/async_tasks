# frozen_string_literal: true

RSpec.describe Users::AuthorizeService do
  subject { described_class }

  context 'valid parameters' do
    let(:session) { Fabricate(:user_session) }

    it 'assigns user' do
      result = subject.call(session.uuid)

      expect(result.user).to eq(session.user)
    end
  end

  context 'invalid parameters' do
    it 'does not assign user' do
      result = subject.call(SecureRandom.uuid)

      expect(result.user).to be_nil
    end

    it 'adds an error' do
      result = subject.call(SecureRandom.uuid)

      expect(result).to be_failure
      expect(result.errors).to include(I18n.t(:forbidden, scope: 'services.users.authorize_service'))
    end
  end
end
