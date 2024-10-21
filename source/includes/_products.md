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
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the item was archived
`type` | **String** `readonly`<br>One of `product_groups`, `products`, `bundles`
`name` | **String** `readonly`<br>Name of the item (based on product group and `variations_values`)
`group_name` | **String** `readonly`<br>The name of the ProductGroup, if this is a Product that is one of the variations in the group.
`slug` | **String** <br>Slug of the item
`sku` | **String** <br>Stock keeping unit
`lead_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable before a reservation
`lag_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable after a reservation
`product_type` | **String** `readonly`<br>**Inherited from product group**: One of `rental`, `consumable`, `service`
`tracking_type` | **String** `readonly`<br>**Inherited from product group**: Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`trackable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether stock items are tracked
`has_variations` | **Boolean** <br>Whether variations are enabled. Not applicable for product_type `service`
`variation` | **Boolean** `readonly`<br>Whether this Item is a variation in a ProductGroup.
`extra_information` | **String** `readonly`<br>**Inherited from product group**: Extra information about the item, shown on orders and documents
`photo_url` | **String** `readonly`<br>Main photo url
`description` | **String** `readonly`<br>**Inherited from product group**: Description used in the online store
`excerpt` | **String** <br>Excerpt used in the online store
`show_in_store` | **Boolean** `readonly`<br>**Inherited from product group**: Whether to show this item in the online
`sorting_weight` | **Integer** <br>Defines sorting weight within its associated product group, the lower the weight - the higher it shows up in lists
`base_price_in_cents` | **Integer** <br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`price_type` | **String** `readonly`<br>**Inherited from product group**: One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`price_period` | **String** `readonly`<br>**Inherited from product group**: One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`deposit_in_cents` | **Integer** <br>The value to use for deposit calculations
`discountable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether discounts should be applied to this item (note that price rules will still apply)
`taxable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether item is taxable
`seo_title` | **String** <br>SEO title tag
`seo_description` | **String** <br>SEO meta description tag
`tag_list` | **Array** `readonly`<br>**Inherited from product group**: List of tags
`properties` | **Hash** `readonly`<br>**Inherited from product group**: Key value pairs of associated properties
`photo_id` | **Uuid** <br>The associated Photo
`tax_category_id` | **Uuid** `readonly`<br>The associated Tax category
`price_ruleset_id` | **Uuid** `readonly`<br>The associated Price ruleset
`price_structure_id` | **Uuid** `readonly`<br>The associated Price structure
`product_group_id` | **Uuid** <br>The associated Product group
`variation_values` | **Array** <br>List of values for `product_group.variation_fields` (Should be in the same order)
`allow_shortage` | **Boolean** `readonly`<br>**Inherited from product group**: Whether shortages are allowed
`shortage_limit` | **Integer** `readonly`<br>**Inherited from product group**: The maximum allowed shortage for any date range
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)


## Relationships
Products have the following relationships:

Name | Description
-- | --
`barcode` | **Barcodes** <br>Associated Barcode
`inventory_levels` | **Inventory levels** `readonly`<br>Associated Inventory levels
`photo` | **Photos** `readonly`<br>Associated Photo
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`product_group` | **Product groups** `readonly`<br>Associated Product group
`properties` | **Properties** `readonly`<br>Associated Properties
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category


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
      "id": "cee0d659-2143-4d9c-9b3d-1a4bee3571a7",
      "type": "products",
      "attributes": {
        "created_at": "2024-10-21T09:23:04.133798+00:00",
        "updated_at": "2024-10-21T09:23:04.344099+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro",
        "group_name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": null,
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": true,
        "variation": true,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
        "show_in_store": true,
        "sorting_weight": 1,
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
        "tax_category_id": null,
        "price_ruleset_id": null,
        "price_structure_id": null,
        "variation_values": [
          "green"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "8d92630c-043e-4bf6-814d-746844250b07"
      },
      "relationships": {}
    },
    {
      "id": "58fd57df-64e2-49f7-a8c0-9aa8d0c0c1d4",
      "type": "products",
      "attributes": {
        "created_at": "2024-10-21T09:23:04.428157+00:00",
        "updated_at": "2024-10-21T09:23:04.428157+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro - blue",
        "group_name": "iPad Pro",
        "slug": "ipad-pro-blue",
        "sku": "PRODUCT 1000019",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": true,
        "variation": true,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
        "show_in_store": true,
        "sorting_weight": 2,
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
        "tax_category_id": null,
        "price_ruleset_id": null,
        "price_structure_id": null,
        "variation_values": [
          "blue"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "8d92630c-043e-4bf6-814d-746844250b07"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/products`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`, `gt`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`group_name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean** <br>`eq`
`has_variations` | **Boolean** <br>`eq`
`variation` | **Boolean** <br>`eq`
`extra_information` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`excerpt` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`collection_id` | **Uuid** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`
`allow_shortage` | **Boolean** <br>`eq`
`shortage_limit` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
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

`barcode`


`inventory_levels`


`photo`


`price_structure` => 
`price_tiles`




`product_group`


`properties`


`tax_category`






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
      "id": "dc4522eb-e6ff-480e-ada6-9f9fa860f263"
    },
    {
      "id": "7c6c1721-025f-41cb-aba1-bf49855a79ea"
    },
    {
      "id": "6d33dbc2-2509-452f-9a8c-de140d4924cf"
    },
    {
      "id": "816398a8-c3e1-45f3-9db1-a2142fad2543"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/products/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`, `gt`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`group_name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean** <br>`eq`
`has_variations` | **Boolean** <br>`eq`
`variation` | **Boolean** <br>`eq`
`extra_information` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`excerpt` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`collection_id` | **Uuid** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`
`allow_shortage` | **Boolean** <br>`eq`
`shortage_limit` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
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

`barcode`


`inventory_levels`


`photo`


`price_structure` => 
`price_tiles`




`product_group`


`properties`


`tax_category`






## Fetching a product



> How to fetch a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/products/e0bec5d5-675b-45f0-a6ed-a792280537c6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e0bec5d5-675b-45f0-a6ed-a792280537c6",
    "type": "products",
    "attributes": {
      "created_at": "2024-10-21T09:23:06.692731+00:00",
      "updated_at": "2024-10-21T09:23:06.883846+00:00",
      "archived": false,
      "archived_at": null,
      "type": "products",
      "name": "iPad Pro",
      "group_name": "iPad Pro",
      "slug": "ipad-pro",
      "sku": null,
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "has_variations": true,
      "variation": true,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "excerpt": null,
      "show_in_store": true,
      "sorting_weight": 1,
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
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null,
      "variation_values": [
        "green"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "7c25468e-0aef-4e76-8a89-0166fa4ddb95"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/products/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`barcode`


`inventory_levels`


`photo`


`price_structure` => 
`price_tiles`




`product_group`


`properties`


`tax_category`






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
          "product_group_id": "0a3e117b-543e-4f2a-9cb2-cad28bb714b4",
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
    "id": "bcf8a4cd-60bc-4f26-b765-34d1f7e4f64b",
    "type": "products",
    "attributes": {
      "created_at": "2024-10-21T09:23:07.865406+00:00",
      "updated_at": "2024-10-21T09:23:07.865406+00:00",
      "archived": false,
      "archived_at": null,
      "type": "products",
      "name": "iPad Pro - red",
      "group_name": "iPad Pro",
      "slug": "ipad-pro-red",
      "sku": null,
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "has_variations": true,
      "variation": true,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "excerpt": null,
      "show_in_store": true,
      "sorting_weight": 3,
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
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "0a3e117b-543e-4f2a-9cb2-cad28bb714b4"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/products`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][slug]` | **String** <br>Slug of the item
`data[attributes][sku]` | **String** <br>Stock keeping unit
`data[attributes][has_variations]` | **Boolean** <br>Whether variations are enabled. Not applicable for product_type `service`
`data[attributes][excerpt]` | **String** <br>Excerpt used in the online store
`data[attributes][sorting_weight]` | **Integer** <br>Defines sorting weight within its associated product group, the lower the weight - the higher it shows up in lists
`data[attributes][base_price_in_cents]` | **Integer** <br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`data[attributes][deposit_in_cents]` | **Integer** <br>The value to use for deposit calculations
`data[attributes][seo_title]` | **String** <br>SEO title tag
`data[attributes][seo_description]` | **String** <br>SEO meta description tag
`data[attributes][photo_id]` | **Uuid** <br>The associated Photo
`data[attributes][product_group_id]` | **Uuid** <br>The associated Product group
`data[attributes][variation_values][]` | **Array** <br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`)


### Includes

This request accepts the following includes:

`barcode`


`inventory_levels`


`photo`


`price_structure` => 
`price_tiles`




`product_group`


`properties`


`tax_category`






## Updating a product



> How to update a product:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/products/d04c7d5e-435c-4e64-8172-6d9550644d65' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d04c7d5e-435c-4e64-8172-6d9550644d65",
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
    "id": "d04c7d5e-435c-4e64-8172-6d9550644d65",
    "type": "products",
    "attributes": {
      "created_at": "2024-10-21T09:23:02.268453+00:00",
      "updated_at": "2024-10-21T09:23:02.679606+00:00",
      "archived": false,
      "archived_at": null,
      "type": "products",
      "name": "iPad Pro - red",
      "group_name": "iPad Pro",
      "slug": "ipad-pro",
      "sku": null,
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "has_variations": true,
      "variation": true,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "excerpt": null,
      "show_in_store": true,
      "sorting_weight": 1,
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
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "8d2105cb-e3ea-4a3f-b72e-86c1a978acea"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/products/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][slug]` | **String** <br>Slug of the item
`data[attributes][sku]` | **String** <br>Stock keeping unit
`data[attributes][has_variations]` | **Boolean** <br>Whether variations are enabled. Not applicable for product_type `service`
`data[attributes][excerpt]` | **String** <br>Excerpt used in the online store
`data[attributes][sorting_weight]` | **Integer** <br>Defines sorting weight within its associated product group, the lower the weight - the higher it shows up in lists
`data[attributes][base_price_in_cents]` | **Integer** <br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`data[attributes][deposit_in_cents]` | **Integer** <br>The value to use for deposit calculations
`data[attributes][seo_title]` | **String** <br>SEO title tag
`data[attributes][seo_description]` | **String** <br>SEO meta description tag
`data[attributes][photo_id]` | **Uuid** <br>The associated Photo
`data[attributes][product_group_id]` | **Uuid** <br>The associated Product group
`data[attributes][variation_values][]` | **Array** <br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`)


### Includes

This request accepts the following includes:

`barcode`


`inventory_levels`


`photo`


`price_structure` => 
`price_tiles`




`product_group`


`properties`


`tax_category`






## Archiving a product



> How to delete a product:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/products/5d1dc51e-f579-4ebe-a6c8-617e2166221e' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5d1dc51e-f579-4ebe-a6c8-617e2166221e",
    "type": "products",
    "attributes": {
      "created_at": "2024-10-21T09:23:03.176706+00:00",
      "updated_at": "2024-10-21T09:23:03.612360+00:00",
      "archived": true,
      "archived_at": "2024-10-21T09:23:03.612360+00:00",
      "type": "products",
      "name": "iPad Pro",
      "group_name": "iPad Pro",
      "slug": "ipad-pro",
      "sku": null,
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "has_variations": true,
      "variation": true,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "excerpt": null,
      "show_in_store": true,
      "sorting_weight": 1,
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
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null,
      "variation_values": [
        "green"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "299dadf4-4612-48b0-9b65-0e6c2dc42308"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/products/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`


### Includes

This request does not accept any includes