class TicketMailer < Mailer
  layout false

  def new_ticket(issue, email)
    TicketMailer.new_ticket_headers.each do |k, v|
      headers[k] = v
    end

    redmine_headers 'Project' => issue.project.identifier,
                  'Issue-Id' => issue.id,
                  'Issue-Author' => issue.author.login

    from issue.project.email if issue.project.respond_to?(:email)

    message_id issue
    recipients email
    subject "[#{issue.project.name} - #{issue.tracker.name} ##{issue.id}] #{issue.subject}"
    body :issue => issue,
         :issue_url => url_for(:controller => 'issues', :action => 'show', :id => issue),
         :from => from

    content_type "multipart/alternative"
    part :content_type => "text/plain", :body => render(:file => "new_ticket.text.plain.rhtml", :body => body)
    part :content_type => "text/html", :body => render_message("new_ticket.text.html.rhtml", body)
  end

  class << self
    def new_ticket_headers=(headers)
      @new_ticket_headers = headers if headers.is_a? Hash
    end

    def new_ticket_headers
      @new_ticket_headers || []
    end
  end
end
