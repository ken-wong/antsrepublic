json.task do
  json.partial! partial: 'api/attachments/attachment', locals: {attachment: @attachment}
end