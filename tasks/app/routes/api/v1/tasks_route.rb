# frozen_string_literal: true

class TasksRoute < Application
  route do |r|
    r.is Integer do |task_id|
      @task = Task[task_id]

      r.get do
        if @task.present?
          serializer = TaskSerializer.new(@task)

          response.status = 200
          serializer.serializable_hash.to_json
        else
          response.status = 404
          { status: 'not found' }.to_json
        end
      end
    end

    r.post 'mass_assignment' do
      result = Tasks::MassAssignmentService.call

      if result.success?
        serializer = TaskSerializer.new(result.tasks)

        response.status = 204
        serializer.serializable_hash.to_json
      else
        response.status = 401
        error_response(result.errors)
      end
    end

    r.post do
      task_params = validate_with!(TaskParamsContract, params).to_h.values
      result = Tasks::CreateService.call(*task_params)

      if result.success?
        serializer = TaskSerializer.new(result.task)

        response.status = 201
        serializer.serializable_hash.to_json
      else
        response.status = 401
        error_response(result.task || result.errors)
      end
    end

    r.get do
      page = params[:page].presence || 1
      tasks = Task.reverse_order(:created_at)
      tasks = tasks.paginate(page.to_i, Settings.pagination.page_size)
      serializer = TaskSerializer.new(tasks.all, links: pagination_links(tasks))

      response.status = 200
      serializer.serializable_hash.to_json
    end
  end

  private

  def params
    request.params
  end
end
