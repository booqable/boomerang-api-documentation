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
`identifier` | **String**<br>Unique identifier (like serial number)
`status` | **String** `readonly`<br>Whether item is out with a customer or in-store/warehouse. One of `archived`, `expected`, `in_stock`, `started`
`from` | **Datetime** `nullable`<br>When the stock item will be available in stock (temporary items or expected arrival date)
`till` | **Datetime** `nullable`<br>When item will be out of stock (temporary items)
`stock_item_type` | **String** `readonly`<br>Based on the values of `from` and `till`. One of `regular`, `temporary`
`properties` | **Hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties)
`properties_attributes` | **Array** `writeonly`<br>Create or update multiple properties associated with this item
`product_id` | **Uuid**<br>The associated Product
`location_id` | **Uuid**<br>The associated Location


## Relationships
Stock items have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product
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
      "id": "b95995a6-c6ca-4d4d-a894-703e7e9ae234",
      "type": "stock_items",
      "attributes": {
        "created_at": "2022-06-15T09:37:00+00:00",
        "updated_at": "2022-06-15T09:37:00+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id165",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "properties": {},
        "product_id": "060e5c3a-3b9d-4618-95c8-64a8b1216d48",
        "location_id": "01f0a93b-39ed-4ed0-807c-170096c18870"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/060e5c3a-3b9d-4618-95c8-64a8b1216d48"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/01f0a93b-39ed-4ed0-807c-170096c18870"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b95995a6-c6ca-4d4d-a894-703e7e9ae234&filter[owner_type]=stock_items"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=b95995a6-c6ca-4d4d-a894-703e7e9ae234&filter[owner_type]=stock_items"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-15T09:33:55Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`identifier` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`from` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`till` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stock_item_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`product_id` | **Uuid**<br>`eq`, `not_eq`
`location_id` | **Uuid**<br>`eq`, `not_eq`
`product_group_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


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
    --url 'https://example.booqable.com/api/boomerang/stock_items/faa004c0-a7ab-498a-bd5d-ae963bdef40d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "faa004c0-a7ab-498a-bd5d-ae963bdef40d",
    "type": "stock_items",
    "attributes": {
      "created_at": "2022-06-15T09:37:01+00:00",
      "updated_at": "2022-06-15T09:37:01+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "id166",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "5bd9dee4-5ed6-4994-b3cc-823e1e80242b",
      "location_id": "661cdc81-aabe-44ee-82b7-92a65e10cc67"
    },
    "relationships": {
      "product": {
        "links": {
          "related": "api/boomerang/products/5bd9dee4-5ed6-4994-b3cc-823e1e80242b"
        }
      },
      "location": {
        "links": {
          "related": "api/boomerang/locations/661cdc81-aabe-44ee-82b7-92a65e10cc67"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=faa004c0-a7ab-498a-bd5d-ae963bdef40d&filter[owner_type]=stock_items"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=faa004c0-a7ab-498a-bd5d-ae963bdef40d&filter[owner_type]=stock_items"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`


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
          "product_id": "b82d2ac1-c7f5-49d7-9fc4-d5a276f2c4c5"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "40c40ec7-1ac9-450e-80ad-7b0097d94a26",
    "type": "stock_items",
    "attributes": {
      "created_at": "2022-06-15T09:37:01+00:00",
      "updated_at": "2022-06-15T09:37:01+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12345",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "b82d2ac1-c7f5-49d7-9fc4-d5a276f2c4c5",
      "location_id": "af6e0c29-99ab-4a32-a177-e381eef94f42"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][identifier]` | **String**<br>Unique identifier (like serial number)
`data[attributes][from]` | **Datetime**<br>When the stock item will be available in stock (temporary items or expected arrival date)
`data[attributes][till]` | **Datetime**<br>When item will be out of stock (temporary items)
`data[attributes][properties_attributes][]` | **Array**<br>Create or update multiple properties associated with this item
`data[attributes][product_id]` | **Uuid**<br>The associated Product
`data[attributes][location_id]` | **Uuid**<br>The associated Location


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
    --url 'https://example.booqable.com/api/boomerang/stock_items/070453ed-c3b3-4655-97aa-05da01876d35' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "070453ed-c3b3-4655-97aa-05da01876d35",
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
    "id": "070453ed-c3b3-4655-97aa-05da01876d35",
    "type": "stock_items",
    "attributes": {
      "created_at": "2022-06-15T09:37:02+00:00",
      "updated_at": "2022-06-15T09:37:02+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12346",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "21079e11-0620-4673-b513-16b97d936ba0",
      "location_id": "27035c4a-124d-4f77-967d-d12c546a4240"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][identifier]` | **String**<br>Unique identifier (like serial number)
`data[attributes][from]` | **Datetime**<br>When the stock item will be available in stock (temporary items or expected arrival date)
`data[attributes][till]` | **Datetime**<br>When item will be out of stock (temporary items)
`data[attributes][properties_attributes][]` | **Array**<br>Create or update multiple properties associated with this item
`data[attributes][product_id]` | **Uuid**<br>The associated Product
`data[attributes][location_id]` | **Uuid**<br>The associated Location


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
    --url 'https://example.booqable.com/api/boomerang/stock_items/3b858dae-91a8-46a2-9b7f-ff7af3467338' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product,location,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_items]=id,created_at,updated_at`


### Includes

This request does not accept any includes