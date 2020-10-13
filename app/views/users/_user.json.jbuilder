json.extract! user, :id, :email, :name, :position, :created_at, :updated_at
json.url user_url(user, format: :json)
