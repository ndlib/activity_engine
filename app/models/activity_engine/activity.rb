require 'activity_engine/exceptions'
module ActivityEngine
  class Activity < ActiveRecord::Base
    def self.call(data)
      create! do |activity|
        activity.subject = data.subject
        activity.user = data.current_user
        activity.message = data.message
        activity.activity_type = data.activity_type
      end
    end
    default_scope { order("created_at DESC") }

    scope :for_user, lambda {|user| where(user: user)}
    scope :for_subject, lambda {|subject|
      where(subject_id: ActivityEngine.extract_subject_id(subject), subject_type: subject.class.to_s)
    }
    scope :for_activity_type, lambda {|activity_type|
      where(activity_type: activity_type)
    }
    scope :ascending_date, lambda { order("created_at ASC") }
    scope :descending_date, lambda { order("created_at DESC") }


    belongs_to :user

    def subject
      subject_type.constantize.find(subject_id)
    end

    def subject=(object)
      if object.persisted?
        write_attribute(:subject_type, object.class.to_s)
        write_attribute(:subject_id, ActivityEngine.extract_subject_id(object))
      else
        raise UnpersistedSubjectError.new(object)
      end
    end
  end
end
