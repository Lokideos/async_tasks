# frozen_string_literal: true

class TasksRoute < Application
  route do |r|
    r.is Integer do |task_id|
      @task = Task[task_id]

      r.get do
        if @task.present?
          response.status = 200
          @task.to_json
        else
          response.status = 404
          { status: 'not found' }.to_json
        end
      end
    end

    r.post do
      task_params = validate_with!(TaskParamsContract, params).to_h.values
      result = Tasks::CreateService.call(*task_params)

      if result.success?
        response.status = 201
        { status: 'created' }.to_json
      else
        response.status = 401
        error_response(result.task || result.errors)
      end
    end

    r.get do
      response.status = 200
      Task.all.to_json
    end
  end

  private

  def params
    request.params
  end
end
