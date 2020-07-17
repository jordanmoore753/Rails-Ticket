module TicketsHelper
  def all_tags(ticket)
    ticket.tags.any? ? ticket.tags.map(&:name) : ["No tags to show."]
  end
end
