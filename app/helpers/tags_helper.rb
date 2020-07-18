module TagsHelper
  def ticket_counts(tag)
    @tickets = Ticket.all 
    @tickets = @tickets.joins(:tags).where("tags.id": tag.id)
    @tickets.length
  end
end
