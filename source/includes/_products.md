# Products

Products are items that are plannable on orders. They always belong to a product group and can only be created separately if the group has variations enabled.

Most of the settings are inherited from the associated product group. When the group has variations enabled, the `base_price_in_cents` field is not inherited from the group anymore but can be set individually.

## Endpoints
`GET /api/boomerang/products`

`POST api/boomerang/products/search`

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
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the item was archived
`type` | **String** `readonly`<br>One of `product_groups`, `products`, `bundles`
`name` | **String** `readonly`<br>Name of the item (based on product group and `variations_values`)
`slug` | **String** `readonly`<br>Slug of the item
`sku` | **String**<br>Stock keeping unit
`lead_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable before a reservation
`lag_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable after a reservation
`product_type` | **String** `readonly`<br>**Inherited from product group**: One of `rental`, `consumable`, `service`
`tracking_type` | **String** `readonly`<br>**Inherited from product group**: Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`trackable` | **Boolean** `readonly`<br>**Inherited from product group**: Wheter stock items are tracked
`extra_information` | **String** `readonly`<br>**Inherited from product group**: Extra information about the item, shown on orders and documents
`photo_url` | **String** `readonly`<br>Main photo url
`photo_base64` | **String** `writeonly`<br>Base64 encoded photo, use this field to store a main photo
`description` | **String** `readonly`<br>**Inherited from product group**: Description used in the online store
`show_in_store` | **Boolean** `readonly`<br>**Inherited from product group**: Whether to show this item in the online
`sorting_weight` | **Integer**<br>Defines sorting weight within its associated product group, the lower the weight - the higher it shows up in lists
`base_price_in_cents` | **Integer**<br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`price_type` | **String** `readonly`<br>**Inherited from product group**: One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`price_period` | **String** `readonly`<br>**Inherited from product group**: One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`deposit_in_cents` | **Integer**<br>The value to use for deposit calculations
`discountable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether discounts should be applied to this item (note that price rules will still apply)
`taxable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether item is taxable
`tag_list` | **Array** `readonly`<br>**Inherited from product group**: List of tags
`properties` | **Hash** `readonly`<br>**Inherited from product group**: Key value pairs of associated properties
`photo_id` | **Uuid**<br>The associated Photo
`quantity` | **Integer** `writeonly`<br>When creating or updating a product you can specify the quantity of items you have in stock. Note that for a trackable product, stock items are generated automatically based on this quantity
`variation_values` | **Array**<br>List of values for `product_group.variation_fields` (Should be in the same order)
`allow_shortage` | **Boolean** `readonly`<br>**Inherited from product group**: Whether shortages are allowed
`shortage_limit` | **Integer** `readonly`<br>**Inherited from product group**: The maximum allowed shortage for any date range
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`product_group_id` | **Uuid**<br>The associated Product group
`tax_category_id` | **Uuid** `readonly`<br>The associated Tax category
`price_structure_id` | **Uuid** `readonly`<br>The associated Price structure


## Relationships
Products have the following relationships:

Name | Description
- | -
`photo` | **Photos** `readonly`<br>Associated Photo
`product_group` | **Product groups** `readonly`<br>Associated Product group
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`barcode` | **Barcodes**<br>Associated Barcode
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`properties` | **Properties** `readonly`<br>Associated Properties
`categories` | **Categories** `readonly`<br>Associated Categories


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
      "id": "93d17350-26be-4f69-9376-8a52b816b618",
      "type": "products",
      "attributes": {
        "created_at": "2022-07-13T11:52:12+00:00",
        "updated_at": "2022-07-13T11:52:12+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro - blue",
        "slug": "ipad-pro-blue",
        "sku": null,
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 2,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "variation_values": [
          "blue"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "8648afd3-faf0-4ec0-ba96-075cb9ffe5e5",
        "tax_category_id": null,
        "price_structure_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/8648afd3-faf0-4ec0-ba96-075cb9ffe5e5"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=93d17350-26be-4f69-9376-8a52b816b618&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=8648afd3-faf0-4ec0-ba96-075cb9ffe5e5&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=8648afd3-faf0-4ec0-ba96-075cb9ffe5e5"
          }
        }
      }
    },
    {
      "id": "eae7a2c6-9f7d-4444-8fa1-74e089736d2f",
      "type": "products",
      "attributes": {
        "created_at": "2022-07-13T11:52:12+00:00",
        "updated_at": "2022-07-13T11:52:12+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro - green",
        "slug": "ipad-pro",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 1,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "variation_values": [
          "green"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "8648afd3-faf0-4ec0-ba96-075cb9ffe5e5",
        "tax_category_id": null,
        "price_structure_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/8648afd3-faf0-4ec0-ba96-075cb9ffe5e5"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=eae7a2c6-9f7d-4444-8fa1-74e089736d2f&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=8648afd3-faf0-4ec0-ba96-075cb9ffe5e5&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=8648afd3-faf0-4ec0-ba96-075cb9ffe5e5"
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T11:49:01Z`
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
`type` | **String**<br>`eq`, `not_eq`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean**<br>`eq`
`extra_information` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean**<br>`eq`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_period` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean**<br>`eq`
`taxable` | **Boolean**<br>`eq`
`tag_list` | **Array**<br>`eq`
`allow_shortage` | **Boolean**<br>`eq`
`shortage_limit` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid**<br>`eq`, `not_eq`
`product_group_id` | **Uuid**<br>`eq`, `not_eq`
`tax_category_id` | **Uuid**<br>`eq`, `not_eq`
`price_structure_id` | **Uuid**<br>`eq`, `not_eq`
`category_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`archived` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`taxable` | **Array**<br>`count`
`discountable` | **Array**<br>`count`
`product_type` | **Array**<br>`count`
`tracking_type` | **Array**<br>`count`
`show_in_store` | **Array**<br>`count`
`price_type` | **Array**<br>`count`
`price_period` | **Array**<br>`count`
`tax_category_id` | **Array**<br>`count`
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`base_price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`photo`


`barcode`






## Searching products

Use advanced search to make logical filter groups with and/or operators.


> How to search for products:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/products/search' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "products": "id"
      },
      "filter": {
        "conditions": {
          "operator": "or",
          "attributes": [
            {
              "operator": "and",
              "attributes": [
                {
                  "discountable": true
                },
                {
                  "taxable": true
                }
              ]
            },
            {
              "operator": "and",
              "attributes": [
                {
                  "show_in_store": true
                },
                {
                  "taxable": true
                }
              ]
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dc7ddd23-8997-43c0-b853-b141dbaebff8"
    },
    {
      "id": "5809cb1e-efaa-48fe-ac40-3ffc49e3281a"
    },
    {
      "id": "3459ea66-c4b1-4125-81e5-a6d7c17befc4"
    },
    {
      "id": "fc0f5290-fa3f-440c-9420-9a4e1f5a79d2"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/products/search`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T11:49:01Z`
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
`type` | **String**<br>`eq`, `not_eq`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean**<br>`eq`
`extra_information` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean**<br>`eq`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_period` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean**<br>`eq`
`taxable` | **Boolean**<br>`eq`
`tag_list` | **Array**<br>`eq`
`allow_shortage` | **Boolean**<br>`eq`
`shortage_limit` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid**<br>`eq`, `not_eq`
`product_group_id` | **Uuid**<br>`eq`, `not_eq`
`tax_category_id` | **Uuid**<br>`eq`, `not_eq`
`price_structure_id` | **Uuid**<br>`eq`, `not_eq`
`category_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`archived` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`taxable` | **Array**<br>`count`
`discountable` | **Array**<br>`count`
`product_type` | **Array**<br>`count`
`tracking_type` | **Array**<br>`count`
`show_in_store` | **Array**<br>`count`
`price_type` | **Array**<br>`count`
`price_period` | **Array**<br>`count`
`tax_category_id` | **Array**<br>`count`
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`base_price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`photo`


`barcode`






## Fetching a product



> How to fetch a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/products/6352f920-4346-4a6d-bb68-de4f53bb52ea' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6352f920-4346-4a6d-bb68-de4f53bb52ea",
    "type": "products",
    "attributes": {
      "created_at": "2022-07-13T11:52:16+00:00",
      "updated_at": "2022-07-13T11:52:16+00:00",
      "archived": false,
      "archived_at": null,
      "type": "products",
      "name": "iPad Pro - green",
      "slug": "ipad-pro",
      "sku": "sku",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 1,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "variation_values": [
        "green"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "92ee763c-58d0-4482-9de4-fd730a1229af",
      "tax_category_id": null,
      "price_structure_id": null
    },
    "relationships": {
      "photo": {
        "links": {
          "related": null
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/92ee763c-58d0-4482-9de4-fd730a1229af"
        }
      },
      "tax_category": {
        "links": {
          "related": null
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=6352f920-4346-4a6d-bb68-de4f53bb52ea&filter[owner_type]=products"
        }
      },
      "price_structure": {
        "links": {
          "related": null
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=92ee763c-58d0-4482-9de4-fd730a1229af&filter[owner_type]=products"
        }
      },
      "categories": {
        "links": {
          "related": "/api/boomerang/categories?filter%5Bitem_id%5D=92ee763c-58d0-4482-9de4-fd730a1229af"
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`


`categories`






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
          "product_group_id": "f3ce1c78-ae5d-4620-ade2-66be0329d050",
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
    "id": "a5c2029a-1c87-48d6-a7f1-590ba14c04cc",
    "type": "products",
    "attributes": {
      "created_at": "2022-07-13T11:52:17+00:00",
      "updated_at": "2022-07-13T11:52:17+00:00",
      "archived": false,
      "archived_at": null,
      "type": "products",
      "name": "iPad Pro - red",
      "slug": "ipad-pro-red",
      "sku": null,
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 3,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "f3ce1c78-ae5d-4620-ade2-66be0329d050",
      "tax_category_id": null,
      "price_structure_id": null
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "price_structure": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      },
      "categories": {
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][sku]` | **String**<br>Stock keeping unit
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][sorting_weight]` | **Integer**<br>Defines sorting weight within its associated product group, the lower the weight - the higher it shows up in lists
`data[attributes][base_price_in_cents]` | **Integer**<br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`data[attributes][deposit_in_cents]` | **Integer**<br>The value to use for deposit calculations
`data[attributes][photo_id]` | **Uuid**<br>The associated Photo
`data[attributes][quantity]` | **Integer**<br>When creating or updating a product you can specify the quantity of items you have in stock. Note that for a trackable product, stock items are generated automatically based on this quantity
`data[attributes][variation_values][]` | **Array**<br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`


`categories`


`price_structure` => 
`price_tiles`








## Updating a product



> How to update a product:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/products/5134faa4-19ae-4626-be23-90b431f22a2a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5134faa4-19ae-4626-be23-90b431f22a2a",
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
    "id": "5134faa4-19ae-4626-be23-90b431f22a2a",
    "type": "products",
    "attributes": {
      "created_at": "2022-07-13T11:52:18+00:00",
      "updated_at": "2022-07-13T11:52:18+00:00",
      "archived": false,
      "archived_at": null,
      "type": "products",
      "name": "iPad Pro - red",
      "slug": "ipad-pro",
      "sku": "sku",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 1,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "553ccc4d-23cf-4b57-99ca-c0a2ce400dd4",
      "tax_category_id": null,
      "price_structure_id": null
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "price_structure": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      },
      "categories": {
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][sku]` | **String**<br>Stock keeping unit
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][sorting_weight]` | **Integer**<br>Defines sorting weight within its associated product group, the lower the weight - the higher it shows up in lists
`data[attributes][base_price_in_cents]` | **Integer**<br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`data[attributes][deposit_in_cents]` | **Integer**<br>The value to use for deposit calculations
`data[attributes][photo_id]` | **Uuid**<br>The associated Photo
`data[attributes][quantity]` | **Integer**<br>When creating or updating a product you can specify the quantity of items you have in stock. Note that for a trackable product, stock items are generated automatically based on this quantity
`data[attributes][variation_values][]` | **Array**<br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`


`categories`


`price_structure` => 
`price_tiles`








## Archiving a product



> How to delete a product:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/products/80283dbe-7ab2-455f-bcea-d4e204a79d08' \
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Includes

This request does not accept any includes