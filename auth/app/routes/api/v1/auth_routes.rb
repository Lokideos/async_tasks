# frozen_string_literal: true

class AuthRoutes < Application
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

    r.on 'login' do
      r.post do
        session_params = validate_with!(SessionParamsContract, params).to_h.values
        result = UserSessions::CreateService.call(*session_params)

        if result.success?
          token = JwtEncoder.encode(uuid: result.session.uuid)
          meta = { token: token }

          response.status = 201
          { meta: meta }.to_json
        else
          response.status = 401
          error_response(result.session || result.errors)
        end
      end
    end
  end

  private

  def params
    request.params
  end
end
