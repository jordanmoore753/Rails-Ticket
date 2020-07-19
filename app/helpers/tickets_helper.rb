module TicketsHelper
  def all_tags(ticket)
    ticket.tags.any? ? ticket.tags.alphabetize.map(&:name).join(', ') : "-"
  end

  def all_comments(ticket)
    ticket.comments.any? ? ticket.comments.map { |comment| { creator: User.find(comment.creator_id).name, body: comment.body, created_at: comment.created_at }} : ["No comments."]
  end
end
