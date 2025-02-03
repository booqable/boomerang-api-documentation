# Report consumables

Report on how consumable products are performing. The report is filterable
by date and can be requested by one of the following turnover types:
`invoices`, `orders`.

<aside class="notice">
  Availability of this report depends on the current pricing plan.
</aside>

## Relationships
Name | Description
-- | --
`product` | **[Product](#products)** `required`<br>The consumable product whose performance is reported.


Check matching attributes under [Fields](#report-consumables-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** <br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>Product name.
`product_id` | **uuid** <br>The consumable product whose performance is reported.
`q` | **string** `writeonly`<br>Query for a specific product.
`sold` | **integer** <br>Amount of times the product was sold.
`turnover_in_cents` | **integer** <br>Turnover during period.


## List performance for consumables products


> How to fetch performance for consumables:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/report_consumables'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2017-08-15T03:42:01.000000+00:00'
       --data-urlencode 'filter[till]=2017-08-21T03:41:01.000000+00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "9f5e212f-8f15-4b27-8d57-7820f511ad8e",
        "type": "report_consumables",
        "attributes": {
          "created_at": "2017-08-20T13:18:01.000000+00:00",
          "name": "Product 1000054",
          "sold": 2,
          "turnover_in_cents": 10000,
          "product_id": "9f5e212f-8f15-4b27-8d57-7820f511ad8e"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/report_consumables`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[report_consumables]=created_at,name,sold`
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
`product_id` | **uuid** <br>`eq`
`q` | **string** <br>`eq`
`tag_list` | **array** <br>`eq`
`till` | **datetime** <br>`eq`
`turnover_type` | **string** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`tag_list` | **array** <br>`count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







