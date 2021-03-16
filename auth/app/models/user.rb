# frozen_string_literal: true

class User < Sequel::Model
  DEVELOPER_ROLE = 'developer'
  ADMIN_ROLE = 'admin'
  MANAGER_ROLE = 'manager'
  ALLOWED_ROLES = [DEVELOPER_ROLE, ADMIN_ROLE, MANAGER_ROLE].freeze

  plugin :association_dependencies
  plugin :secure_password, include_validations: false

  one_to_many :sessions, class: 'UserSession'

  add_association_dependencies sessions: :delete

  def validate
    super

    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
    validates_presence :email, message: I18n.t(:blank, scope: 'model.errors.user.email')
    validates_presence :role, message: I18n.t(:blank, scope: 'model.errors.user.role')
    validates_presence :password, message: I18n.t(:blank, scope: 'model.errors.user.password')
    validates_includes ALLOWED_ROLES,
                       :role,
                       message: I18n.t(:wrong_role,
                                       scope: 'model.errors.user.role',
                                       roles: ALLOWED_ROLES)
  end
end
