

# include all the views
include: "/thelook_db/**/*.view"
# include: "/thelook_db/01_base_layers/order_items.layer.view"


# explore: orders_layer {

#   view_name: orders_layer
# }

explore: user_metrics {
  view_name: users_layer

  join: user_metrics {
    type: left_outer
    sql_on: ${user_metrics.id} = ${users_layer.id} ;;
    relationship: one_to_one
  }


}
