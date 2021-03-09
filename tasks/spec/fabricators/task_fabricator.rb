# frozen_string_literal: true

Fabricator(:task) do
  title { sequence { |n| "task_title_#{n}" } }
  description { sequence { |n| "task_description_#{n}" } }
  status { Task::INITIAL_STATUS }
end
