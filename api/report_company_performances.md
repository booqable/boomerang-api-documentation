# Report company performances

Report on overall company performance. Returns aggregated KPIs, charts, and
breakdowns for a given period. All data is returned via stats (no record attributes).

The report includes:

- Summary KPIs: total revenue, order count, new customers, total items ordered, and average order value
- Revenue over time and average order value over time (grouped by day, week, or month depending on date range)
- Top customers by revenue
- Orders by status breakdown
- Order metrics: fulfillment rate, average rental duration, average items per order
- Payment overview: collected, outstanding, deposits held, deposits outstanding
- Optional comparison with the previous year or previous period of the same duration

The report is filterable by date range, order statuses, location, and fulfillment type.
When a `comparison_type` is specified along with a date range, the response includes
a `previous_period` stat with the same metrics calculated for the comparison period,
plus percentage change indicators.

<aside class="notice">
  Availability of this report depends on the current pricing plan
  and the `company_performance_report` feature flag.
</aside>

## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.


## List company performance metrics


> How to fetch company performance:

```shell
  curl --get 'https://example.booqable.com/api/4/report_company_performances'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2017-08-24T02:52:01.000000+00:00'
       --data-urlencode 'filter[till]=2017-08-30T02:51:01.000000+00:00'
       --data-urlencode 'stats[new_customers][]=count'
       --data-urlencode 'stats[order_count][]=sum'
       --data-urlencode 'stats[order_statuses][]=count'
       --data-urlencode 'stats[revenue_in_cents][]=sum'
       --data-urlencode 'stats[revenue_over_time][]=count'
       --data-urlencode 'stats[top_customers][]=count'
```

> A 200 status response looks like this:

```json
  {
    "data": [],
    "meta": {
      "stats": {
        "new_customers": {
          "count": 1
        },
        "order_count": {
          "sum": 1
        },
        "order_statuses": {
          "count": {
            "new": 1
          }
        },
        "revenue_in_cents": {
          "sum": 0
        },
        "revenue_over_time": {
          "count": [
            {
              "period": "2017-08-27",
              "revenue_in_cents": 0,
              "order_count": 1
            }
          ]
        },
        "top_customers": {
          "count": [
            {
              "customer_id": "0cc5e684-0bb7-4717-8586-31529a3b9487",
              "name": "John Doe",
              "revenue_in_cents": 0,
              "order_count": 1,
              "revenue_percentage": 0.0
            }
          ]
        }
      }
    }
  }
```

> How to fetch company performance with comparison:

```shell
  curl --get 'https://example.booqable.com/api/4/report_company_performances'
       --header 'content-type: application/json'
       --data-urlencode 'filter[comparison_type]=last_year'
       --data-urlencode 'filter[from]=2015-12-15T07:06:00.000000+00:00'
       --data-urlencode 'filter[till]=2015-12-21T07:05:00.000000+00:00'
       --data-urlencode 'stats[order_count][]=sum'
       --data-urlencode 'stats[previous_period][]=count'
       --data-urlencode 'stats[revenue_in_cents][]=sum'
```

> A 200 status response looks like this:

```json
  {
    "data": [],
    "meta": {
      "stats": {
        "order_count": {
          "sum": 1
        },
        "previous_period": {
          "count": {
            "revenue_in_cents": 0,
            "order_count": 0,
            "new_customers": 0,
            "revenue_change": 0.0,
            "order_count_change": 0.0,
            "new_customers_change": 0.0,
            "aov_change": 0.0,
            "fulfillment_rate_change": 0.0,
            "avg_duration_change": 0.0,
            "total_items_change": 0.0,
            "avg_items_change": 0.0,
            "revenue_over_time": [],
            "aov_over_time": []
          }
        },
        "revenue_in_cents": {
          "sum": 0
        }
      }
    }
  }
```

### HTTP Request

`GET /api/4/report_company_performances`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`comparison_type` | **string** <br>`eq`
`from` | **datetime** <br>`eq`
`fulfillment_type` | **array** <br>`eq`
`location_ids` | **array** <br>`eq`
`order_statuses` | **array** <br>`eq`
`till` | **datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`aov_over_time` | **array** <br>`count`
`average_order_value_in_cents` | **array** <br>`sum`
`avg_items_per_order` | **array** <br>`sum`
`avg_rental_duration_in_seconds` | **array** <br>`sum`
`collected_in_cents` | **array** <br>`sum`
`deposit_held_in_cents` | **array** <br>`sum`
`deposit_outstanding_in_cents` | **array** <br>`sum`
`fulfillment_rate` | **array** <br>`sum`
`new_customers` | **array** <br>`count`
`order_count` | **array** <br>`sum`
`order_statuses` | **array** <br>`count`
`outstanding_in_cents` | **array** <br>`sum`
`previous_period` | **array** <br>`count`
`revenue_in_cents` | **array** <br>`sum`
`revenue_over_time` | **array** <br>`count`
`top_customers` | **array** <br>`count`
`total` | **array** <br>`count`
`total_items_ordered` | **array** <br>`sum`


### Includes

This request does not accept any includes