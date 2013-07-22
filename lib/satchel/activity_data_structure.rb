module Satchel
  if !defined?(ActivityDataStructure)
    ActivityDataStructure = Struct.new(:subject, :current_user, :message, :activity_type)
  end
end