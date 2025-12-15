# Stock item trackers

StockItemTrackers describe the history of pickups and returns of a StockItem.

## Relationships
Name | Description
-- | --
`product_tracker` | **[Product tracker](#product-trackers)** `required`<br>The associated ProductTracker, which contains links to the product, and order this pickup/return is done for. 
`stock_item` | **[Stock item](#stock-items)** `required`<br>The StockItem being tracked. 


Check matching attributes under [Fields](#stock-item-trackers-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`product_tracker_id` | **uuid** `readonly`<br>The associated ProductTracker, which contains links to the product, and order this pickup/return is done for. 
`quantity` | **integer** `readonly`<br>Either 1 (pickup) or -1 (return). 
`stock_item_id` | **uuid** `readonly`<br>The StockItem being tracked. 


## List stock item trackers


> How to fetch StockItemTrackers for a ProductGroup:

```shell
  curl --get 'https://example.booqable.com/api/4/stock_item_trackers'
       --header 'content-type: application/json'
       --data-urlencode 'filter[product_group_id][]=7acf92e9-02ae-4343-8ffa-f074055db051'
       --data-urlencode 'include=stock_item'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "5b3fc0de-c150-4f2e-85fd-c245689d467d",
        "type": "stock_item_trackers",
        "attributes": {
          "created_at": "2028-12-11T13:35:01.000000+00:00",
          "updated_at": "2028-12-11T13:35:01.000000+00:00",
          "quantity": 1,
          "product_tracker_id": "8dace30b-0c62-4a74-89ff-c8129adcb4a4",
          "stock_item_id": "0ae288b0-b7ff-4dbd-88dc-1fd225fd8e64"
        },
        "relationships": {
          "stock_item": {
            "data": {
              "type": "stock_items",
              "id": "0ae288b0-b7ff-4dbd-88dc-1fd225fd8e64"
            }
          }
        }
      }
    ],
    "included": [
      {
        "id": "0ae288b0-b7ff-4dbd-88dc-1fd225fd8e64",
        "type": "stock_items",
        "attributes": {
          "created_at": "2028-12-11T13:35:01.000000+00:00",
          "updated_at": "2028-12-11T13:35:01.000000+00:00",
          "archived": false,
          "archived_at": null,
          "identifier": "id1000194",
          "status": "in_stock",
          "from": null,
          "till": null,
          "stock_item_type": "regular",
          "product_group_id": "7acf92e9-02ae-4343-8ffa-f074055db051",
          "properties": {},
          "product_id": "7cf5c623-5550-475a-845d-6a9e218d7343",
          "location_id": "62e2159d-723d-407b-8741-9a07fde0f950"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/stock_item_trackers`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_item_trackers]=created_at,quantity,product_tracker_id`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=product_tracker,stock_item`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`product_group_id` | **string** <br>`eq`, `not_eq`
`product_id` | **string** <br>`eq`, `not_eq`
`product_tracker_id` | **uuid** <br>`eq`, `not_eq`
`quantity` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stock_item_id` | **uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>product_tracker</code>
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
  </li>
  <li><code>stock_item</code></li>
</ul>

