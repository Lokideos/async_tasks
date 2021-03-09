# frozen_string_literal: true

class User < Sequel::Model
  USER_ROLES = {
    developer: 'developer',
    manager: 'manager'
  }.freeze

  plugin :association_dependencies

  one_to_one :task_assignment
  one_through_one :task, join_table: :task_assignments

  dataset_module do
    def developers_ids
      select(:id)
        .where(role: USER_ROLES[:developer])
        .map(:id)
    end
  end

  def validate
    super
    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
    validates_presence :role, message: I18n.t(:blank, scope: 'model.errors.user.role')
    validates_includes USER_ROLES.values, :role,
                       message: I18n.t(:wrong_type,
                                       scope: 'model.errors.user.role', types: USER_ROLES.values)
  end
end
