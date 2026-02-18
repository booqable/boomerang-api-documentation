# Report stock items

Report on how stock items are performing. The report is filterable by date
and can be requested by one of the following revenue types:
`invoices`, `orders`.

<aside class="notice">
  Availability of this report depends on the current pricing plan.
</aside>

## Relationships
Name | Description
-- | --
`location` | **[Location](#locations)** `required`<br>[Location](#locations) where the stock item is stored. 
`product` | **[Product](#products)** `required`<br>The [Product](#products) whose performance is reported. 
`stock_item` | **[Report stock item](#report-stock-items)** `required`<br>The [StockItem](#stock-items) whose performance is reported. 


Check matching attributes under [Fields](#report-stock-items-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`charge_duration_in_seconds` | **integer** <br>How many seconds were charged. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`default_purchase_cost_in_cents` | **integer** <br>The default purchase cost from the product, used as fallback when no stock item purchase cost is set. 
`downtime_count` | **integer** <br>How many downtimes occurred for this product. 
`downtime_duration_in_seconds` | **integer** <br>How many seconds of downtime occurred for this product. 
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** <br>Stock item identifier. 
`location_id` | **uuid** <br>[Location](#locations) where the stock item is stored. 
`product_id` | **uuid** <br>The [Product](#products) whose performance is reported. 
`product_name` | **string** <br>Product name. 
`profit_in_cents` | **integer** <br>Profit during period, calculated as revenue minus the purchase cost. 
`purchase_cost_in_cents` | **integer** <br>The purchase cost of acquiring this stock item. 
`purchased_at` | **datetime** <br>The date this stock item was purchased. 
`q` | **string** `writeonly`<br>Query for a specific stock item. 
`rent_duration_in_seconds` | **integer** <br>How many seconds the product was rented out. 
`rented_count` | **integer** <br>How many times the product was rented out. 
`revenue_in_cents` | **integer** <br>Revenue during period. 
`roi_percentage` | **float** <br>Return on investment in percentage points, calculated as (profit divided by purchase cost) multiplied by 100. 
`stock_item_id` | **uuid** <br>The [StockItem](#stock-items) whose performance is reported. 
`temporary` | **boolean** <br>Whether this stock item is temporary. 


## List performance for stock items


> How to fetch performance for stock items:

```shell
  curl --get 'https://example.booqable.com/api/4/report_stock_items'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2028-06-10T02:07:00.000000+00:00'
       --data-urlencode 'filter[till]=2028-06-16T02:06:00.000000+00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "5f25a378-68e0-4a95-863a-9adc03ae17e7",
        "type": "report_stock_items",
        "attributes": {
          "created_at": "2028-06-15T18:42:00.000000+00:00",
          "product_name": "Product 1000066",
          "identifier": "id1000190",
          "charge_duration_in_seconds": 7200,
          "rent_duration_in_seconds": 7200,
          "rented_count": 1,
          "downtime_count": 0,
          "downtime_duration_in_seconds": 0,
          "purchase_cost_in_cents": null,
          "default_purchase_cost_in_cents": null,
          "purchased_at": null,
          "temporary": false,
          "revenue_in_cents": 2000,
          "profit_in_cents": null,
          "roi_percentage": null,
          "stock_item_id": "900e48a7-b2af-464c-830a-b2f0a09aebf5",
          "product_id": "2e16282a-9ed0-48f3-8810-cb74f0570bc0",
          "location_id": null
        },
        "relationships": {}
      },
      {
        "id": "48182ded-c678-4f69-86e3-3889e19faf6d",
        "type": "report_stock_items",
        "attributes": {
          "created_at": "2028-06-15T18:42:00.000000+00:00",
          "product_name": "Product 1000066",
          "identifier": "id1000191",
          "charge_duration_in_seconds": 0,
          "rent_duration_in_seconds": 0,
          "rented_count": 0,
          "downtime_count": 0,
          "downtime_duration_in_seconds": 0,
          "purchase_cost_in_cents": null,
          "default_purchase_cost_in_cents": null,
          "purchased_at": null,
          "temporary": false,
          "revenue_in_cents": 2000,
          "profit_in_cents": null,
          "roi_percentage": null,
          "stock_item_id": "6ce9ed33-92eb-48b1-8528-75f4d4503cc9",
          "product_id": "2e16282a-9ed0-48f3-8810-cb74f0570bc0",
          "location_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/report_stock_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[report_stock_items]=created_at,product_name,identifier`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=stock_item,product`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`from` | **datetime** <br>`eq`
`location_id` | **uuid** <br>`eq`
`product_id` | **uuid** <br>`eq`
`q` | **string** <br>`eq`
`revenue_type` | **string** <br>`eq`
`stock_item_id` | **uuid** <br>`eq`
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
  <li><code>stock_item</code></li>
</ul>

