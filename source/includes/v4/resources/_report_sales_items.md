# Report sales items

Report on how sales items are performing. The report is filterable
by date and can be requested by one of the following revenue types:
`invoices`, `orders`.

<aside class="notice">
  Availability of this report depends on the current pricing plan.
</aside>

## Relationships
Name | Description
-- | --
`product` | **[Product](#products)** `required`<br>The sales item [Product](#products) whose performance is reported.


Check matching attributes under [Fields](#report-sales-items-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** <br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>Product name.
`product_id` | **uuid** <br>The sales item [Product](#products) whose performance is reported.
`q` | **string** `writeonly`<br>Query for a specific product.
`revenue_in_cents` | **integer** <br>Revenue during period.
`sold` | **integer** <br>Amount of times the product was sold.


## List performance for sales items


> How to fetch performance for sales items:

```shell
  curl --get 'https://example.booqable.com/api/4/report_sales_items'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2024-01-22T11:37:50.000000+00:00'
       --data-urlencode 'filter[till]=2024-01-28T11:36:50.000000+00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "4d363f2a-947b-4b3e-87d7-4b872034c7e5",
        "type": "report_sales_items",
        "attributes": {
          "created_at": "2024-01-27T20:22:50.000000+00:00",
          "name": "Product 1000065",
          "sold": 2,
          "revenue_in_cents": 10000,
          "product_id": "a9383693-1d72-4916-828c-315b2662eaf4"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/report_sales_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[report_sales_items]=created_at,name,sold`
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
`revenue_type` | **string** <br>`eq`
`tag_list` | **array** <br>`eq`
`till` | **datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`tag_list` | **array** <br>`count`
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

