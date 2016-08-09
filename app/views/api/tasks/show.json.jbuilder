json.task do
  json.partial! partial: 'api/tasks/task', locals: {task: @task}
end