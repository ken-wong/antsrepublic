json.plans do
  json.partial! 'api/plans/plan', collection: @plans, as: :plan
end