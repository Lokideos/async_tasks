# frozen_string_literal: true

module Tasks
  class CompleteService
    prepend BasicService

    param :task_id
    param :user_id

    attr_reader :task

    def call
      @task = Task.find(id: @task_id)
      return fail_t!(:not_found) unless @task.present?

      return fail_t!(:unauthorized) unless @user_id == @task.user.id

      @task.update(status: Task::COMPLETED_STATUS)
    end

    def fail_t!(key)
      fail!(I18n.t(key, scope: 'services.tasks.complete_service'))
    end
  end
end
