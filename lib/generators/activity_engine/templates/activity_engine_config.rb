# ActivityEngine.for_models('ModelName') do |builder|
#   builder.register_call(:foo) do |activity,context|
#     activity.subject = context.page
#     activity.current_user = context.current_user
#     activity.activity_type = 'pages#show'
#     activity.message = "A particulare message?"
#   end
#   builder.register_controller('ModelNamesController', 'create')
# end
#
