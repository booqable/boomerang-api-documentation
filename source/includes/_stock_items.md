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
`product_id` | **Uuid** <br>The associated Product
`location_id` | **Uuid** <br>The associated Location


## Relationships
Stock items have the following relationships:

Name | Description
-- | --
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
      "id": "8f3488bd-df15-47e6-956d-a38eb45068fb",
      "type": "stock_items",
      "attributes": {
        "created_at": "2023-05-15T13:52:11+00:00",
        "updated_at": "2023-05-15T13:52:11+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id1000200",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "0a79de48-7c30-49d6-9f0a-00df1f798c90",
        "properties": {},
        "product_id": "919e273c-26f6-4631-85cc-d505dc811228",
        "location_id": "db776358-3be8-4046-937b-9126b84b4b19"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/919e273c-26f6-4631-85cc-d505dc811228"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/db776358-3be8-4046-937b-9126b84b4b19"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8f3488bd-df15-47e6-956d-a38eb45068fb&filter[owner_type]=stock_items"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=8f3488bd-df15-47e6-956d-a38eb45068fb&filter[owner_type]=stock_items"
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/55155196-6f14-459b-9120-3fa7c4843f8f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "55155196-6f14-459b-9120-3fa7c4843f8f",
    "type": "stock_items",
    "attributes": {
      "created_at": "2023-05-15T13:52:12+00:00",
      "updated_at": "2023-05-15T13:52:12+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "id1000201",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "57bf990b-54d5-44ff-bba8-7539cef81f88",
      "properties": {},
      "product_id": "55bfa730-4f57-4978-82b4-6aa3d9ccfc79",
      "location_id": "a416bcae-cb73-4501-96d4-649251aa4208"
    },
    "relationships": {
      "product": {
        "links": {
          "related": "api/boomerang/products/55bfa730-4f57-4978-82b4-6aa3d9ccfc79"
        }
      },
      "location": {
        "links": {
          "related": "api/boomerang/locations/a416bcae-cb73-4501-96d4-649251aa4208"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=55155196-6f14-459b-9120-3fa7c4843f8f&filter[owner_type]=stock_items"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=55155196-6f14-459b-9120-3fa7c4843f8f&filter[owner_type]=stock_items"
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
          "product_id": "1364ec23-3f99-4695-805c-1ca02e2ece95"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "00cb6e32-4c85-4237-97ff-c0f6f71e50f4",
    "type": "stock_items",
    "attributes": {
      "created_at": "2023-05-15T13:52:13+00:00",
      "updated_at": "2023-05-15T13:52:13+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12345",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "0293f715-4e11-42c8-9fd5-32e43b2f8f3b",
      "properties": {},
      "product_id": "1364ec23-3f99-4695-805c-1ca02e2ece95",
      "location_id": "b1903a13-65c7-4c62-99de-a2c2643b481f"
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/2698dbec-58ca-4dcc-a6c5-70733e9f1377' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2698dbec-58ca-4dcc-a6c5-70733e9f1377",
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
    "id": "2698dbec-58ca-4dcc-a6c5-70733e9f1377",
    "type": "stock_items",
    "attributes": {
      "created_at": "2023-05-15T13:52:14+00:00",
      "updated_at": "2023-05-15T13:52:14+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12346",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "5e0d15a8-e9c1-405d-87e4-c8f847ac0261",
      "properties": {},
      "product_id": "e24d43fa-6e63-4ab3-9683-981c28d176bb",
      "location_id": "0e3af470-70f9-4b21-9e67-a04f797155f8"
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
`data[attributes][product_id]` | **Uuid** <br>The associated Product
`data[attributes][location_id]` | **Uuid** <br>The associated Location


### Includes

This request accepts the following includes:

`barcode`


`location`


`properties`


`product` => 
`product_group`







