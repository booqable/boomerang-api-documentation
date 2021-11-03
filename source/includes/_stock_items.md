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
`identifier` | **String**<br>Unique identifier (like serial number)
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `readonly`<br>When the item was archived
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
      "id": "50f03cc3-7d56-49ec-ad84-e3f4388f2384",
      "type": "stock_items",
      "attributes": {
        "identifier": "id8",
        "archived": false,
        "archived_at": null,
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "properties": {},
        "product_id": "1cd5f886-0ad2-4d09-8715-a48aeffad9df",
        "location_id": "673d56ee-e666-45ba-9452-649f1996a043"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1cd5f886-0ad2-4d09-8715-a48aeffad9df"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/673d56ee-e666-45ba-9452-649f1996a043"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=50f03cc3-7d56-49ec-ad84-e3f4388f2384"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/stock_items?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/stock_items?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/stock_items?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-03T07:55:53Z`
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

This request does not accept any includes
## Fetching a stock_item



> How to fetch a stock item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_items/bb057da8-3b5f-4fe2-81a1-7652d4243c52' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bb057da8-3b5f-4fe2-81a1-7652d4243c52",
    "type": "stock_items",
    "attributes": {
      "identifier": "id9",
      "archived": false,
      "archived_at": null,
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "0ad9d306-6bdc-4bbd-9586-88aa26d96992",
      "location_id": "a4725ab4-4e5e-4cfd-a191-534200959b29"
    },
    "relationships": {
      "product": {
        "links": {
          "related": "api/boomerang/products/0ad9d306-6bdc-4bbd-9586-88aa26d96992"
        }
      },
      "location": {
        "links": {
          "related": "api/boomerang/locations/a4725ab4-4e5e-4cfd-a191-534200959b29"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=bb057da8-3b5f-4fe2-81a1-7652d4243c52"
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
          "product_id": "d46278c9-e3d2-4783-8544-404cd6b21d1f"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c0926a60-ef7c-4d05-932e-61023b3c7423",
    "type": "stock_items",
    "attributes": {
      "identifier": "12345",
      "archived": false,
      "archived_at": null,
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "d46278c9-e3d2-4783-8544-404cd6b21d1f",
      "location_id": "3d1674df-dce1-46b8-bccc-33a54aaa1bea"
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
  "links": {
    "self": "api/boomerang/stock_items?data%5Battributes%5D%5Bidentifier%5D=12345&data%5Battributes%5D%5Bproduct_id%5D=d46278c9-e3d2-4783-8544-404cd6b21d1f&data%5Btype%5D=stock_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/stock_items?data%5Battributes%5D%5Bidentifier%5D=12345&data%5Battributes%5D%5Bproduct_id%5D=d46278c9-e3d2-4783-8544-404cd6b21d1f&data%5Btype%5D=stock_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/stock_items?data%5Battributes%5D%5Bidentifier%5D=12345&data%5Battributes%5D%5Bproduct_id%5D=d46278c9-e3d2-4783-8544-404cd6b21d1f&data%5Btype%5D=stock_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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


`product` => 
`product_group`








## Updating a stock_item



> How to update a stock item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/stock_items/aabf89f6-d299-406d-9ee4-7ac62eb5cb93' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "aabf89f6-d299-406d-9ee4-7ac62eb5cb93",
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
    "id": "aabf89f6-d299-406d-9ee4-7ac62eb5cb93",
    "type": "stock_items",
    "attributes": {
      "identifier": "12346",
      "archived": false,
      "archived_at": null,
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "22add2ba-3a22-462f-ab60-f43dd996704e",
      "location_id": "42967b6c-56a2-4170-972e-5445d9e41c9e"
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
`data[attributes][from]` | **Datetime**<br>When the stock item will be available in stock (temporary items or expected arrival date)
`data[attributes][till]` | **Datetime**<br>When item will be out of stock (temporary items)
`data[attributes][properties_attributes][]` | **Array**<br>Create or update multiple properties associated with this item
`data[attributes][product_id]` | **Uuid**<br>The associated Product
`data[attributes][location_id]` | **Uuid**<br>The associated Location


### Includes

This request accepts the following includes:

`barcode`


`location`


`product` => 
`product_group`








## Archiving a stock_item



> How to archive a stock item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/stock_items/d79fc821-cc10-4e7b-a169-63f1301708bd' \
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