# frozen_string_literal: true

require 'sequel/core'

namespace :db do
  desc 'Create database'
  task create: :settings do
    connection_parameters = %i[adapter host port user password]

    Sequel.connect(Settings.db.to_hash.slice(*connection_parameters)) do |db|
      db.execute "CREATE DATABASE #{Settings.db.to_hash[:database]}"
    end
    Rake::Task['db:add_extensions'].execute
  end
end
