# frozen_string_literal: true

RSpec.describe Users::LoginService do
  subject { described_class }

  let(:user_email) { 'bob@example.com' }
  let(:user_password) { 'givemeatoken' }

  context 'valid parameters' do
    let!(:user) { Fabricate(:user, email: user_email, password: user_password) }

    it 'creates a new session' do
      expect { subject.call(user_email, user_password) }
        .to change { user.reload.sessions.count }.from(0).to(1)
    end

    it 'assigns session' do
      result = subject.call(user_email, user_password)

      expect(result.session).to be_kind_of(UserSession)
    end

    context 'session for current user is already presnet' do
      let!(:session) { Fabricate(:user_session, user: user) }

      it 'deletes current session' do
        subject.call(user_email, user_password)

        expect(UserSession.all).to_not include session
      end

      it 'creates a new different session' do
        subject.call(user_email, user_password)

        expect(user.sessions.first).to be_kind_of(UserSession)
      end

      it 'assigns session' do
        result = subject.call(user_email, user_password)

        expect(result.session).to be_kind_of(UserSession)
      end
    end
  end

  context 'missing user' do
    it 'does not create session' do
      expect { subject.call(user_email, user_password) }
        .not_to change(UserSession, :count)
    end

    it 'adds an error' do
      result = subject.call(user_email, user_password)

      expect(result).to be_failure
      expect(result.errors).to include(I18n.t(:unauthorized,
                                              scope: 'services.user_sessions.create_service'))
    end
  end

  context 'invalid password' do
    let!(:user) { Fabricate(:user, email: user_email, password: user_password) }

    it 'does not create session' do
      expect { subject.call(user_email, 'invalid') }
        .not_to change(UserSession, :count)
    end

    it 'adds an error' do
      result = subject.call(user_email, 'invalid')

      expect(result).to be_failure
      expect(result.errors).to include(I18n.t(:unauthorized,
                                              scope: 'services.user_sessions.create_service'))
    end
  end
end
