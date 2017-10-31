require_dependency 'patches/time_entry_cf_binder/time_entry_patch'
require_dependency 'patches/time_entry_cf_binder/time_entry_custom_field_patch'
require_dependency 'patches/time_entry_cf_binder/project_patch'
require_dependency 'patches/time_entry_cf_binder/tracker_patch'
require_dependency 'view_hooks/custom_field_hook'



Redmine::Plugin.register :time_entry_cf_binder do
  name 'Time entry custom field binder plugin'
  author 'Dmitry Glushchikov'
  description 'This is a plugin for Redmine binds time_entry custom fields to project and trackers (like issues)'
  version '.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

ActionDispatch::Callbacks.to_prepare do
  TimeEntry.send(:include, TimeEntryCustomFieldBinder::TimeEntryPatch)
  TimeEntryCustomField.send(:include,TimeEntryCustomFieldBinder::TimeEntryCustomFieldPatch)
  Project.send(:include, TimeEntryCustomFieldBinder::ProjectPatch)
  Tracker.send(:include, TimeEntryCustomFieldBinder::TrackerPatch)
end