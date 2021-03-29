# frozen_string_literal: true

module Users
  class LoginService
    prepend BasicService

    param :email
    param :password
    option :user, default: proc { User.find(email: @email) }, reader: false

    attr_reader :session

    def call
      validate
      return if failure?

      @session = UserSession.find(user: @user)
      @session = @session.present? ? reinitialized_session : create_session
    end

    private

    def validate
      return fail_t!(:unauthorized) unless @user&.authenticate(@password)
    end

    def reinitialized_session
      @session.destroy
      EventProducer.send_event('session destroyed', 'CUD', @session)

      create_session
    end

    def create_session
      @session = UserSession.new(user: @user)

      if @session.valid?
        @user.add_session(@session)
        EventProducer.send_event('session created', 'CUD', @session)
        @session
      else
        fail!(@session.errors)
      end
    end

    def fail_t!(key)
      fail!(I18n.t(key, scope: 'services.user_sessions.create_service'))
    end
  end
end
