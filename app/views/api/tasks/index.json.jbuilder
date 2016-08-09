json.tasks do
  json.partial! 'api/tasks/task', collection: @tasks, as: :task
end