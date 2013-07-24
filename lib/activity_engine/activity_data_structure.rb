module ActivityEngine
  ActivityDataStructure = Struct.new(
    :subject,
    :current_user,
    :message,
    :activity_type
  )
end
