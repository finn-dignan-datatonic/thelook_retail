view: user_metrics {

  derived_table: {

sql:SELECT b.id,
avg(e.retail_price) as average_order_value,
count(a.order_id) as number_of_orders,
 (sum(e.retail_price)- sum(e.cost))/sum(e.retail_price) as customer_profit_margin,
 date_diff(max(a.created_at), min(a.created_at), DAY)/365 as retention_period,
 avg(e.retail_price) * count(a.order_id) * ( date_diff(max(a.created_at), min(a.created_at), DAY)/365) as ltv



 FROM `datatonic-analytics-sandbox.thelook.orders` as a
 left join  `datatonic-analytics-sandbox.thelook.users` as b on a.user_id = b.id

 left join (select c.order_id,
  sum(d.retail_price) as retail_price,
  sum(d.cost) as cost   from
  `datatonic-analytics-sandbox.thelook.order_items` as c
 left join `datatonic-analytics-sandbox.thelook.products` as d on c.product_id = d.id

 group by c.order_id) as e on e.order_id = a.order_id

 group by b.id
 order by number_of_orders desc;;

}

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }
  dimension: average_order_value {
    type: number
    sql: ${TABLE}.average_order_value ;;
  }

  dimension: number_of_orders {
    type: number
    sql: ${TABLE}.number_of_orders ;;
  }

  dimension: retention_period {
    type: number
    sql: ${TABLE}.retention_period ;;
  }

  dimension: profit_margin {
    type: number
    value_format: "0.00"
    sql: ${TABLE}.profit_margin ;;
  }

  dimension: ltv {
    type: number
    value_format: "0.00"
    sql: ${TABLE}.ltv ;;
  }

  dimension: customer_ltv {
    type: number
    value_format: "0.00"
    sql: ${TABLE}.profit_margin * ${TABLE}.ltv  ;;
  }

}
