# Products

Products are items that are plannable. Products always belong to a product group and products can only be created for product groups that have variations enabled. Products inherit most settings from their product group.

## Endpoints
`GET /api/boomerang/products`

`GET /api/boomerang/products/{id}`

`POST /api/boomerang/products`

`PUT /api/boomerang/products/{id}`

`DELETE /api/boomerang/products/{id}`

## Fields
Every product has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** `readonly`<br>Name of the item (based on product group and `variations_values`)
`slug` | **String** `readonly`<br>Slug of the item
`sku` | **String**<br>Stock keeping unit
`type` | **String** `readonly`<br>One of `ProductGroup`, `Product`, `Bundle`
`lead_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable before a reservation
`lag_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable after a reservation
`product_type` | **String** `readonly`<br>**Inherited from product group**: One of `rental`, `consumable`, `service`
`tracking_type` | **String** `readonly`<br>**Inherited from product group**: Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`trackable` | **Boolean** `readonly`<br>**Inherited from product group**: Wheter stock items are tracked
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `readonly`<br>When the item was archived
`extra_information` | **String** `readonly`<br>**Inherited from product group**: Extra information about the item, shown on orders and documents
`photo_url` | **String** `readonly`<br>Main photo url
`photo_base64` | **String** `writeonly`<br>Base64 encoded photo, use this field to store a main photo
`description` | **String** `readonly`<br>**Inherited from product group**: Description used in the online store
`show_in_store` | **Boolean** `readonly`<br>**Inherited from product group**: Whether to show this item in the online
`sorting_weight` | **Integer** `readonly`<br>**Inherited from product group**: Defines sort order in the online store, the higher the weight - the higher it shows up in lists
`base_price_in_cents` | **Integer**<br>The base price in cents
`price_type` | **String** `readonly`<br>**Inherited from product group**: 
`price_period` | **String** `readonly`<br>**Inherited from product group**: One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`flat_fee_price_in_cents` | **Integer**<br>Use this value when price type is `simple`
`structure_price_in_cents` | **Integer**<br>Use this value when price type is `structure` or `private_structure`
`deposit_in_cents` | **Integer**<br>The value to use for deposit calculations
`discountable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether discounts should be applied to this item (note that price rules will still apply)
`taxable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether item is taxable
`tag_list` | **Array** `readonly`<br>**Inherited from product group**: List of tags
`properties` | **Hash** `readonly`<br>**Inherited from product group**: 
`tax_category_id` | **Uuid** `readonly`<br>The associated Tax category
`quantity` | **Integer** `writeonly`<br>When creating or updating a product you can specify the quantity of items you have in stock. Note that for a trackable product, stock items are generated automatically based on this quantity
`variation_values` | **Array**<br>List of values for `product_group.variation_fields` (Should be in the same order)
`allow_shortage` | **Boolean** `readonly`<br>**Inherited from product group**: Whether shortages are allowed
`shortage_limit` | **Integer** `readonly`<br>**Inherited from product group**: The maximum allowed shortage for any date range
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`product_group_id` | **Uuid**<br>The associated Product group


## Relationships
Products have the following relationships:

Name | Description
- | -
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`product_group` | **Product groups** `readonly`<br>Associated Product group
`barcode` | **Barcodes**<br>Associated Barcode


## Listing products

> How to fetch a list of products:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/products' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e2e86260-bac4-4559-b7ff-f926fdb8af1c",
      "type": "products",
      "attributes": {
        "created_at": "2021-10-08T11:05:49+00:00",
        "updated_at": "2021-10-08T11:05:49+00:00",
        "name": "iPad Pro - blue",
        "slug": "ipad-pro-blue",
        "sku": null,
        "type": "Product",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "archived": false,
        "archived_at": null,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "day",
        "flat_fee_price_in_cents": 0,
        "structure_price_in_cents": 0,
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "tax_category_id": null,
        "variation_values": [
          "blue"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "43ba2211-4f69-4483-8c3e-2cff10d38bc6"
      },
      "relationships": {
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/43ba2211-4f69-4483-8c3e-2cff10d38bc6"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e2e86260-bac4-4559-b7ff-f926fdb8af1c"
          }
        }
      }
    },
    {
      "id": "c85e8dfa-f972-404d-bfcf-e757cfe8a23a",
      "type": "products",
      "attributes": {
        "created_at": "2021-10-08T11:05:48+00:00",
        "updated_at": "2021-10-08T11:05:48+00:00",
        "name": "iPad Pro - green",
        "slug": "ipad-pro",
        "sku": "sku",
        "type": "Product",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "archived": false,
        "archived_at": null,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "day",
        "flat_fee_price_in_cents": 0,
        "structure_price_in_cents": 0,
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "tax_category_id": null,
        "variation_values": [
          "green"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "43ba2211-4f69-4483-8c3e-2cff10d38bc6"
      },
      "relationships": {
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/43ba2211-4f69-4483-8c3e-2cff10d38bc6"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c85e8dfa-f972-404d-bfcf-e757cfe8a23a"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/products`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,product_group,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-08T11:05:45Z`
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
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_url` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`allow_shortage` | **Boolean**<br>`eq`
`shortage_limit` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_group_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`product_type` | **Array**<br>`count`
`tracking_type` | **Array**<br>`count`
`archived` | **Array**<br>`count`
`show_in_store` | **Array**<br>`count`
`base_price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`price_type` | **Array**<br>`count`
`price_period` | **Array**<br>`count`
`flat_fee_price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`structure_price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`discountable` | **Array**<br>`count`
`taxable` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`tax_category_id` | **Array**<br>`count`
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a product

> How to fetch a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/products/c6f914b1-38e9-47c0-b598-49e98779f565' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c6f914b1-38e9-47c0-b598-49e98779f565",
    "type": "products",
    "attributes": {
      "created_at": "2021-10-08T11:05:51+00:00",
      "updated_at": "2021-10-08T11:05:51+00:00",
      "name": "iPad Pro - green",
      "slug": "ipad-pro",
      "sku": "sku",
      "type": "Product",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "archived": false,
      "archived_at": null,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "flat_fee_price_in_cents": 0,
      "structure_price_in_cents": 0,
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "tax_category_id": null,
      "variation_values": [
        "green"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "fa7606b9-0873-4d7a-a329-214f97acd35a"
    },
    "relationships": {
      "tax_category": {
        "links": {
          "related": null
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/fa7606b9-0873-4d7a-a329-214f97acd35a"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=c6f914b1-38e9-47c0-b598-49e98779f565"
        }
      }
    }
  },
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/products/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,product_group,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`tax_category`


`properties`


`barcode`






## Creating a product

> How to create a product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/products' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "products",
        "attributes": {
          "product_group_id": "1bdbb98e-01c9-4a46-8508-5ce2422cab89",
          "variation_values": [
            "red"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ea7dbdfb-3896-4a0d-84c3-d2706ce3c819",
    "type": "products",
    "attributes": {
      "created_at": "2021-10-08T11:05:55+00:00",
      "updated_at": "2021-10-08T11:05:55+00:00",
      "name": "iPad Pro - red",
      "slug": "ipad-pro-red",
      "sku": null,
      "type": "Product",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "archived": false,
      "archived_at": null,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "flat_fee_price_in_cents": 0,
      "structure_price_in_cents": 0,
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "tax_category_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "1bdbb98e-01c9-4a46-8508-5ce2422cab89"
    },
    "relationships": {
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
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

`POST /api/boomerang/products`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,product_group,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][sku]` | **String**<br>Stock keeping unit
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][base_price_in_cents]` | **Integer**<br>The base price in cents
`data[attributes][flat_fee_price_in_cents]` | **Integer**<br>Use this value when price type is `simple`
`data[attributes][structure_price_in_cents]` | **Integer**<br>Use this value when price type is `structure` or `private_structure`
`data[attributes][deposit_in_cents]` | **Integer**<br>The value to use for deposit calculations
`data[attributes][quantity]` | **Integer**<br>When creating or updating a product you can specify the quantity of items you have in stock. Note that for a trackable product, stock items are generated automatically based on this quantity
`data[attributes][variation_values][]` | **Array**<br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group


### Includes

This request accepts the following includes:

`tax_category`






## Updating a product

> How to update a product:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/products/b095df33-9b86-44c8-aa9f-8a4ba00c89d4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b095df33-9b86-44c8-aa9f-8a4ba00c89d4",
        "type": "products",
        "attributes": {
          "variation_values": [
            "red"
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b095df33-9b86-44c8-aa9f-8a4ba00c89d4",
    "type": "products",
    "attributes": {
      "created_at": "2021-10-08T11:05:57+00:00",
      "updated_at": "2021-10-08T11:05:58+00:00",
      "name": "iPad Pro - red",
      "slug": "ipad-pro",
      "sku": "sku",
      "type": "Product",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "archived": false,
      "archived_at": null,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "flat_fee_price_in_cents": 0,
      "structure_price_in_cents": 0,
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "tax_category_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "daa461ba-7e0b-4cc5-8e51-f6aa955d59bf"
    },
    "relationships": {
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
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

`PUT /api/boomerang/products/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,product_group,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][sku]` | **String**<br>Stock keeping unit
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][base_price_in_cents]` | **Integer**<br>The base price in cents
`data[attributes][flat_fee_price_in_cents]` | **Integer**<br>Use this value when price type is `simple`
`data[attributes][structure_price_in_cents]` | **Integer**<br>Use this value when price type is `structure` or `private_structure`
`data[attributes][deposit_in_cents]` | **Integer**<br>The value to use for deposit calculations
`data[attributes][quantity]` | **Integer**<br>When creating or updating a product you can specify the quantity of items you have in stock. Note that for a trackable product, stock items are generated automatically based on this quantity
`data[attributes][variation_values][]` | **Array**<br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group


### Includes

This request accepts the following includes:

`tax_category`






## Archiving a product

> How to delete a product:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/products/5bde9d5d-c1a9-4cab-8717-5a29d4b6ef45' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```


### HTTP Request

`DELETE /api/boomerang/products/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,product_group,barcode`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Includes

This request does not accept any includes