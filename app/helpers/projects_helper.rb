module ProjectsHelper
  def all_tickets(project)
    project.tickets.any? ? project.tickets.map { |ticket| { name: ticket.name, id: ticket.id }} : ['No tickets to show.']
  end
end
