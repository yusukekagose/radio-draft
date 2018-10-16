# json.array! @segments

json.array! @segments do |segment|
  json.id segment.id
  json.name segment.name
  json.status segment.status
  json.draft_count segment.drafts.count
end
