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

`DELETE /api/boomerang/stock_items/{id}`

## Fields
Every stock item has the following fields:

Name | Description
- | -
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
`properties` | **Hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties)
`properties_attributes` | **Array** `writeonly`<br>Create or update multiple properties associated with this item
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm a shortage when updating from, till or location of a stock item
`product_id` | **Uuid** <br>The associated Product
`location_id` | **Uuid** <br>The associated Location


## Relationships
Stock items have the following relationships:

Name | Description
- | -
`product` | **Products**<br>Associated Product
`location` | **Locations** `readonly`<br>Associated Location
`barcode` | **Barcodes**<br>Associated Barcode
`properties` | **Properties** `readonly`<br>Associated Properties


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
      "id": "0c35490b-b0b9-4d14-bda2-f8a89a291cd7",
      "type": "stock_items",
      "attributes": {
        "created_at": "2022-10-25T17:55:12+00:00",
        "updated_at": "2022-10-25T17:55:12+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id202",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "properties": {},
        "product_id": "8a52f337-95c0-4ac9-92c0-e58a55691716",
        "location_id": "01af3ee4-5f06-4bf9-96e6-8bbabeaf910e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8a52f337-95c0-4ac9-92c0-e58a55691716"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/01af3ee4-5f06-4bf9-96e6-8bbabeaf910e"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0c35490b-b0b9-4d14-bda2-f8a89a291cd7&filter[owner_type]=stock_items"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=0c35490b-b0b9-4d14-bda2-f8a89a291cd7&filter[owner_type]=stock_items"
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T17:50:56Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
`product_id` | **Uuid** <br>`eq`, `not_eq`
`location_id` | **Uuid** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/ab7b33a4-eab0-479e-9810-15c8ad7759df' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ab7b33a4-eab0-479e-9810-15c8ad7759df",
    "type": "stock_items",
    "attributes": {
      "created_at": "2022-10-25T17:55:12+00:00",
      "updated_at": "2022-10-25T17:55:12+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "id203",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "1e262eb9-cf92-4b70-9a53-b4ad9e646454",
      "location_id": "32147abd-6708-45e3-869d-4c7c12643a5e"
    },
    "relationships": {
      "product": {
        "links": {
          "related": "api/boomerang/products/1e262eb9-cf92-4b70-9a53-b4ad9e646454"
        }
      },
      "location": {
        "links": {
          "related": "api/boomerang/locations/32147abd-6708-45e3-869d-4c7c12643a5e"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=ab7b33a4-eab0-479e-9810-15c8ad7759df&filter[owner_type]=stock_items"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=ab7b33a4-eab0-479e-9810-15c8ad7759df&filter[owner_type]=stock_items"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/stock_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`


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
          "product_id": "08d28207-bf38-4fd2-bff5-65de2547ce45"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dd3b7426-231a-430d-8a05-67a403d9cbf2",
    "type": "stock_items",
    "attributes": {
      "created_at": "2022-10-25T17:55:13+00:00",
      "updated_at": "2022-10-25T17:55:13+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12345",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "08d28207-bf38-4fd2-bff5-65de2547ce45",
      "location_id": "f25fe91a-15a9-45ce-bab4-3ecaddef5e43"
    },
    "relationships": {
      "product": {
        "meta": {
          "included": false
        }
      },
      "location": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/stock_items`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][identifier]` | **String** <br>Unique identifier (like serial number)
`data[attributes][from]` | **Datetime** <br>When the stock item will be available in stock (temporary items or expected arrival date)
`data[attributes][till]` | **Datetime** <br>When item will be out of stock (temporary items)
`data[attributes][properties_attributes][]` | **Array** <br>Create or update multiple properties associated with this item
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm a shortage when updating from, till or location of a stock item
`data[attributes][product_id]` | **Uuid** <br>The associated Product
`data[attributes][location_id]` | **Uuid** <br>The associated Location


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
    --url 'https://example.booqable.com/api/boomerang/stock_items/8d2b6993-03f9-422d-845c-8ae84b42332e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8d2b6993-03f9-422d-845c-8ae84b42332e",
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
    "id": "8d2b6993-03f9-422d-845c-8ae84b42332e",
    "type": "stock_items",
    "attributes": {
      "created_at": "2022-10-25T17:55:14+00:00",
      "updated_at": "2022-10-25T17:55:14+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12346",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "12cd0f4d-d2fb-4f04-acc9-92d5ad800a22",
      "location_id": "6ca303d5-7617-44fd-adf9-80ba88116b49"
    },
    "relationships": {
      "product": {
        "meta": {
          "included": false
        }
      },
      "location": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/stock_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][identifier]` | **String** <br>Unique identifier (like serial number)
`data[attributes][from]` | **Datetime** <br>When the stock item will be available in stock (temporary items or expected arrival date)
`data[attributes][till]` | **Datetime** <br>When item will be out of stock (temporary items)
`data[attributes][properties_attributes][]` | **Array** <br>Create or update multiple properties associated with this item
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm a shortage when updating from, till or location of a stock item
`data[attributes][product_id]` | **Uuid** <br>The associated Product
`data[attributes][location_id]` | **Uuid** <br>The associated Location


### Includes

This request accepts the following includes:

`barcode`


`location`


`properties`


`product` => 
`product_group`








## Archiving a stock_item



> How to archive a stock item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/stock_items/bb4d0730-c3f5-4577-81f7-7a5cb2f4ab1c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/stock_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`


### Includes

This request does not accept any includes