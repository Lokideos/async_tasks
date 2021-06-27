# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its
# default values.
require 'pry-byebug'

# Create tasks
time = Time.now
times = [time, time]
tasks_data = [
  [
    'Add authentication',
    'All users has to be able to authenticate in our system',
    'assigned'
  ],
  [
    'Add verification',
    'All users has to be able to verify that the all are popugs',
    'unassigned'
  ],
  [
    'Add statistics',
    'All users has to be able to check their tasks statistics',
    'unassigned'
  ],
  [
    'Add madness',
    'All users has to be mad',
    'unassigned'
  ],
  [
    'Add cornfields',
    'All users has to be corn',
    'unassigned'
  ],
  [
    'Add anime',
    'All users has to become anime at some point',
    'unassigned'
  ],
  [
    'Add captcha bot to ruby chat',
    'All users has to become anime at some point',
    'completed'
  ]
]
tasks_data = tasks_data.map { |record| record.push(*times) }
Task.import(%i[title description status created_at updated_at], tasks_data)

users_data = [
  %w[Mark developer],
  %w[Tsar developer],
  %w[Imperator developer],
  %w[Overlord developer],
  %w[Bill manager]
]
users_data = users_data.map { |record| record.push(*times) }
User.import(%i[name role created_at updated_at], users_data)

task_ids = Task.map(&:id)
user_ids = User.where(role: 'developer').map(&:id)
task_assignments_data = task_ids.map do |task_id|
  [task_id, user_ids[rand(user_ids.length)]]
end
task_assignments_data = task_assignments_data.map { |record| record.push(*times) }

TaskAssignment.import(%i[task_id user_id created_at updated_at], task_assignments_data)
