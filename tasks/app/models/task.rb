# frozen_string_literal: true

class Task < Sequel::Model
  INITIAL_STATUS = 'unassigned'
  ALLOWED_STATUSES = (%w[assigned] + [INITIAL_STATUS]).freeze

  plugin :association_dependencies

  one_to_one :task_assignment
  one_through_one :user, join_table: :task_assignments

  def validate
    super
    validates_presence :title, message: I18n.t(:blank, scope: 'model.errors.task.title')
    validates_presence :description, message: I18n.t(:blank, scope: 'model.errors.task.description')
    validates_presence :status, message: I18n.t(:blank, scope: 'model.errors.task.status')
    validates_includes ALLOWED_STATUSES,
                       :status,
                       message: I18n.t(:wrong_status,
                                       scope: 'model.errors.task.status',
                                       statuses: ALLOWED_STATUSES)
  end
end
