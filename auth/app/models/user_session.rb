# frozen_string_literal: true

class UserSession < Sequel::Model
  plugin :uuid

  many_to_one :user

  def validate
    super

    validates_presence :user_id, message: I18n.t(:blank, scope: 'model.errors.user_session.user_id')
  end
end
