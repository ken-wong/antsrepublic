json.plan do
  json.partial! partial: 'api/plans/plan', locals: {plan: @plan}
end