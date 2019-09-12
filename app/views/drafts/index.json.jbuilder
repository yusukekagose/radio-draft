json.array! @drafts do |draft|
  json.id draft.id
  json.title draft.title
  json.content  draft.content
  json.created_at draft.created_at
  json.updated_at draft.updated_at
  json.radio_name  draft.radio.name
  json.radio_id  draft.radio_id
  json.destination draft.radio&.destination
  json.segment_name draft.segment&.name || ""
  json.status draft.status
  json.keyword draft.title + draft.content + draft.radio.name + draft.segment&.name.to_s
end
