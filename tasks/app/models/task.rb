# frozen_string_literal: true

class Task < Sequel::Model
  plugin :association_dependencies

  def validate
    validates_presence :title, message: I18n.t(:blank, scope: 'model.errors.task.title')
    validates_presence :description, message: I18n.t(:blank, scope: 'model.errors.task.description')
    validates_presence :status, message: I18n.t(:blank, scope: 'model.errors.task.status')
  end
end
