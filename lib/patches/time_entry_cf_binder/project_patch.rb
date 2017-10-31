require_dependency 'project'

module TimeEntryCustomFieldBinder

  module ProjectPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
	if base.respond_to?(:all_time_entry_custom_fields=)
          alias_method_chain :all_time_entry_custom_fields, :time_entry_cf_field_binder
	else
	  def all_time_entry_custom_fields
            if new_record?
              @all_time_entry_custom_fields ||= TimeEntryCustomField.
              sorted.
              where("is_for_all = ? OR id IN (?)", true, time_entry_custom_field_ids)
            else
              @all_time_entry_custom_fields ||= TimeEntryCustomField.
                sorted.
                where("is_for_all = ? OR id IN (SELECT DISTINCT cfp.custom_field_id" +
                " FROM #{table_name_prefix}custom_fields_projects#{table_name_suffix} cfp" +
                " WHERE cfp.project_id = ?)", true, id)
            end
          end
        end
      end
    end

    module InstanceMethods
      def all_time_entry_custom_fields_with_binder
        if new_record?
          @all_time_entry_custom_fields ||= TimeEntryCustomField.
            sorted.
            where("is_for_all = ? OR id IN (?)", true, time_entry_custom_field_ids)
        else
            @all_time_entry_custom_fields ||= TimeEntryCustomField.
              sorted.
              where("is_for_all = ? OR id IN (SELECT DISTINCT cfp.custom_field_id" +
              " FROM #{table_name_prefix}custom_fields_projects#{table_name_suffix} cfp" +
              " WHERE cfp.project_id = ?)", true, id)
        end
      end
    end
  end
end

