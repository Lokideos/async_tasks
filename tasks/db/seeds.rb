# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its
# default values.

# Create tasks
tasks = []
tasks_data = [
  {
    title: 'Add authentication',
    description: 'All users has to be able to authenticate in our system',
    status: 'assigned'
  },
  {
    title: 'Add verification',
    description: 'All users has to be able to verify that the all are popugs',
    status: 'unassigned'
  },
  {
    title: 'Add statistics',
    description: 'All users has to be able to check their tasks statistics',
    status: 'unassigned'
  },
  {
    title: 'Add madness',
    description: 'All users has to be mad',
    status: 'unassigned'
  },
  {
    title: 'Add cornfields',
    description: 'All users has to be corn',
    status: 'unassigned'
  },
  {
    title: 'Add anime',
    description: 'All users has to become anime at some point',
    status: 'unassigned'
  },
  {
    title: 'Add captcha bot to ruby chat',
    description: 'All users has to become anime at some point',
    status: 'closed'
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
    name: 'Tsar',
    role: 'developer'
  },
  {
    name: 'Imperator',
    role: 'developer'
  },
  {
    name: 'Overlord',
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

TaskAssignment.create(task_id: tasks.last.id, user_id: users.first.id)
TaskAssignment.create(task_id: tasks.first.id, user_id: users.first.id)
