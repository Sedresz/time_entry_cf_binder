require_dependency 'time_entry'

module TimeEntryCustomFieldBinder

  module TimeEntryPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        belongs_to :tracker
      end
    end

    module InstanceMethods
      def available_custom_fields
        (project && issue && issue.tracker) ? (project.all_time_entry_custom_fields & issue.tracker.time_entry_custom_fields) : []
      end

      def visible_custom_field_values(user=nil)
        user_real = user || User.current
        custom_field_values.select do |value|
          value.custom_field.visible_by?(project, user_real)
        end
      end

    end
  end
end

