module TicketsHelper
  def all_tags(ticket)
    ticket.tags.any? ? ticket.tags.map(&:name) : ["No tags to show."]
  end

  def all_comments(ticket)
    ticket.comments.any? ? ticket.comments.map { |comment| { creator: User.find(comment.creator_id).name, body: comment.body }} : ["No comments."]
  end
end
