# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its
# default values.

# Create tasks
tasks = []
tasks_data = [
  {
    title: 'Add authentication',
    description: 'All users has to be able to authenticate in our system',
    status: 'unassigned'
  },
  {
    title: 'Add verification',
    description: 'All users has to be able to verify that the all are popugs',
    status: 'unassigned'
  }
]

tasks_data.each do |task_data|
  tasks << Task.create(task_data)
end

users = []
users_data = [
  {
    name: 'Mark',
    role: 'developer'
  },
  {
    name: 'Bill',
    role: 'manager'
  }
]
users_data.each do |user_data|
  users << User.create(user_data)
end
