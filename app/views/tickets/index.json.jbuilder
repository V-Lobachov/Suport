json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :name, :email, :issue, :body, :reference, :status
  json.url ticket_url(ticket, format: :json)
end
