# Product trackers

ProductTrackers describe the history of pickups and returns of a [Product](#products).

For trackable products, the [StockItemTracker](#stock-item-trackers) resource
provides additional details about individual [StockItems](#stock-items).

For products with multiple variations, the `product_group_id`
filter can be used to get the history for all variations at once.

## Relationships
Name | Description
-- | --
`employee` | **[Employee](#employees)** `required`<br>The [Employee](#employees) who handled the pickup/return. 
`order` | **[Order](#orders)** `required`<br>The [Order](#orders) the pickup/return was part of. 
`product` | **[Product](#products)** `required`<br>The [Product](#products) that was picked up/returned. 
`stock_item_trackers` | **[Stock item trackers](#stock-item-trackers)** `hasmany`<br>The [StockItems](#stock-items) that were picked up/returned. 


Check matching attributes under [Fields](#product-trackers-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the pickup/return happened. 
`employee_id` | **uuid** `readonly`<br>The [Employee](#employees) who handled the pickup/return. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly`<br>The [Order](#orders) the pickup/return was part of. 
`product_id` | **uuid** `readonly`<br>The [Product](#products) whose history is recorded. 
`quantity` | **integer** `readonly`<br>The quantity of the product being picked up or returned. Positive values are pickups, negative values are returns. 


## List product trackers


> How to fetch ProductTrackers for a ProductGroup:

```shell
  curl --get 'https://example.booqable.com/api/4/product_trackers'
       --header 'content-type: application/json'
       --data-urlencode 'filter[product_group_id][]=d7a52ec8-61c4-4405-8bdd-3911ff7ba281'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "4d26db5b-bd8d-490a-8eb2-df0412ccd31c",
        "type": "product_trackers",
        "attributes": {
          "created_at": "2021-03-17T06:03:01.000000+00:00",
          "updated_at": "2021-03-17T06:03:01.000000+00:00",
          "quantity": 3,
          "product_id": "30e88dbf-2592-4b19-80d2-4903316a701d",
          "employee_id": "0e75b7d3-da02-478a-8356-40e313b304bf",
          "order_id": "70d85e58-293c-464b-8b7a-69cfc91000a3"
        },
        "relationships": {}
      },
      {
        "id": "3a75336c-09b6-4ae4-8167-3f4354179bc6",
        "type": "product_trackers",
        "attributes": {
          "created_at": "2021-03-17T06:03:01.000000+00:00",
          "updated_at": "2021-03-17T06:03:01.000000+00:00",
          "quantity": -2,
          "product_id": "30e88dbf-2592-4b19-80d2-4903316a701d",
          "employee_id": "3147dc0f-b3e8-4baa-86d5-cdb07865806a",
          "order_id": "70d85e58-293c-464b-8b7a-69cfc91000a3"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/product_trackers`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[product_trackers]=created_at,quantity,product_id`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee,order,product`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`id` | **uuid** <br>`eq`, `not_eq`
`order_id` | **uuid** <br>`eq`, `not_eq`
`product_group_id` | **string** <br>`eq`, `not_eq`
`product_id` | **string** <br>`eq`, `not_eq`
`quantity` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>customer</code></li>
    </ul>
  </li>
  <li><code>product</code></li>
</ul>

