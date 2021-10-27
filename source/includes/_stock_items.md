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
      "id": "a7d3a9f6-14e7-4b35-817c-397dc22c37ae",
      "type": "stock_items",
      "attributes": {
        "identifier": "id1",
        "archived": false,
        "archived_at": null,
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "properties": {},
        "product_id": "769a2bc7-5eb7-43dd-bf05-29092545d0a3",
        "location_id": "796e20d3-2b01-4937-9588-6f418a1cbec4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/769a2bc7-5eb7-43dd-bf05-29092545d0a3"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/796e20d3-2b01-4937-9588-6f418a1cbec4"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a7d3a9f6-14e7-4b35-817c-397dc22c37ae"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-27T11:02:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/82a318da-7c0b-4d24-9e8b-e7751d48923c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "82a318da-7c0b-4d24-9e8b-e7751d48923c",
    "type": "stock_items",
    "attributes": {
      "identifier": "id2",
      "archived": false,
      "archived_at": null,
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "properties": {},
      "product_id": "4d84b294-58dd-46ff-9f6b-adfba6f8962a",
      "location_id": "f4e22516-3dfa-422e-bb29-4524f2e02b2b"
    },
    "relationships": {
      "product": {
        "links": {
          "related": "api/boomerang/products/4d84b294-58dd-46ff-9f6b-adfba6f8962a"
        }
      },
      "location": {
        "links": {
          "related": "api/boomerang/locations/f4e22516-3dfa-422e-bb29-4524f2e02b2b"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=82a318da-7c0b-4d24-9e8b-e7751d48923c"
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
          "product_id": "b641c46d-dee9-4779-ac89-336c0e2c3ebe"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2b749d5f-f3f1-4f5f-9699-17fd766ad903",
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
      "product_id": "b641c46d-dee9-4779-ac89-336c0e2c3ebe",
      "location_id": "3e483de5-b0d0-4c21-88a6-08d1a9d4c339"
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
    "self": "api/boomerang/stock_items?data%5Battributes%5D%5Bidentifier%5D=12345&data%5Battributes%5D%5Bproduct_id%5D=b641c46d-dee9-4779-ac89-336c0e2c3ebe&data%5Btype%5D=stock_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/stock_items?data%5Battributes%5D%5Bidentifier%5D=12345&data%5Battributes%5D%5Bproduct_id%5D=b641c46d-dee9-4779-ac89-336c0e2c3ebe&data%5Btype%5D=stock_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/stock_items?data%5Battributes%5D%5Bidentifier%5D=12345&data%5Battributes%5D%5Bproduct_id%5D=b641c46d-dee9-4779-ac89-336c0e2c3ebe&data%5Btype%5D=stock_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/0b31e8da-f07d-4a2a-917f-02a19f148235' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0b31e8da-f07d-4a2a-917f-02a19f148235",
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
    "id": "0b31e8da-f07d-4a2a-917f-02a19f148235",
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
      "product_id": "42941c64-828d-421f-8805-724698ab567d",
      "location_id": "b9233078-fa6f-44bf-b002-29026949d2b0"
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/3d2465f9-5329-4f69-bdc8-8ce698536430' \
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