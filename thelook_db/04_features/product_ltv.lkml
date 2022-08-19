view: customer_ltv {

  derived_table: {
    sql:;;
  }
  dimension: customer_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.customer_id ;;
  }
  measure: ltv {
    type: number

    sql: ${TABLE}.ltv ;;
  }
  measure: profit_margin {
    type: number
    value_format: "0.00"
    sql: ${TABLE}.profit_margin ;;
  }

  measure: customer_ltv {
    type: number
    value_format: "0.00"
    sql: ${TABLE}.profit_margin * ${TABLE}.ltv  ;;
  }


}
