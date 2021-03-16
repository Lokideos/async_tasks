class TaskSerializer
  include JSONAPI::Serializer

  set_type :task
  attributes :title, :description, :status
  has_one :user
end
