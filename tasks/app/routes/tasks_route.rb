# frozen_string_literal: true

class TasksRoute < Application
  route do |r|
    @tasks = Task.all

    r.is Integer do |task_id|
      @task = Task[task_id]

      r.get do
        if @task
          view('tasks/show')
        else
          r.redirect 'tasks'
        end
      end
    end

    r.get('new') do
      view('tasks/new')
    end

    r.post('create') do
      Task.create(params.merge(status: 'new'))

      r.redirect 'tasks'
    end

    r.get do
      view('tasks/index')
    end
  end

  private

  def params
    request.params
  end
end
