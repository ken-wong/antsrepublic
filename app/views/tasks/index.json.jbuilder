json.array!(@tasks) do |task|
  json.extract! task, :id, :dead_line, :title, :description, :state
  json.url task_url(task, format: :json)
end
