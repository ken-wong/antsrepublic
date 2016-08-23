json.attachments do
  json.partial! 'api/attachments/attachment', collection: @attachments, as: :attachment
end