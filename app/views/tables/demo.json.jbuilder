json.Result "OK"
json.TotalRecordCount @nivels_count
json.Records do
  json.array!(@nivels) do |nivel|
    json.nivels__id visitor.id
    json.nivels__nombre nivel.nombre
    json.nivels__rangomaximo nivel.rangomaximo
    json.nivels__nombre nivel.nombre
  end
end