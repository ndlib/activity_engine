require 'satchel/exceptions'
module Satchel
  class Activity < ActiveRecord::Base
    def self.call(data)
      create! do |activity|
        activity.subject = data.subject
        activity.user = data.current_user
        activity.message = data.message
        activity.activity_type = data.activity_type
      end
    end

    belongs_to :user

    def subject
      subject_type.constantize.find(subject_id)
    end

    def subject=(object)
      if object.persisted?
        write_attribute(:subject_type, object.class.to_s)
        write_attribute(:subject_id, object.to_param)
      else
        raise UnpersistedSubjectError.new(object)
      end
    end
  end
end
