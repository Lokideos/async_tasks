# frozen_string_literal: true

namespace :db do
  desc 'Prints current schema version'
  task version: :settings do
    Sequel.extension :migration

    @db = Sequel.connect(Settings.db.to_hash)

    version = (@db[:schema_info].first[:version] if @db.tables.include?(:schema_info)) || 0

    puts "Schema Version: #{version}"
  end
end
