# Report rentals

Report on how rental products are performing. The report is filterable by date
and can be requested by one of the following turnover types:
`invoices`, `orders`.

<aside class="notice">
  Availability of this report depends on the current pricing plan.
</aside>

## Relationships
Name | Description
-- | --
`product` | **[Product](#products)** `required`<br>The rental [Product](#products) whose performance is reported.


Check matching attributes under [Fields](#report-rentals-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`charge_duration_in_seconds` | **integer** `readonly`<br>How many seconds were charged.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** `readonly`<br>Product name.
`planned_duration_in_seconds` | **integer** `readonly`<br>How many seconds the product was planned.
`product_id` | **uuid** <br>The rental [Product](#products) whose performance is reported.
`quantity` | **integer** `readonly`<br>Quantity in stock during period.
`rented_count` | **integer** `readonly`<br>How many times the product was rented out.
`turnover_in_cents` | **integer** `readonly`<br>Turnover during period.


## List performance for rental products


> How to fetch performance for products:

```shell
  curl --get 'https://example.booqable.com/api/4/report_rentals'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2019-11-20T14:14:00.000000+00:00'
       --data-urlencode 'filter[till]=2019-11-26T14:13:00.000000+00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "ea8dd06c-43e0-4211-8e56-7e9d41e46f35",
        "type": "report_rentals",
        "attributes": {
          "created_at": "2019-11-25T23:42:00.000000+00:00",
          "name": "Product 1000056",
          "charge_duration_in_seconds": 14400,
          "planned_duration_in_seconds": 14400,
          "rented_count": 2,
          "turnover_in_cents": 4000,
          "quantity": 10,
          "product_id": "c71a94f5-ca5b-4748-8f7a-ce7f18b4bb8a"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/report_rentals`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[report_rentals]=created_at,name,charge_duration_in_seconds`
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
`archived` | **boolean** <br>`eq`
`from` | **datetime** <br>`eq`
`location_id` | **uuid** <br>`eq`
`product_id` | **uuid** <br>`eq`
`q` | **string** <br>`eq`
`tag_list` | **array** <br>`eq`
`till` | **datetime** <br>`eq`
`tracking_type` | **string** <br>`eq`
`turnover_type` | **string** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`tag_list` | **array** <br>`count`
`total` | **array** <br>`count`
`tracking_type` | **array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







