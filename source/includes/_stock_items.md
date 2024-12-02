# Stock items

For trackable products, each stock item is tracked and managed individually. Each stock item has a unique identifier that helps to keep track of it throughout Booqable.

**A stock item can have one of the following types:**

- **Regular:** Regular stock item (`from` and `till` dates are not set).
- **Expected:** Items will become part of your regular inventory once they surpass the available from date, used for "coming soon" products and purchase orders (only `from` date is set).
- **Temporary:** Temporary items will automatically become unavailable once they exceed the available till date, typically a sub-rental (`from` and `till` are set).

## Endpoints
`GET /api/boomerang/stock_items`

`GET /api/boomerang/stock_items/{id}`

`POST /api/boomerang/stock_items`

`PUT /api/boomerang/stock_items/{id}`

## Fields
Every stock item has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the item was archived
`identifier` | **String** <br>Unique identifier (like serial number)
`status` | **String** `readonly`<br>Whether item is out with a customer or in-store/warehouse. One of `archived`, `expected`, `in_stock`, `started`, `overdue`, `expired`
`from` | **Datetime** `nullable`<br>When the stock item will be available in stock (temporary items or expected arrival date)
`till` | **Datetime** `nullable`<br>When item will be out of stock (temporary items)
`stock_item_type` | **String** `readonly`<br>Based on the values of `from` and `till`. One of `regular`, `temporary`
`product_group_id` | **String** `readonly`<br>Unique identifier of the product group this stock item belongs to
`properties` | **Hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties)
`properties_attributes` | **Array** `writeonly`<br>Create or update multiple properties associated with this item
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm a shortage when updating from, till or location of a stock item
`product_id` | **Uuid** `readonly-after-create`<br>Associated Product
`location_id` | **Uuid** <br>Associated Location


## Relationships
Stock items have the following relationships:

Name | Description
-- | --
`barcode` | **[Barcode](#barcodes)** <br>Associated Barcode
`location` | **[Location](#locations)** <br>Associated Location
`product` | **[Product](#products)** <br>Associated Product
`properties` | **[Properties](#properties)** <br>Associated Properties


## Listing stock_items



> How to fetch a list of stock items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0716ebf4-57e4-4aa6-a50d-54bf164e9d6f",
      "type": "stock_items",
      "attributes": {
        "created_at": "2024-12-02T13:05:40.605359+00:00",
        "updated_at": "2024-12-02T13:05:40.605359+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id1000147",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "2a79d203-4d34-43e1-9949-0b71cfd4d6d9",
        "properties": {},
        "product_id": "11474748-7919-4e19-9c8d-44cabb101d3b",
        "location_id": "6c8ea85d-8d41-4d4d-92d6-5023c0404e98"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/stock_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product,barcode,location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_items]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`identifier` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`from` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`till` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stock_item_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`product_id` | **Uuid** <br>`eq`, `not_eq`
`location_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`
`stock_item_type` | **Array** <br>`count`
`status` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product`


`barcode`


`location`


`properties`






## Fetching a stock_item



> How to fetch a stock item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_items/24fca73e-89b8-4d00-888d-87bc3d5a3b51' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "24fca73e-89b8-4d00-888d-87bc3d5a3b51",
    "type": "stock_items",
    "attributes": {
      "created_at": "2024-12-02T13:05:43.112326+00:00",
      "updated_at": "2024-12-02T13:05:43.112326+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "id1000150",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "39abfb8b-9a25-46f9-a24c-5fa8d9bca652",
      "properties": {},
      "product_id": "82e89f62-3444-41e9-aa21-021c63a549da",
      "location_id": "f3f41c35-a0d6-41a9-84ae-aaf8b9ec0c41"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/stock_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,location,properties`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_items]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`barcode`


`location`


`properties`


`product` => 
`product_group`








## Creating a stock_item



> How to create a stock item:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/stock_items' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "stock_items",
        "attributes": {
          "identifier": "12345",
          "product_id": "7901fb61-bcd0-436b-af21-77625f103430"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dbcbf7ed-7413-40b4-b406-20f74c367ca7",
    "type": "stock_items",
    "attributes": {
      "created_at": "2024-12-02T13:05:42.175454+00:00",
      "updated_at": "2024-12-02T13:05:42.175454+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12345",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "6114efbc-386d-4883-8753-0abf1b3ad52d",
      "properties": {},
      "product_id": "7901fb61-bcd0-436b-af21-77625f103430",
      "location_id": "15efd855-07aa-41da-af8e-da139f4e3626"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/stock_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,location,properties`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_items]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **String** <br>Unique identifier (like serial number)
`data[attributes][from]` | **Datetime** <br>When the stock item will be available in stock (temporary items or expected arrival date)
`data[attributes][till]` | **Datetime** <br>When item will be out of stock (temporary items)
`data[attributes][properties_attributes][]` | **Array** <br>Create or update multiple properties associated with this item
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm a shortage when updating from, till or location of a stock item
`data[attributes][product_id]` | **Uuid** <br>Associated Product
`data[attributes][location_id]` | **Uuid** <br>Associated Location


### Includes

This request accepts the following includes:

`barcode`


`location`


`properties`


`product` => 
`product_group`








## Updating a stock_item



> How to update a stock item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/stock_items/ffcf5c8d-d2d5-4669-8426-a401f7279a5f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ffcf5c8d-d2d5-4669-8426-a401f7279a5f",
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
    "id": "ffcf5c8d-d2d5-4669-8426-a401f7279a5f",
    "type": "stock_items",
    "attributes": {
      "created_at": "2024-12-02T13:05:41.264617+00:00",
      "updated_at": "2024-12-02T13:05:41.326224+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12346",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "df6af03e-ca6e-4279-8d44-c8c9ac287b53",
      "properties": {},
      "product_id": "d10749b4-40a3-40ce-ab69-db9cf025fde6",
      "location_id": "5761498c-fbe3-4fc1-9fb4-127eff5ea607"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/stock_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,location,properties`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_items]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **String** <br>Unique identifier (like serial number)
`data[attributes][from]` | **Datetime** <br>When the stock item will be available in stock (temporary items or expected arrival date)
`data[attributes][till]` | **Datetime** <br>When item will be out of stock (temporary items)
`data[attributes][properties_attributes][]` | **Array** <br>Create or update multiple properties associated with this item
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm a shortage when updating from, till or location of a stock item
`data[attributes][product_id]` | **Uuid** <br>Associated Product
`data[attributes][location_id]` | **Uuid** <br>Associated Location


### Includes

This request accepts the following includes:

`barcode`


`location`


`properties`


`product` => 
`product_group`







