# frozen_string_literal: true

class UsersRoute < Application
  route do |r|
    r.is Integer do |user_id|
      @user = User[user_id]

      r.get do
        if @user.present?
          serializer = UserSerializer.new(@user)

          response.status = 200
          serializer.serializable_hash.to_json
        else
          response.status = 404
          { status: 'not found' }.to_json
        end
      end
    end
  end

  private

  def params
    request.params
  end
end
