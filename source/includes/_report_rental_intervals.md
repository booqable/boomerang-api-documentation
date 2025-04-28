# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

<aside class="notice">
  Availability of this report depends on the current pricing plan.
</aside>

## Relationships
Name | Description
-- | --
`product` | **[Product](#products)** `required`<br>The [Product](#products) whose rental performance is reported.


Check matching attributes under [Fields](#report-rental-intervals-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`date` | **date** <br>Interval date.
`id` | **uuid** `readonly`<br>Primary key.
`interval` | **string** <br>The interval of the breakdown.
`product_id` | **uuid** <br>The [Product](#products) whose rental performance is reported.
`rented_count` | **integer** <br>Times the product was rented.


## List performance for a rental product per interval


> How to fetch performance per interval for a product:

```shell
  curl --get 'https://example.booqable.com/api/4/report_rental_intervals'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2028-12-12T19:20:04.000000+00:00'
       --data-urlencode 'filter[product_id]=11b593b2-23b2-4a0d-8630-f08bdc6a363f'
       --data-urlencode 'filter[till]=2028-12-22T19:19:04.000000+00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "f0ceb5ce-caa0-40d5-8c27-fd4607e62568",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-18",
          "rented_count": 0,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      },
      {
        "id": "6d2b8548-3a4f-41c4-8e33-f88cab6ed721",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-19",
          "rented_count": 0,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      },
      {
        "id": "ccd4c262-738d-415e-8388-832ee4be4870",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-20",
          "rented_count": 0,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      },
      {
        "id": "cb0cd33c-98ec-4f6a-81e4-3450cfe6c7bd",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-21",
          "rented_count": 0,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      },
      {
        "id": "85422c5f-f84a-4fc1-870c-24f6f3762c41",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-22",
          "rented_count": 1,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      },
      {
        "id": "c344a030-1398-4dc8-8066-90f990c9d65f",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-23",
          "rented_count": 0,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      },
      {
        "id": "0d56a56a-529b-419e-834d-b8a2316f15a8",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-24",
          "rented_count": 1,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      },
      {
        "id": "8a916c0a-b234-4b15-8df7-1f4f2d325746",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-25",
          "rented_count": 0,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      },
      {
        "id": "894bfe67-ec44-49cb-801b-dd2525745c92",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-26",
          "rented_count": 1,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      },
      {
        "id": "947020ed-c624-4f6f-8c35-ab29ccbc48b6",
        "type": "report_rental_intervals",
        "attributes": {
          "date": "2025-04-27",
          "rented_count": 0,
          "interval": "day",
          "product_id": "11b593b2-23b2-4a0d-8630-f08bdc6a363f"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/report_rental_intervals`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=product`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`from` | **datetime** <br>`eq`
`product_id` | **uuid** `required`<br>`eq`
`till` | **datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>product</code>
    <ul>
      <li><code>photo</code></li>
    </ul>
  </li>
</ul>

