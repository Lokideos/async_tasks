# frozen_string_literal: true

module Users
  class AuthorizeService
    prepend BasicService

    param :uuid

    attr_reader :user

    # No need to send any CUD events here because auth logic will be implemented on each service (and it works based)
    # on user_ids in user_sessions tables, which updates via CUD events
    def call
      return fail!(I18n.t(:forbidden, scope: 'services.users.authorize_service')) if @uuid.blank? || session.blank?

      @user = session.user
    end

    private

    def session
      @session ||= UserSession.find(uuid: @uuid)
    end
  end
end
