json.queens do
  json.partial! 'api/queens/queen', collection: @queens, as: :queen
end