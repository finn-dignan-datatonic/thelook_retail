

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

  join: products_layer {
    type:  left_outer
    sql_on: ${order_items_layer.product_id} = ${products_layer.id} ;;
    relationship: one_to_many
  }

  join: distribution_centers_layer {
    type:  left_outer
    sql_on: ${products_layer.distribution_center_id} = ${distribution_centers_layer.id} ;;
    relationship: one_to_many
  }

  join: users_layer {
    type: left_outer
    sql_on: ${users_layer.id} = ${orders_layer.user_id} ;;
    relationship: many_to_one
  }



}
