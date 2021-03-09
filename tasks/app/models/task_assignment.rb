# frozen_string_literal: true

class TaskAssignment < Sequel::Model
  PERMITTED_USER_ROLES = %w[developer].freeze

  plugin :association_dependencies

  one_to_many :tasks
  one_to_many :users

  def validate
    super
    user = User.find(id: user_id)
    unless PERMITTED_USER_ROLES.include?(user&.role)
      errors.add(
        :user_id,
        I18n.t(
          :bad_user_role,
          scope: 'model.errors.task_assignment.user_id',
          roles: PERMITTED_USER_ROLES
        )
      )
    end
  end
end
