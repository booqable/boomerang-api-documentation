# Stock items

For trackable products, each stock item is tracked and managed individually. Each stock item has a unique identifier that helps to keep track of it throughout Booqable.

**A stock item can have one of the following types:**

- **Regular:** Regular stock item (`from` and `till` dates are not set).
- **Expected:** Items will become part of your regular inventory once they surpass the available from date, used for "coming soon" products and purchase orders (only `from` date is set).
- **Temporary:** Temporary items will automatically become unavailable once they exceed the available till date, typically a sub-rental (`from` and `till` are set).

## Endpoints
`PUT /api/boomerang/stock_items/{id}`

`GET /api/boomerang/stock_items`

`GET /api/boomerang/stock_items/{id}`

`POST /api/boomerang/stock_items`

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


## Updating a stock_item



> How to update a stock item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/stock_items/7112240a-b0d4-4bdd-b169-6ac05a553a7b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7112240a-b0d4-4bdd-b169-6ac05a553a7b",
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
    "id": "7112240a-b0d4-4bdd-b169-6ac05a553a7b",
    "type": "stock_items",
    "attributes": {
      "created_at": "2024-03-04T09:19:22+00:00",
      "updated_at": "2024-03-04T09:19:22+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12346",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "c25af2d7-456d-4581-b57c-0961b139154e",
      "properties": {},
      "product_id": "616fbeb7-65a5-42ee-9f6d-fd241d342bae",
      "location_id": "bc46c51d-51d2-48bd-983a-658c9c1d1885"
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
      "id": "e9a07f02-3985-477a-86de-265a84364cd6",
      "type": "stock_items",
      "attributes": {
        "created_at": "2024-03-04T09:19:23+00:00",
        "updated_at": "2024-03-04T09:19:23+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id1000201",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "8f1e853f-2b39-482d-9eb6-a222f6b1e5bf",
        "properties": {},
        "product_id": "6a250540-de35-427f-b9fc-2361be6dee8e",
        "location_id": "92b187ba-181f-41da-b65f-647839bcf5e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6a250540-de35-427f-b9fc-2361be6dee8e"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/92b187ba-181f-41da-b65f-647839bcf5e6"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e9a07f02-3985-477a-86de-265a84364cd6&filter[owner_type]=stock_items"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=e9a07f02-3985-477a-86de-265a84364cd6&filter[owner_type]=stock_items"
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/92158ed2-de2f-4612-8cef-16e68edb30ec' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "92158ed2-de2f-4612-8cef-16e68edb30ec",
    "type": "stock_items",
    "attributes": {
      "created_at": "2024-03-04T09:19:24+00:00",
      "updated_at": "2024-03-04T09:19:24+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "id1000202",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "e7b3f055-9b31-4848-92a1-81bb144d8959",
      "properties": {},
      "product_id": "8d0c82e5-3612-4507-afdb-0052313e195b",
      "location_id": "badc01c3-ac17-4a81-9286-096f70e15bc4"
    },
    "relationships": {
      "product": {
        "links": {
          "related": "api/boomerang/products/8d0c82e5-3612-4507-afdb-0052313e195b"
        }
      },
      "location": {
        "links": {
          "related": "api/boomerang/locations/badc01c3-ac17-4a81-9286-096f70e15bc4"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=92158ed2-de2f-4612-8cef-16e68edb30ec&filter[owner_type]=stock_items"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=92158ed2-de2f-4612-8cef-16e68edb30ec&filter[owner_type]=stock_items"
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
          "product_id": "4f33cd28-45c5-44a6-a958-4a5766daa282"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2ca36021-6e2d-4872-b6f5-a06762cc8cf2",
    "type": "stock_items",
    "attributes": {
      "created_at": "2024-03-04T09:19:25+00:00",
      "updated_at": "2024-03-04T09:19:25+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12345",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "59eadb7e-2b93-4aa3-a083-e63738ce7bf3",
      "properties": {},
      "product_id": "4f33cd28-45c5-44a6-a958-4a5766daa282",
      "location_id": "b7ec4cbb-dbaa-4714-b9f3-f99c49b1eea2"
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







