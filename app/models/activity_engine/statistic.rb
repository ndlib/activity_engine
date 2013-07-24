module ActivityEngine
  class Statistic
    attr_accessor :activity_type, :count, :last_activity_date, :subject

    def initialize(subject, opts)
      @subject = subject
      opts.each_pair do |key, value|
        send("#{key}=", value)
      end
    end
  end
end
