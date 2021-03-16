# frozen_string_literal: true

class AuthRoute < Application
  route do |r|
    r.on 'signup' do
      r.post do
        user_params = validate_with!(UserParamsContract, params).to_h.values
        result = Users::CreateService.call(*user_params)

        if result.success?
          response.status = 201
          { status: 'created' }.to_json
        else
          response.status = 422
          error_response(result.user)
        end
      end
    end
  end

  private

  def params
    request.params
  end
end
