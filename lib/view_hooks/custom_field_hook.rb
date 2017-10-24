module TimeEntryCustomFieldBinder
  module TimeEntryCustomFieldBinder
    class CustomFieldHook  < Redmine::Hook::ViewListener
      render_on :view_custom_fields_form_time_entry_custom_field, :partial => 'custom_fields/cf_time_entry'
    end
  end
end