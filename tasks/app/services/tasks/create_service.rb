# frozen_string_literal: true

module Tasks
  class CreateService
    prepend BasicService

    param :title
    param :description

    attr_reader :task

    def call
      @task = Task.new(title: @title, description: @description, status: 'new')

      if @task.valid?
        @task.save
      else
        fail!(@task.errors)
      end
    end
  end
end
