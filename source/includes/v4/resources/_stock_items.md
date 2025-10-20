# Stock items

For trackable products, each stock item is tracked and managed individually.
Each stock item has a unique identifier that helps to keep track of it throughout Booqable.

To create multiple StockItems in a single request, use the [StockAdjustment](#stock-adjustments) resource.

## Statuses

- **Regular:** Regular stock item (`from` and `till` dates are not set).
- **Expected:** Items will become part of your regular inventory
  once they surpass the available from date, used for "coming soon"
  products and purchase orders (only `from` date is set).
- **Temporary:** Temporary items will automatically become unavailable
  once they exceed the available till date, typically a sub-rental
  (`from` and `till` are set).

## Relationships
Name | Description
-- | --
`barcode` | **[Barcode](#barcodes)** `optional`<br>Barcode to quickly identify this StockItem. 
`location` | **[Location](#locations)** `required`<br>Location where this StockItem currently resides. This is the start location of the order if the StockItem is currently out with a customer. 
`product` | **[Product](#products)** `required`<br>The [Product](#products) this StockItem is one instance of. 
`properties` | **[Properties](#properties)** `hasmany`<br>Custom data associated with this StockItem. 
`stock_item_plannings` | **[Stock item plannings](#stock-item-plannings)** `hasmany`<br>The [StockItemPlannings](#stock-item-plannings) that represent the planning and reservation history of this specific StockItem. This includes both rental orders and downtime periods assigned to this StockItem. 


Check matching attributes under [Fields](#stock-items-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether item is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the item was archived. 
`confirm_shortage` | **boolean** `writeonly`<br>Whether to confirm a shortage when updating from, till or location of a stock item. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`from` | **datetime** `nullable`<br>When the stock item will be available in stock (temporary items or expected arrival date). 
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** <br>Unique identifier (like serial number). 
`location_id` | **uuid** <br>Location where this StockItem currently resides. This is the start location of the order if the StockItem is currently out with a customer. 
`product_group_id` | **uuid** `readonly`<br>The [ProductGroup](#product-groups) this StockItem belongs to. 
`product_id` | **uuid** `readonly-after-create`<br>The [Product](#products) this StockItem is one instance of. 
`properties` | **hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties). 
`properties_attributes` | **array** `writeonly`<br>Create or update multiple properties associated with this stock item. 
`status` | **enum** `readonly`<br>Whether item is out with a customer or in-store/warehouse.<br> One of: `archived`, `expected`, `in_stock`, `started`, `overdue`, `expired`, `in_downtime`.
`stock_item_type` | **enum** `readonly`<br>Based on the values of `from` and `till`.<br> One of: `regular`, `temporary`.
`till` | **datetime** `nullable`<br>When item will be out of stock (temporary items). 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List stock_items


> How to fetch a list of stock items:

```shell
  curl --get 'https://example.booqable.com/api/4/stock_items'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "080ec72f-da7f-4569-8d12-1a6770c8f19f",
        "type": "stock_items",
        "attributes": {
          "created_at": "2025-04-07T23:24:00.000000+00:00",
          "updated_at": "2025-04-07T23:24:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "identifier": "id1000189",
          "status": "in_stock",
          "from": null,
          "till": null,
          "stock_item_type": "regular",
          "product_group_id": "33aa5e86-cf21-4867-8ce8-6ca8000eee14",
          "properties": {},
          "product_id": "ab39f2f5-e082-4520-8ba6-57e483d3686a",
          "location_id": "78ae9e4b-b588-4fb0-845a-99371ba4d69c"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/stock_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_items]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=product,barcode,location`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`from` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_id` | **uuid** <br>`eq`, `not_eq`
`product_group_id` | **uuid** <br>`eq`, `not_eq`
`product_id` | **uuid** <br>`eq`, `not_eq`
`q` | **string** <br>`eq`
`status` | **enum** <br>`eq`
`stock_item_type` | **enum** <br>`eq`
`till` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`status` | **array** <br>`count`
`stock_item_type` | **array** <br>`count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>location</code></li>
  <li><code>product</code></li>
  <li><code>properties</code></li>
  <li>
    <code>stock_item_plannings</code>
    <ul>
      <li><code>downtime</code></li>
    </ul>
  </li>
</ul>


## Fetch a stock_item


> How to fetch a stock item:

```shell
  curl --get 'https://example.booqable.com/api/4/stock_items/218c1f4b-3124-4718-86e3-fc4646fe5562'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "218c1f4b-3124-4718-86e3-fc4646fe5562",
      "type": "stock_items",
      "attributes": {
        "created_at": "2020-12-14T17:16:00.000000+00:00",
        "updated_at": "2020-12-14T17:16:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id1000190",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "20441cdb-ca45-49d3-887f-91258ef2c191",
        "properties": {},
        "product_id": "62127110-28f1-4b13-84de-f7287c9f9691",
        "location_id": "42f6ee46-44cc-47e4-8775-d2f20612347a"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/stock_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_items]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,location,properties`


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>location</code></li>
  <li>
    <code>product</code>
    <ul>
      <li><code>product_group</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
  <li>
    <code>stock_item_plannings</code>
    <ul>
      <li><code>downtime</code></li>
    </ul>
  </li>
</ul>


## Create a stock_item


> How to create a stock item:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/stock_items'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "stock_items",
           "attributes": {
             "identifier": "12345",
             "product_id": "8ba34c4e-02e7-46c8-87c1-741102785936"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "63a10585-7a78-4d77-8fc0-04fefeb7b255",
      "type": "stock_items",
      "attributes": {
        "created_at": "2025-07-23T16:54:00.000000+00:00",
        "updated_at": "2025-07-23T16:54:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "12345",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "d798843c-7589-4a94-85cd-e47efc86c6ab",
        "properties": {},
        "product_id": "8ba34c4e-02e7-46c8-87c1-741102785936",
        "location_id": "216d7c85-e3a6-4f77-809a-a5fb404ea9a4"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/stock_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_items]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,location,properties`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][confirm_shortage]` | **boolean** <br>Whether to confirm a shortage when updating from, till or location of a stock item. 
`data[attributes][from]` | **datetime** <br>When the stock item will be available in stock (temporary items or expected arrival date). 
`data[attributes][identifier]` | **string** <br>Unique identifier (like serial number). 
`data[attributes][location_id]` | **uuid** <br>Location where this StockItem currently resides. This is the start location of the order if the StockItem is currently out with a customer. 
`data[attributes][product_id]` | **uuid** <br>The [Product](#products) this StockItem is one instance of. 
`data[attributes][properties_attributes][]` | **array** <br>Create or update multiple properties associated with this stock item. 
`data[attributes][till]` | **datetime** <br>When item will be out of stock (temporary items). 


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>location</code></li>
  <li>
    <code>product</code>
    <ul>
      <li><code>product_group</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
</ul>


## Update a stock_item


> How to update a stock item:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/stock_items/96e16eb3-614f-4a6a-8444-531244376f3a'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "96e16eb3-614f-4a6a-8444-531244376f3a",
           "type": "stock_items",
           "attributes": {
             "identifier": "12346"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "96e16eb3-614f-4a6a-8444-531244376f3a",
      "type": "stock_items",
      "attributes": {
        "created_at": "2019-01-10T06:59:11.000000+00:00",
        "updated_at": "2019-01-10T06:59:11.000000+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "12346",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "4fd29b75-0981-44f0-893f-c9e5885ec5f6",
        "properties": {},
        "product_id": "797648e2-ccc4-4117-832c-6b0a19709ee5",
        "location_id": "b10fb7f2-9f8e-4e91-8a52-93585748b5a3"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/stock_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_items]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,location,properties`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][confirm_shortage]` | **boolean** <br>Whether to confirm a shortage when updating from, till or location of a stock item. 
`data[attributes][from]` | **datetime** <br>When the stock item will be available in stock (temporary items or expected arrival date). 
`data[attributes][identifier]` | **string** <br>Unique identifier (like serial number). 
`data[attributes][location_id]` | **uuid** <br>Location where this StockItem currently resides. This is the start location of the order if the StockItem is currently out with a customer. 
`data[attributes][product_id]` | **uuid** <br>The [Product](#products) this StockItem is one instance of. 
`data[attributes][properties_attributes][]` | **array** <br>Create or update multiple properties associated with this stock item. 
`data[attributes][till]` | **datetime** <br>When item will be out of stock (temporary items). 


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>location</code></li>
  <li>
    <code>product</code>
    <ul>
      <li><code>product_group</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
</ul>

