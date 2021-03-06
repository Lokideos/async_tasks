# frozen_string_literal: true

module Users
  class CreateService
    prepend BasicService

    param :name
    param :email
    param :role
    param :password

    attr_reader :user

    def call
      @user = ::User.new(name: @name, email: @email, role: @role, password: @password)

      if @user.valid?
        @user.save
        EventProducer.send_event('user created', 'CUD', @user)
      else
        fail!(@user.errors)
      end
    end
  end
end
