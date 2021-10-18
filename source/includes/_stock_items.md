# Stock items

Stock items

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
`identifier` | **String**<br>Unique identifier (like serial number)
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `readonly`<br>When the item was archived
`status` | **String** `readonly`<br>One of `archived`, `in_stock`, `started`
`from` | **Datetime**<br>When the stock item will be in stock (temporary items or expected arrival date)
`till` | **Datetime**<br>When item will be out of stock (temporary items)
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
      "id": "cac4b6a0-a6dc-441f-99b7-ac1d149be1e7",
      "type": "stock_items",
      "attributes": {
        "created_at": "2021-10-14T22:07:13+00:00",
        "updated_at": "2021-10-14T22:07:13+00:00",
        "identifier": "id1",
        "archived": false,
        "archived_at": null,
        "status": "available",
        "from": null,
        "till": null,
        "properties": {},
        "product_id": "8f2007cd-a90e-49a8-94f4-7421f19033c7",
        "location_id": "ae43e836-4857-4398-9ccc-6d2dbcafe6bf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8f2007cd-a90e-49a8-94f4-7421f19033c7"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/ae43e836-4857-4398-9ccc-6d2dbcafe6bf"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cac4b6a0-a6dc-441f-99b7-ac1d149be1e7"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-14T22:07:10Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`identifier` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`from` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`till` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_id` | **Uuid**<br>`eq`, `not_eq`
`location_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a stock_item

> How to fetch a stock item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_items/1725475f-2f37-43fd-8728-63f0734c01cf' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1725475f-2f37-43fd-8728-63f0734c01cf",
    "type": "stock_items",
    "attributes": {
      "created_at": "2021-10-14T22:07:15+00:00",
      "updated_at": "2021-10-14T22:07:15+00:00",
      "identifier": "id2",
      "archived": false,
      "archived_at": null,
      "status": "available",
      "from": null,
      "till": null,
      "properties": {},
      "product_id": "eff1bbf0-c6d5-4b7c-b478-08d2e4ad00e1",
      "location_id": "efb8c2a0-32dd-4b59-b895-9b2a33297dc3"
    },
    "relationships": {
      "product": {
        "links": {
          "related": "api/boomerang/products/eff1bbf0-c6d5-4b7c-b478-08d2e4ad00e1"
        }
      },
      "location": {
        "links": {
          "related": "api/boomerang/locations/efb8c2a0-32dd-4b59-b895-9b2a33297dc3"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=1725475f-2f37-43fd-8728-63f0734c01cf"
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

This request does not accept any includes
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
          "product_id": "6bbe6e6b-9f32-4269-9c9e-2adf4e6a560e"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6de3cd99-b64a-482a-8d3b-b6e68f73ced7",
    "type": "stock_items",
    "attributes": {
      "created_at": "2021-10-14T22:07:16+00:00",
      "updated_at": "2021-10-14T22:07:16+00:00",
      "identifier": "12345",
      "archived": false,
      "archived_at": null,
      "status": "available",
      "from": null,
      "till": null,
      "properties": {},
      "product_id": "6bbe6e6b-9f32-4269-9c9e-2adf4e6a560e",
      "location_id": null
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
`data[attributes][from]` | **Datetime**<br>When the stock item will be in stock (temporary items or expected arrival date)
`data[attributes][till]` | **Datetime**<br>When item will be out of stock (temporary items)
`data[attributes][properties_attributes][]` | **Array**<br>Create or update multiple properties associated with this item
`data[attributes][product_id]` | **Uuid**<br>The associated Product
`data[attributes][location_id]` | **Uuid**<br>The associated Location


### Includes

This request does not accept any includes
## Updating a stock_item

> How to update a stock item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/stock_items/bf4cb94b-5e29-4201-a219-ff4ecb3c293c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bf4cb94b-5e29-4201-a219-ff4ecb3c293c",
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
    "id": "bf4cb94b-5e29-4201-a219-ff4ecb3c293c",
    "type": "stock_items",
    "attributes": {
      "created_at": "2021-10-14T22:07:18+00:00",
      "updated_at": "2021-10-14T22:07:18+00:00",
      "identifier": "12346",
      "archived": false,
      "archived_at": null,
      "status": "available",
      "from": null,
      "till": null,
      "properties": {},
      "product_id": "82602f7e-adcf-421b-b537-c948264c1e7d",
      "location_id": "43c7ce5b-6b23-435a-af03-d6dda4984ec4"
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
`data[attributes][from]` | **Datetime**<br>When the stock item will be in stock (temporary items or expected arrival date)
`data[attributes][till]` | **Datetime**<br>When item will be out of stock (temporary items)
`data[attributes][properties_attributes][]` | **Array**<br>Create or update multiple properties associated with this item
`data[attributes][product_id]` | **Uuid**<br>The associated Product
`data[attributes][location_id]` | **Uuid**<br>The associated Location


### Includes

This request does not accept any includes
## Archiving a stock_item

> How to archive a stock item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/stock_items/902e8a1c-cc26-4ebe-92c5-36638de32a9e' \
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