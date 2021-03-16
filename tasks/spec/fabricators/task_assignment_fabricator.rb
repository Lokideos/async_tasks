# frozen_string_literal: true

Fabricator(:task_assignment) do
  task { Fabricate(:task, status: Task::ASSIGNED_STATUS) }
  user
end
