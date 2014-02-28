json.array!(@churches) do |church|
  json.extract! church, 
  json.url church_url(church, format: :json)
end
