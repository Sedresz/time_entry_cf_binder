require_dependency 'time_entry_custom_field'

module TimeEntryCustomFieldBinder

  module TimeEntryCustomFieldPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
          has_and_belongs_to_many :projects, :join_table => "#{table_name_prefix}custom_fields_projects#{table_name_suffix}", :foreign_key => "custom_field_id"
          has_and_belongs_to_many :trackers, :join_table => "#{table_name_prefix}custom_fields_trackers#{table_name_suffix}", :foreign_key => "custom_field_id"
	  if Redmine::VERSION::MAJOR == 3 and Redmine::VERSION::MINOR >= 2
	    safe_attributes 'project_ids',
                            'tracker_ids'
          end

      end
    end

    module InstanceMethods

    end
  end
end

