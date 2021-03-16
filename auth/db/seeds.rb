# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.

# Create users
users = []
user_data = [{ name: 'Bob', email: 'bob@example.com', role: 'admin', password: 'givemeatoken' },
             { name: 'Eva', email: 'bob@example.com', role: 'manager', password: 'givemeatoken' },
             { name: 'Alice', email: 'alice@example.com', role: 'developer',
               password: 'givemeatoken' }]
user_data.each do |user|
  users << User.create(user)
end
