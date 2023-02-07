# Product groups

Product groups hold general information and configuration about products. A product group is always associated with at least one product. When a product group is enabled to have variations, it can have multiple products. Note that product groups are not plannable on orders.

**A product group supports the following product types:**

- **Rental:** Rental products are your main products that you rent out. Even if your main product is officially a service, in Booqable you will want to add it as a rental product.
- **Consumable:** Consumable products are products that you do not plan on getting back. These are meant to be small items that you plan on selling along with a rental but do not expect to be returned with the rest of the order.
- **Service:** Service Item or Service Products are the optional extra services (or items) your want to offer to your products. These are not trackable, therefore they do not have an instock number.

**The following tracking types can be defined:**

- **None:** Products are not tracked (only for product_type `service`, `consumable`)
- **Trackable:** Trackable Products tend to be the larger ticket items; the products you want to know specifically who has what stock item of what product and when. With trackable products, every stock item is has its own identifier so you can assign and track the individual products (only for product_type `rental`).
- **Bulk:** Bulk products are for those products you don't necessarily need to track each specific stock item but rather you just need to know how many you have in stock. These tend to be your smaller ticket items or items that are quicker to replace in bulk if some are lost (only for product_type `rental`, `consumable`).

**Pricing can be configured by setting one of the following price types:**

- **None:** Products are free (applies to all product types)
- **Fixed:** Charge a fixed price (applies to all product types).
- **Simple:** Apply simple pricing (depends on `price_period`, only for product_type `rental`, `service`).
- **Structure:** Applies associated price structure (only for product_type `rental`, `service`).
- **Private structure:** Applies associated private price structure (only for product_type `rental`, `service`).

## Endpoints
`GET /api/boomerang/product_groups`

`POST api/boomerang/product_groups/search`

`GET /api/boomerang/product_groups/{id}`

`POST /api/boomerang/product_groups`

`PUT /api/boomerang/product_groups/{id}`

`DELETE /api/boomerang/product_groups/{id}`

## Fields
Every product group has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the item was archived
`type` | **String** `readonly`<br>One of `product_groups`, `products`, `bundles`
`name` | **String** <br>Name of the item
`slug` | **String** `readonly`<br>Slug of the item
`sku` | **String** <br>Stock keeping unit
`lead_time` | **Integer** <br>The amount of seconds the item should be unavailable before a reservation
`lag_time` | **Integer** <br>The amount of seconds the item should be unavailable after a reservation
`product_type` | **String** <br>One of `rental`, `consumable`, `service`
`tracking_type` | **String** <br>Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`trackable` | **Boolean** <br>Whether stock items are tracked
`has_variations` | **Boolean** <br>Whether variations are enabled. Not applicable for product_type `service`
`extra_information` | **String** `nullable`<br>Extra information about the item, shown on orders and documents
`photo_url` | **String** `readonly`<br>Main photo url
`description` | **String** `nullable`<br>Description used in the online store
`show_in_store` | **Boolean** <br>Whether to show this item in the online
`sorting_weight` | **Integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists
`base_price_in_cents` | **Integer** `readonly`<br>The value that is being calculated with (based on the current `price_type`)
`price_type` | **String** <br>One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`price_period` | **String** <br>One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`deposit_in_cents` | **Integer** <br>The value to use for deposit calculations
`discountable` | **Boolean** <br>Whether discounts should be applied to this item (note that price rules will still apply)
`taxable` | **Boolean** <br>Whether item is taxable
`seo_title` | **String** <br>SEO title tag
`seo_description` | **String** <br>SEO meta description tag
`tag_list` | **Array** <br>List of tags
`properties` | **Hash** `readonly`<br>Key value pairs of associated properties
`photo_id` | **Uuid** `readonly`<br>The associated Photo
`allow_shortage` | **Boolean** <br>Whether shortages are allowed
`shortage_limit` | **Integer** <br>The maximum allowed shortage for any date range
`variation_fields` | **Array** <br>Array of fields that distinguish variations (e.g. color or size)
`flat_fee_price_in_cents` | **Integer** <br>Use this value when price type is `simple`
`structure_price_in_cents` | **Integer** <br>Use this value when price type is `structure` or `private_structure`
`properties_attributes` | **Array** `writeonly`<br>Create or update multiple properties associated with this product group
`stock_item_properties` | **Array** <br>Available properties for stock items
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`remote_photo_url` | **String** `writeonly`<br>Url to an image on the web
`photo_base64` | **String** `writeonly`<br>Base64 encoded photo, use this field to store a main photo
`tax_category_id` | **Uuid** <br>The associated Tax category
`price_ruleset_id` | **Uuid** <br>The associated Price ruleset
`price_structure_id` | **Uuid** <br>The associated Price structure


## Relationships
Product groups have the following relationships:

Name | Description
- | -
`photo` | **Photos** `readonly`<br>Associated Photo
`products` | **Products** `readonly`<br>Associated Products
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`properties` | **Properties** `readonly`<br>Associated Properties


## Listing product groups



> How to fetch a list of product groups:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/product_groups' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3f6949c6-17b6-4fa9-9823-f1c274fd1e64",
      "type": "product_groups",
      "attributes": {
        "created_at": "2023-02-07T16:07:03+00:00",
        "updated_at": "2023-02-07T16:07:03+00:00",
        "archived": false,
        "archived_at": null,
        "type": "product_groups",
        "name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": "SKU",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "seo_title": null,
        "seo_description": null,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_fields": [],
        "flat_fee_price_in_cents": 0,
        "structure_price_in_cents": 0,
        "stock_item_properties": [],
        "tax_category_id": null,
        "price_ruleset_id": null,
        "price_structure_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[product_group_id]=3f6949c6-17b6-4fa9-9823-f1c274fd1e64"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=3f6949c6-17b6-4fa9-9823-f1c274fd1e64&filter[owner_type]=product_groups"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/product_groups`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,products,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T16:04:23Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean** <br>`eq`
`has_variations` | **Boolean** <br>`eq`
`extra_information` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean** <br>`eq`
`sorting_weight` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_period` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean** <br>`eq`
`taxable` | **Boolean** <br>`eq`
`seo_title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **Array** <br>`eq`
`q` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`allow_shortage` | **Boolean** <br>`eq`
`shortage_limit` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`flat_fee_price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`structure_price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid** <br>`eq`, `not_eq`
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`archived` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`taxable` | **Array** <br>`count`
`discountable` | **Array** <br>`count`
`product_type` | **Array** <br>`count`
`tracking_type` | **Array** <br>`count`
`show_in_store` | **Array** <br>`count`
`price_type` | **Array** <br>`count`
`price_period` | **Array** <br>`count`
`tax_category_id` | **Array** <br>`count`
`deposit_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`base_price_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`photo`


`properties`






## Searching product groups

Use advanced search to make logical filter groups with and/or operators.


> How to search for product groups:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/product_groups/search' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "product_groups": "id"
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
      "id": "6d1b0cbd-09ff-484b-a145-eb5ac85a6f02"
    },
    {
      "id": "4f23feba-a208-40c1-9adc-328e2b2a977c"
    },
    {
      "id": "15903cd7-5c0f-40f3-b3b4-89b42d9acab0"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/product_groups/search`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,products,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T16:04:23Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean** <br>`eq`
`has_variations` | **Boolean** <br>`eq`
`extra_information` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean** <br>`eq`
`sorting_weight` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_period` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean** <br>`eq`
`taxable` | **Boolean** <br>`eq`
`seo_title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **Array** <br>`eq`
`q` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`allow_shortage` | **Boolean** <br>`eq`
`shortage_limit` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`flat_fee_price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`structure_price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid** <br>`eq`, `not_eq`
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`archived` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`taxable` | **Array** <br>`count`
`discountable` | **Array** <br>`count`
`product_type` | **Array** <br>`count`
`tracking_type` | **Array** <br>`count`
`show_in_store` | **Array** <br>`count`
`price_type` | **Array** <br>`count`
`price_period` | **Array** <br>`count`
`tax_category_id` | **Array** <br>`count`
`deposit_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`base_price_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`photo`


`properties`






## Fetching a product group



> How to fetch a product group:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/product_groups/2ac14728-4996-40a7-9887-6b98b50d15e3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2ac14728-4996-40a7-9887-6b98b50d15e3",
    "type": "product_groups",
    "attributes": {
      "created_at": "2023-02-07T16:07:05+00:00",
      "updated_at": "2023-02-07T16:07:05+00:00",
      "archived": false,
      "archived_at": null,
      "type": "product_groups",
      "name": "iPad Pro",
      "slug": "ipad-pro",
      "sku": "SKU",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "has_variations": false,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "allow_shortage": false,
      "shortage_limit": 0,
      "variation_fields": [],
      "flat_fee_price_in_cents": 0,
      "structure_price_in_cents": 0,
      "stock_item_properties": [],
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null
    },
    "relationships": {
      "photo": {
        "links": {
          "related": null
        }
      },
      "products": {
        "links": {
          "related": "api/boomerang/products?filter[product_group_id]=2ac14728-4996-40a7-9887-6b98b50d15e3"
        }
      },
      "tax_category": {
        "links": {
          "related": null
        }
      },
      "price_ruleset": {
        "links": {
          "related": null
        }
      },
      "price_structure": {
        "links": {
          "related": null
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=2ac14728-4996-40a7-9887-6b98b50d15e3&filter[owner_type]=product_groups"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/product_groups/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,products,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`


`products`


`price_structure` => 
`price_tiles`








## Creating a product group



> How to create a product group:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/product_groups' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "product_groups",
        "attributes": {
          "name": "iPad mini",
          "tracking_type": "trackable",
          "trackable": true,
          "price_type": "simple",
          "price_period": "day",
          "tag_list": [
            "tablets",
            "apple"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1cf8375f-21da-4794-82c0-8c91ce4614a1",
    "type": "product_groups",
    "attributes": {
      "created_at": "2023-02-07T16:07:06+00:00",
      "updated_at": "2023-02-07T16:07:06+00:00",
      "archived": false,
      "archived_at": null,
      "type": "product_groups",
      "name": "iPad mini",
      "slug": "ipad-mini",
      "sku": "IPAD_MINI",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "trackable",
      "trackable": true,
      "has_variations": false,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [
        "tablets",
        "apple"
      ],
      "properties": {},
      "photo_id": null,
      "allow_shortage": false,
      "shortage_limit": 0,
      "variation_fields": [],
      "flat_fee_price_in_cents": 0,
      "structure_price_in_cents": 0,
      "stock_item_properties": [],
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "products": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "price_ruleset": {
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
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/product_groups`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,products,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String** <br>Name of the item
`data[attributes][sku]` | **String** <br>Stock keeping unit
`data[attributes][lead_time]` | **Integer** <br>The amount of seconds the item should be unavailable before a reservation
`data[attributes][lag_time]` | **Integer** <br>The amount of seconds the item should be unavailable after a reservation
`data[attributes][product_type]` | **String** <br>One of `rental`, `consumable`, `service`
`data[attributes][tracking_type]` | **String** <br>Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`data[attributes][trackable]` | **Boolean** <br>Whether stock items are tracked
`data[attributes][has_variations]` | **Boolean** <br>Whether variations are enabled. Not applicable for product_type `service`
`data[attributes][extra_information]` | **String** <br>Extra information about the item, shown on orders and documents
`data[attributes][show_in_store]` | **Boolean** <br>Whether to show this item in the online
`data[attributes][sorting_weight]` | **Integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists
`data[attributes][price_type]` | **String** <br>One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`data[attributes][price_period]` | **String** <br>One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`data[attributes][deposit_in_cents]` | **Integer** <br>The value to use for deposit calculations
`data[attributes][discountable]` | **Boolean** <br>Whether discounts should be applied to this item (note that price rules will still apply)
`data[attributes][taxable]` | **Boolean** <br>Whether item is taxable
`data[attributes][seo_title]` | **String** <br>SEO title tag
`data[attributes][seo_description]` | **String** <br>SEO meta description tag
`data[attributes][tag_list][]` | **Array** <br>List of tags
`data[attributes][allow_shortage]` | **Boolean** <br>Whether shortages are allowed
`data[attributes][shortage_limit]` | **Integer** <br>The maximum allowed shortage for any date range
`data[attributes][variation_fields][]` | **Array** <br>Array of fields that distinguish variations (e.g. color or size)
`data[attributes][flat_fee_price_in_cents]` | **Integer** <br>Use this value when price type is `simple`
`data[attributes][structure_price_in_cents]` | **Integer** <br>Use this value when price type is `structure` or `private_structure`
`data[attributes][properties_attributes][]` | **Array** <br>Create or update multiple properties associated with this product group
`data[attributes][stock_item_properties][]` | **Array** <br>Available properties for stock items
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][remote_photo_url]` | **String** <br>Url to an image on the web
`data[attributes][photo_base64]` | **String** <br>Base64 encoded photo, use this field to store a main photo
`data[attributes][tax_category_id]` | **Uuid** <br>The associated Tax category
`data[attributes][price_ruleset_id]` | **Uuid** <br>The associated Price ruleset
`data[attributes][price_structure_id]` | **Uuid** <br>The associated Price structure


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`


`price_structure` => 
`price_tiles`








## Updating a product group



> How to update a product group:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/product_groups/befd387f-4afe-41a9-9968-46e0e850e796' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "befd387f-4afe-41a9-9968-46e0e850e796",
        "type": "product_groups",
        "attributes": {
          "name": "iPad mini"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "befd387f-4afe-41a9-9968-46e0e850e796",
    "type": "product_groups",
    "attributes": {
      "created_at": "2023-02-07T16:07:06+00:00",
      "updated_at": "2023-02-07T16:07:06+00:00",
      "archived": false,
      "archived_at": null,
      "type": "product_groups",
      "name": "iPad mini",
      "slug": "ipad-pro",
      "sku": "SKU",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "has_variations": false,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "allow_shortage": false,
      "shortage_limit": 0,
      "variation_fields": [],
      "flat_fee_price_in_cents": 0,
      "structure_price_in_cents": 0,
      "stock_item_properties": [],
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "products": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "price_ruleset": {
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
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/product_groups/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,products,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String** <br>Name of the item
`data[attributes][sku]` | **String** <br>Stock keeping unit
`data[attributes][lead_time]` | **Integer** <br>The amount of seconds the item should be unavailable before a reservation
`data[attributes][lag_time]` | **Integer** <br>The amount of seconds the item should be unavailable after a reservation
`data[attributes][product_type]` | **String** <br>One of `rental`, `consumable`, `service`
`data[attributes][tracking_type]` | **String** <br>Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`data[attributes][trackable]` | **Boolean** <br>Whether stock items are tracked
`data[attributes][has_variations]` | **Boolean** <br>Whether variations are enabled. Not applicable for product_type `service`
`data[attributes][extra_information]` | **String** <br>Extra information about the item, shown on orders and documents
`data[attributes][show_in_store]` | **Boolean** <br>Whether to show this item in the online
`data[attributes][sorting_weight]` | **Integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists
`data[attributes][price_type]` | **String** <br>One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`data[attributes][price_period]` | **String** <br>One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`data[attributes][deposit_in_cents]` | **Integer** <br>The value to use for deposit calculations
`data[attributes][discountable]` | **Boolean** <br>Whether discounts should be applied to this item (note that price rules will still apply)
`data[attributes][taxable]` | **Boolean** <br>Whether item is taxable
`data[attributes][seo_title]` | **String** <br>SEO title tag
`data[attributes][seo_description]` | **String** <br>SEO meta description tag
`data[attributes][tag_list][]` | **Array** <br>List of tags
`data[attributes][allow_shortage]` | **Boolean** <br>Whether shortages are allowed
`data[attributes][shortage_limit]` | **Integer** <br>The maximum allowed shortage for any date range
`data[attributes][variation_fields][]` | **Array** <br>Array of fields that distinguish variations (e.g. color or size)
`data[attributes][flat_fee_price_in_cents]` | **Integer** <br>Use this value when price type is `simple`
`data[attributes][structure_price_in_cents]` | **Integer** <br>Use this value when price type is `structure` or `private_structure`
`data[attributes][properties_attributes][]` | **Array** <br>Create or update multiple properties associated with this product group
`data[attributes][stock_item_properties][]` | **Array** <br>Available properties for stock items
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][remote_photo_url]` | **String** <br>Url to an image on the web
`data[attributes][photo_base64]` | **String** <br>Base64 encoded photo, use this field to store a main photo
`data[attributes][tax_category_id]` | **Uuid** <br>The associated Tax category
`data[attributes][price_ruleset_id]` | **Uuid** <br>The associated Price ruleset
`data[attributes][price_structure_id]` | **Uuid** <br>The associated Price structure


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`


`price_structure` => 
`price_tiles`








## Archiving a product group



> How to delete a product group:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/product_groups/081c9010-b12e-42a3-a668-8fb86983bb31' \
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

`DELETE /api/boomerang/product_groups/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,products,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`


### Includes

This request does not accept any includes