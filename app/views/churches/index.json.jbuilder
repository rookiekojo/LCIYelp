json.array!(@churches) do |church|
  json.extract! church, :id, :name, :address, :phone, :resident_Pastor
  json.url church_url(church, format: :json)
end
