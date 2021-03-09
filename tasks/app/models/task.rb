# frozen_string_literal: true

class Task < Sequel::Model
  INITIAL_STATUS = 'unassigned'
  ASSIGNED_STATUS = 'assigned'
  CLOSED_STATUS = 'closed'
  ALLOWED_STATUSES = [INITIAL_STATUS, ASSIGNED_STATUS, CLOSED_STATUS].freeze

  plugin :association_dependencies

  one_to_one :task_assignment
  one_through_one :user, join_table: :task_assignments

  dataset_module do
    def non_closed_tasks
      select_all
        .where(status: INITIAL_STATUS).or(status: ASSIGNED_STATUS)
    end

    def assigned_tasks
      select_all
        .where(status: ASSIGNED_STATUS)
    end
  end

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

  # For correct work of jsonapi-serializer gem
  def user_id
    user.id
  end
end
