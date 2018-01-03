json.extract! person, :id, :name, :detail, :score, :created_at, :updated_at
json.url person_url(person, format: :json)
