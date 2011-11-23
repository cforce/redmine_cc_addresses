module RedmineCcAddresses
  module Hooks
    class ViewIssuesEditNotesBottomHook < Redmine::Hook::ViewListener
      render_on :view_issues_edit_notes_bottom, :partial => 'issues/cc_addresses/do_not_send'
    end
  end
end
