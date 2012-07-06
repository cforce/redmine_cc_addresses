module RedmineCcAddresses
  module Hooks
    class ControllerIssuesEditBeforeSaveHook < Redmine::Hook::ViewListener
      def controller_issues_edit_before_save(context={})
        if context[:params][:do_not_send_cc]
          context[:journal].do_not_send_cc = true
        end
      end
    end
  end
end
