# frozen_string_literal: true

class TaskAssignment < Sequel::Model
  PERMITTED_USER_ROLES = %w[developer].freeze

  plugin :association_dependencies

  many_to_one :task
  many_to_one :user

  def validate
    super
    validates_unique :task_id
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
