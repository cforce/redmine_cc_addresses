class TicketMailer < Mailer
  layout false

  def new_ticket(issue, email)
    redmine_headers 'Project' => issue.project.identifier,
                  'Issue-Id' => issue.id,
                  'Issue-Author' => issue.author.login

    message_id issue
    recipients email
    subject "[#{issue.project.name} - #{issue.tracker.name} ##{issue.id}] (#{issue.status.name}) #{issue.subject}"
    body :issue => issue,
         :issue_url => url_for(:controller => 'issues', :action => 'show', :id => issue)
    render_multipart('new_ticket', body)
  end
end
