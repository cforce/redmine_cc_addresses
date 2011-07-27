class TicketMailer < Mailer
  layout false

  def new_ticket(issue, email)
    redmine_headers 'Project' => issue.project.identifier,
                  'Issue-Id' => issue.id,
                  'Issue-Author' => issue.author.login

    message_id issue
    recipients email
    subject "[#{issue.project.name} - #{issue.tracker.name} ##{issue.id}] #{issue.subject}"
    body :issue => issue,
         :issue_url => url_for(:controller => 'issues', :action => 'show', :id => issue)

    content_type "multipart/alternative"
    part :content_type => "text/plain", :body => render(:file => "new_ticket.text.plain.rhtml", :body => body)
    part :content_type => "text/html", :body => render_message("new_ticket.text.html.rhtml", body)
  end
end
