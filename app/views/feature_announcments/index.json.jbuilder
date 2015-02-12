json.array!(@feature_announcments) do |feature_announcment|
  json.extract! feature_announcment, :id, :name, :text
  json.url feature_announcment_url(feature_announcment, format: :json)
end
