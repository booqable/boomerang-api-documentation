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
      "id": "49532049-6454-47d4-9082-3f2706ce9c83",
      "type": "stock_items",
      "attributes": {
        "created_at": "2022-05-19T11:11:18+00:00",
        "updated_at": "2022-05-19T11:11:18+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id165",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "properties": {},
        "product_id": "5941680b-3772-4443-a772-7e1cd29fd0ba",
        "location_id": "8141a2ef-bc1f-4b33-a97e-068e7b45b706"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5941680b-3772-4443-a772-7e1cd29fd0ba"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/8141a2ef-bc1f-4b33-a97e-068e7b45b706"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=49532049-6454-47d4-9082-3f2706ce9c83&filter[owner_type]=stock_items"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=49532049-6454-47d4-9082-3f2706ce9c83&filter[owner_type]=stock_items"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T11:08:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/999c0358-cd4f-48b1-a5aa-9f3225bbf6ab' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "999c0358-cd4f-48b1-a5aa-9f3225bbf6ab",
    "type": "stock_items",
    "attributes": {
      "created_at": "2022-05-19T11:11:19+00:00",
      "updated_at": "2022-05-19T11:11:19+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "id166",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "4dcd88cb-15d3-4445-997d-f6bf14c8450d",
      "location_id": "737db483-0cc3-4b02-8271-43e990ef78e6"
    },
    "relationships": {
      "product": {
        "links": {
          "related": "api/boomerang/products/4dcd88cb-15d3-4445-997d-f6bf14c8450d"
        }
      },
      "location": {
        "links": {
          "related": "api/boomerang/locations/737db483-0cc3-4b02-8271-43e990ef78e6"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=999c0358-cd4f-48b1-a5aa-9f3225bbf6ab&filter[owner_type]=stock_items"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=999c0358-cd4f-48b1-a5aa-9f3225bbf6ab&filter[owner_type]=stock_items"
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
          "product_id": "2b26c120-9231-4c05-bbba-5b998161263f"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b7e88b93-1893-41a8-bbb4-bf1f3b3907da",
    "type": "stock_items",
    "attributes": {
      "created_at": "2022-05-19T11:11:20+00:00",
      "updated_at": "2022-05-19T11:11:20+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12345",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "2b26c120-9231-4c05-bbba-5b998161263f",
      "location_id": "a192a217-159e-4096-b8e1-906ffcf522c5"
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/3ccde983-9fdb-4795-92e8-4e8e36c2e749' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3ccde983-9fdb-4795-92e8-4e8e36c2e749",
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
    "id": "3ccde983-9fdb-4795-92e8-4e8e36c2e749",
    "type": "stock_items",
    "attributes": {
      "created_at": "2022-05-19T11:11:20+00:00",
      "updated_at": "2022-05-19T11:11:20+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12346",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "b7572466-5f6f-44a2-8a50-b5abb6c4b6de",
      "location_id": "53aaf0d1-06ad-4fc9-a7fe-3af0c2058547"
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/fbc8e568-769f-4dd4-bde3-e1d7b557872e' \
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