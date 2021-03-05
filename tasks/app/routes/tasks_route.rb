# frozen_string_literal: true

class TasksRoute < Application
  route do |r|
    @tasks = Task.all

    r.is Integer do |task_id|
      @task = Task[task_id]

      r.get do
        view('tasks/show') if @task
      end
    end

    r.get('new') do
      view('tasks/new')
    end

    r.post('create') do
      task_params = validate_with!(TaskParamsContract, params).to_h.values
      result = Tasks::CreateService.call(*task_params)

      if result.success?
        r.redirect '/'
      else
        view('tasks/new')
      end
    end

    r.get do
      new_task_path = 'tasks/new'
      view('tasks/index', locals: { new_task_path: new_task_path })
    end
  end

  private

  def params
    request.params
  end
end
