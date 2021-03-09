# frozen_string_literal: true

class Task < Sequel::Model
  plugin :association_dependencies

  one_to_one :task_assignment
  one_through_one :user, join_table: :task_assignments

  def validate
    super
    validates_presence :title, message: I18n.t(:blank, scope: 'model.errors.task.title')
    validates_presence :description, message: I18n.t(:blank, scope: 'model.errors.task.description')
    validates_presence :status, message: I18n.t(:blank, scope: 'model.errors.task.status')
  end
end
