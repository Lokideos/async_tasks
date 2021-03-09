# frozen_string_literal: true

module Tasks
  class MassAssignmentService
    prepend BasicService

    attr_reader :tasks

    def call
      @tasks = Task.eager.non_closed_tasks.all
      developers_ids = User.developers_ids
      current_time = Time.now
      task_assignments = []
      @tasks.each do |task|
        task_assignments << [
          task.id,
          developers_ids[rand(developers_ids.length - 1)],
          current_time,
          current_time
        ]
      end

      TaskAssignment.where(task_id: Task.assigned_tasks.map(:id)).destroy
      TaskAssignment.import(%i[task_id user_id created_at updated_at], task_assignments)
      Task.non_closed_tasks.update(status: Task::ASSIGNED_STATUS)
    rescue StandardError => e
      fail!(e.message)
    end
  end
end
