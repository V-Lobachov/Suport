class TicketMailer < ActionMailer::Base
  def ticket_registration ticket
  	@ticket = ticket
  	mail to: @ticket.email,from: "suport@application.com", subject: @ticket.issue
  end

  def responce ticket, message
  	@responce = message
  	@ticket = ticket
  	mail to: @ticket.email,from: "suport@application.com", subject: "#{@ticket.issue} Reply"
  end

  def change_owner ticket, owner
  	@owner = owner
  	@ticket = ticket
  	mail to: @ticket.email,from: "suport@application.com", subject: "#{@ticket.issue} Reply"
  end

  def on_hold ticket
  	@ticket = ticket
  	mail to: @ticket.email,from: "suport@application.com", subject: "#{@ticket.issue} Reply"
  end

  def completed ticket
  	@ticket = ticket
  	mail to: @ticket.email,from: "suport@application.com", subject: "#{@ticket.issue} Reply"
  end

  def canceled ticket
  	@ticket = ticket
  	mail to: @ticket.email,from: "suport@application.com", subject: "#{@ticket.issue} Reply"
  end
end
