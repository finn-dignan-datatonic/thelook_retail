

# include all the views
include: "/thelook_db/**/*.view"
# include: "/thelook_db/01_base_layers/order_items.layer.view"


# explore: orders_layer {

#   view_name: orders_layer
# }

explore: orders_layer {
  view_name: orders_layer
  join: order_items_layer {
    type: left_outer
    sql_on: ${orders_layer.order_id} = ${order_items_layer.order_id} ;;
    relationship: one_to_many
  }
}
