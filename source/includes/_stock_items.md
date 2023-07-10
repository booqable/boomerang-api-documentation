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
      "id": "1e173bf9-c239-458a-8587-e655a4658a09",
      "type": "stock_items",
      "attributes": {
        "created_at": "2023-07-10T09:20:43+00:00",
        "updated_at": "2023-07-10T09:20:43+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "id1000200",
        "status": "in_stock",
        "from": null,
        "till": null,
        "stock_item_type": "regular",
        "product_group_id": "a915a57b-e519-4414-8724-ccb6b70c58d4",
        "properties": {},
        "product_id": "79b02ecf-3220-47b6-a1e8-df41e96a08f3",
        "location_id": "39e06908-02b0-4547-9eea-e16a8c5510e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79b02ecf-3220-47b6-a1e8-df41e96a08f3"
          }
        },
        "location": {
          "links": {
            "related": "api/boomerang/locations/39e06908-02b0-4547-9eea-e16a8c5510e2"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1e173bf9-c239-458a-8587-e655a4658a09&filter[owner_type]=stock_items"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=1e173bf9-c239-458a-8587-e655a4658a09&filter[owner_type]=stock_items"
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/29b981e0-72a3-4ed8-ac23-d81a7cdf9cda' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "29b981e0-72a3-4ed8-ac23-d81a7cdf9cda",
    "type": "stock_items",
    "attributes": {
      "created_at": "2023-07-10T09:20:44+00:00",
      "updated_at": "2023-07-10T09:20:44+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "id1000201",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "1172f196-c0f8-4128-9b8f-3e4e77398437",
      "properties": {},
      "product_id": "558cb53f-ef41-4548-a659-bd7155ec41c2",
      "location_id": "c68380be-cd1b-4bf6-898e-4eb7640cd502"
    },
    "relationships": {
      "product": {
        "links": {
          "related": "api/boomerang/products/558cb53f-ef41-4548-a659-bd7155ec41c2"
        }
      },
      "location": {
        "links": {
          "related": "api/boomerang/locations/c68380be-cd1b-4bf6-898e-4eb7640cd502"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=29b981e0-72a3-4ed8-ac23-d81a7cdf9cda&filter[owner_type]=stock_items"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=29b981e0-72a3-4ed8-ac23-d81a7cdf9cda&filter[owner_type]=stock_items"
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
          "product_id": "c86bef4e-1629-4b41-85f6-144fafeff8d6"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cefe1ffd-0c8e-45a1-a831-c3cb206ce255",
    "type": "stock_items",
    "attributes": {
      "created_at": "2023-07-10T09:20:45+00:00",
      "updated_at": "2023-07-10T09:20:45+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12345",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "6d17617c-901b-4efa-b24b-6cfd4d416dfd",
      "properties": {},
      "product_id": "c86bef4e-1629-4b41-85f6-144fafeff8d6",
      "location_id": "9eee3503-b019-4108-bc6b-b533f71d40f4"
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
    --url 'https://example.booqable.com/api/boomerang/stock_items/e0e913a6-cc12-423b-9238-e51871930c9d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e0e913a6-cc12-423b-9238-e51871930c9d",
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
    "id": "e0e913a6-cc12-423b-9238-e51871930c9d",
    "type": "stock_items",
    "attributes": {
      "created_at": "2023-07-10T09:20:45+00:00",
      "updated_at": "2023-07-10T09:20:46+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "12346",
      "status": "in_stock",
      "from": null,
      "till": null,
      "stock_item_type": "regular",
      "product_group_id": "a3260493-cef6-4ad3-a64f-28790ed20310",
      "properties": {},
      "product_id": "6e5173f5-f62c-4612-94c8-e73abd236672",
      "location_id": "5974d21f-3a6a-415e-8b0b-74719be415c2"
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







