module RedmineCcAddresses
  module Hooks
    class ViewIssuesHistoryJournalBottomHook < Redmine::Hook::ViewListener
      render_on :view_issues_history_journal_bottom, :partial => 'issues/cc_addresses/journal_bottom'
    end
  end
end
