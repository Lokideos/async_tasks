# frozen_string_literal: true

class TasksRoute < Application
  route do |r|
    r.get do
      tasks = Task.all
      view('tasks/index', locals: { tasks: tasks })
    end
  end

  private

  def params
    request.params
  end
end
