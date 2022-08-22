
view: orders_layer {
  sql_table_name: `thelook.orders`
    ;;
  drill_fields: [order_id]

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    drill_fields: [user_id, products_layer.name, distribution_centres.layer.name]
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: num_of_item {
    type: number
    sql: ${TABLE}.num_of_item ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: order_to_ship {
    type: number
    value_format_name: decimal_2
    # hidden: yes
    sql: timestamp_diff(${shipped_raw}, ${created_raw},  DAY)  ;;
  }

  dimension: ship_to_delivery {
    type: number
    # hidden: yes
    sql: timestamp_diff(${delivered_raw}, ${shipped_raw}, DAY)  ;;
  }

  measure: is_returned {
    type: number
    value_format_name: percent_2
    # hidden: yes
    sql: sum(case when ${status} = "Returned" then 1 else 0 end)/count(*)  ;;
  }

  measure: items_per_order {
    type: number
    value_format_name: decimal_2
    # hidden: yes
    sql: ${order_items_layer.count}/${count}  ;;
  }

  measure: count {
    type: count
    drill_fields: [order_id, users.last_name, users.id, users.first_name, order_items.count]
  }
}
