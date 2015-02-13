json.array!(@announcements) do |announcement|
  json.extract! announcement, :id, :name, :text
  json.url announcement_url(announcement, format: :json)
end
