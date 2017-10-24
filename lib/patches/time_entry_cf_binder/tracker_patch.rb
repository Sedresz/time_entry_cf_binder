require_dependency 'tracker'

module TimeEntryCustomFieldBinder

  module TrackerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        has_and_belongs_to_many :time_entry_custom_fields, :class_name => 'TimeEntryCustomField', :join_table => "#{table_name_prefix}custom_fields_trackers#{table_name_suffix}", :association_foreign_key => 'custom_field_id'
      end
    end

    module InstanceMethods

    end

  end
end

