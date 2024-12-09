# Products

Products are items that can be booked on orders. They always belong to a product group
and can only be created separately if the group has variations enabled.

A product inherits most of its attributes from the product group.
Inherited attributes can only be changed through the product group,
and will then be applied to all products that belong to the same
product group.

The following attributes/relations can be configured on individual
products when variations are enabled:

  - `variation_values`, to make each variation distinct
  - `sorting_weight`, to control order in which variations are shown
  - `base_price_in_cents`, to give each variation its own price
  - `photo`, to assign a different photo to each variation
  - `barcode`, to be able to scan and identify different variations

## Relationships
Name | Description
-- | --
`barcode` | **[Barcode](#barcodes)** `optional`<br>The barcode that points to this product. 
`inventory_levels` | **[Inventory levels](#inventory-levels)** `hasmany`<br>Availability of this product. 
`photo` | **[Photo](#photos)** `optional`<br>Main photo. 
`price_ruleset` | **[Price ruleset](#price-rulesets)** `optional`<br>The price ruleset to use for advanced price calculations. This is inherited from the product group this product belongs to. 
`price_structure` | **[Price structure](#price-structures)** `optional`<br>The price strucure to use when this product uses tiered pricing. This is inherited from the product group this product belongs to. 
`product_group` | **[Product group](#product-groups)** `required`<br>The product group this product belongs to. When a product group _does not_ have variations, there will be exactly one product record. When there variations are enabled, then there can be multiple product records. 
`properties` | **[Properties](#properties)** `hasmany`<br>Custom structured data about this product, based on [DefaultProperties](#default-properties). These are inherited from the product group this product belongs to. 
`tax_category` | **[Tax category](#tax-categories)** `optional`<br>Tax category for tax calculations. 


Check matching attributes under [Fields](#products-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether item is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the item was archived. 
`base_price_in_cents` | **integer** <br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group. 
`confirm_shortage` | **boolean** `writeonly`<br>Whether to confirm the shortage (over limit by changing `shortage_limit`). 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`photo_id` | **uuid** `nullable`<br>Main photo. 
`photo_url` | **string** `readonly` `nullable`<br>Main photo url. 
`product_group_id` | **uuid** `readonly-after-create`<br>The product group this product belongs to. When a product group _does not_ have variations, there will be exactly one product record. When there variations are enabled, then there can be multiple product records. 
`sku` | **string** <br>Stock keeping unit. 
`sorting_weight` | **integer** <br>Defines sorting of variations within a product group. The lower the weight - the higher it shows up in lists. 
`type` | **string** `readonly`<br>Always `product`. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`variation_values` | **array[string]** <br>List of values corresponding to the fields defined in `product_group.variation_fields`. Values should be in the same order as the fields. `product_group.variation_fields` are the keys, and `product.variation_values` are the values, and they are matched by their index in the arrays. 


## Inherited Fields

 Name | Description
-- | --
`allow_shortage` | **boolean** `readonly`<br>Whether shortages are allowed. 
`deposit_in_cents` | **integer** `readonly`<br>The value to use for deposit calculations. 
`description` | **string** `readonly` `nullable`<br>Description used in the online store. 
`discountable` | **boolean** `readonly`<br>Whether discounts should be applied to this item (note that price rules will still apply). 
`excerpt` | **string** `readonly` `nullable`<br>Excerpt used in the online store. 
`extra_information` | **string** `readonly` `nullable`<br>Extra information about the item, shown on orders and documents. 
`group_name` | **string** `readonly`<br>The name of the product group. 
`has_variations` | **boolean** `readonly`<br>Whether variations are enabled. Not applicable for product_type `service`. 
`lag_time` | **integer** `readonly`<br>The amount of seconds the item should be unavailable after a reservation. 
`lead_time` | **integer** `readonly`<br>The amount of seconds the item should be unavailable before a reservation. 
`name` | **string** `readonly`<br>Name of the item (based on product group and `variations_values`). 
`price_period` | **enum** `readonly`<br>The period which is the base for price calculation when price type `simple`.<br> One of: `hour`, `day`, `week`, `month`.
`price_ruleset_id` | **uuid** `readonly` `nullable`<br>The price ruleset to use for advanced price calculations. This is inherited from the product group this product belongs to. 
`price_structure_id` | **uuid** `readonly` `nullable`<br>The price strucure to use when this product uses tiered pricing. This is inherited from the product group this product belongs to. 
`price_type` | **enum** `readonly`<br>They way prices are calculated for this product.<br> One of: `structure`, `private_structure`, `fixed`, `simple`, `none`.
`product_type` | **enum** `readonly`<br>Type of product.<br> One of: `rental`, `consumable`, `service`.
`properties` | **hash** `readonly`<br>Key value pairs of associated properties. 
`seo_description` | **string** `readonly` `nullable`<br>SEO meta description tag. 
`seo_title` | **string** `readonly` `nullable`<br>SEO title tag. 
`shortage_limit` | **integer** `readonly`<br>The maximum allowed shortage for any date range. 
`show_in_store` | **boolean** `readonly`<br>Whether to show this item in the online. 
`slug` | **string** `readonly`<br>Slug of the product. 
`tag_list` | **array** `readonly`<br>List of tags. 
`tax_category_id` | **uuid** `readonly` `nullable`<br>Tax category for tax calculations. 
`taxable` | **boolean** `readonly`<br>Whether item is taxable. 
`trackable` | **boolean** `readonly`<br>Whether stock items are tracked. 
`tracking_type` | **enum** `readonly`<br>How the product is tracked.<br> One of: `none`, `bulk`, `trackable`.
`variation` | **boolean** `readonly`<br>Whether this Item is a variation in a product group. 


## Listing products


> How to fetch a list of products:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/products'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "ed6e7fb4-7f13-4729-8dce-0f8b8c640d0b",
        "type": "products",
        "attributes": {
          "created_at": "2017-02-21T06:58:03.000000+00:00",
          "updated_at": "2017-02-21T06:58:03.000000+00:00",
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
          "allow_shortage": false,
          "shortage_limit": 0,
          "variation_values": [
            "green"
          ],
          "product_group_id": "66a43973-a27a-4282-8f4a-c125934b1469"
        },
        "relationships": {}
      },
      {
        "id": "e78aa4d3-4a0b-4904-8980-60f6cc41d84d",
        "type": "products",
        "attributes": {
          "created_at": "2017-02-21T06:58:03.000000+00:00",
          "updated_at": "2017-02-21T06:58:03.000000+00:00",
          "archived": false,
          "archived_at": null,
          "type": "products",
          "name": "iPad Pro - blue",
          "group_name": "iPad Pro",
          "slug": "ipad-pro-blue",
          "sku": "PRODUCT 1000050",
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
          "allow_shortage": false,
          "shortage_limit": 0,
          "variation_values": [
            "blue"
          ],
          "product_group_id": "66a43973-a27a-4282-8f4a-c125934b1469"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`allow_shortage` | **boolean** <br>`eq`
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`collection_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`discountable` | **boolean** <br>`eq`
`excerpt` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`extra_information` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`group_name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`has_variations` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`lag_time` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lead_time` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`photo_id` | **uuid** <br>`eq`, `not_eq`
`price_period` | **string_enum** <br>`eq`
`price_ruleset_id` | **uuid** <br>`eq`, `not_eq`
`price_structure_id` | **uuid** <br>`eq`, `not_eq`
`price_type` | **string_enum** <br>`eq`
`product_group_id` | **uuid** <br>`eq`, `not_eq`
`product_type` | **string_enum** <br>`eq`
`q` | **string** <br>`eq`
`seo_description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`shortage_limit` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`show_in_store` | **boolean** <br>`eq`
`sku` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tag_list` | **array** <br>`eq`
`tax_category_id` | **uuid** <br>`eq`, `not_eq`
`taxable` | **boolean** <br>`eq`
`trackable` | **boolean** <br>`eq`
`tracking_type` | **string_enum** <br>`eq`
`type` | **string** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`variation` | **boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`archived` | **array** <br>`count`
`base_price_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`discountable` | **array** <br>`count`
`price_period` | **array** <br>`count`
`price_type` | **array** <br>`count`
`product_type` | **array** <br>`count`
`show_in_store` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`tax_category_id` | **array** <br>`count`
`taxable` | **array** <br>`count`
`total` | **array** <br>`count`
`tracking_type` | **array** <br>`count`


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
       --url 'https://example.booqable.com/api/boomerang/products/search'
       --header 'content-type: application/json'
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
        "id": "14ec83de-d661-4078-8309-4f5f36813f83"
      },
      {
        "id": "72a41c5e-63c7-4472-888d-91a3231c4a27"
      },
      {
        "id": "770bd85c-629f-42e8-8a11-2197aa83f218"
      },
      {
        "id": "5b6bf5cc-4d27-4c95-8d55-9b672d09fc2c"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`allow_shortage` | **boolean** <br>`eq`
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`collection_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`discountable` | **boolean** <br>`eq`
`excerpt` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`extra_information` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`group_name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`has_variations` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`lag_time` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lead_time` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`photo_id` | **uuid** <br>`eq`, `not_eq`
`price_period` | **string_enum** <br>`eq`
`price_ruleset_id` | **uuid** <br>`eq`, `not_eq`
`price_structure_id` | **uuid** <br>`eq`, `not_eq`
`price_type` | **string_enum** <br>`eq`
`product_group_id` | **uuid** <br>`eq`, `not_eq`
`product_type` | **string_enum** <br>`eq`
`q` | **string** <br>`eq`
`seo_description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`shortage_limit` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`show_in_store` | **boolean** <br>`eq`
`sku` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tag_list` | **array** <br>`eq`
`tax_category_id` | **uuid** <br>`eq`, `not_eq`
`taxable` | **boolean** <br>`eq`
`trackable` | **boolean** <br>`eq`
`tracking_type` | **string_enum** <br>`eq`
`type` | **string** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`variation` | **boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`archived` | **array** <br>`count`
`base_price_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`discountable` | **array** <br>`count`
`price_period` | **array** <br>`count`
`price_type` | **array** <br>`count`
`product_type` | **array** <br>`count`
`show_in_store` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`tax_category_id` | **array** <br>`count`
`taxable` | **array** <br>`count`
`total` | **array** <br>`count`
`tracking_type` | **array** <br>`count`


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
  curl --get 'https://example.booqable.com/api/boomerang/products/8f191698-6a00-445a-8b40-3f5449981539'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "8f191698-6a00-445a-8b40-3f5449981539",
      "type": "products",
      "attributes": {
        "created_at": "2022-10-14T09:41:00.000000+00:00",
        "updated_at": "2022-10-14T09:41:00.000000+00:00",
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
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_values": [
          "green"
        ],
        "product_group_id": "c22ea0d0-9487-4cab-86f8-2859a76f32e4"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`


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
       --url 'https://example.booqable.com/api/boomerang/products'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "products",
           "attributes": {
             "product_group_id": "a048e1e3-6c98-4b3f-8a9b-e693eefeebac",
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
      "id": "ccab90b8-7b93-4828-8ec0-7de6cb6e0c4a",
      "type": "products",
      "attributes": {
        "created_at": "2017-11-22T20:35:01.000000+00:00",
        "updated_at": "2017-11-22T20:35:01.000000+00:00",
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
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_values": [
          "red"
        ],
        "product_group_id": "a048e1e3-6c98-4b3f-8a9b-e693eefeebac"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][base_price_in_cents]` | **integer** <br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group. 
`data[attributes][confirm_shortage]` | **boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`). 
`data[attributes][photo_id]` | **uuid** <br>Main photo. 
`data[attributes][product_group_id]` | **uuid** <br>The product group this product belongs to. When a product group _does not_ have variations, there will be exactly one product record. When there variations are enabled, then there can be multiple product records. 
`data[attributes][sku]` | **string** <br>Stock keeping unit. 
`data[attributes][sorting_weight]` | **integer** <br>Defines sorting of variations within a product group. The lower the weight - the higher it shows up in lists. 
`data[attributes][variation_values]` | **array[string]** <br>List of values corresponding to the fields defined in `product_group.variation_fields`. Values should be in the same order as the fields. `product_group.variation_fields` are the keys, and `product.variation_values` are the values, and they are matched by their index in the arrays. 


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
       --url 'https://example.booqable.com/api/boomerang/products/d2da581f-c48e-4b27-8d9d-9fc0d8b00c8f'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "d2da581f-c48e-4b27-8d9d-9fc0d8b00c8f",
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
      "id": "d2da581f-c48e-4b27-8d9d-9fc0d8b00c8f",
      "type": "products",
      "attributes": {
        "created_at": "2027-05-05T21:58:04.000000+00:00",
        "updated_at": "2027-05-05T21:58:04.000000+00:00",
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
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_values": [
          "red"
        ],
        "product_group_id": "302a3d1f-b536-467c-8597-35c1733fc1a7"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][base_price_in_cents]` | **integer** <br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group. 
`data[attributes][confirm_shortage]` | **boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`). 
`data[attributes][photo_id]` | **uuid** <br>Main photo. 
`data[attributes][product_group_id]` | **uuid** <br>The product group this product belongs to. When a product group _does not_ have variations, there will be exactly one product record. When there variations are enabled, then there can be multiple product records. 
`data[attributes][sku]` | **string** <br>Stock keeping unit. 
`data[attributes][sorting_weight]` | **integer** <br>Defines sorting of variations within a product group. The lower the weight - the higher it shows up in lists. 
`data[attributes][variation_values]` | **array[string]** <br>List of values corresponding to the fields defined in `product_group.variation_fields`. Values should be in the same order as the fields. `product_group.variation_fields` are the keys, and `product.variation_values` are the values, and they are matched by their index in the arrays. 


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
       --url 'https://example.booqable.com/api/boomerang/products/5fe125ba-4a82-4fad-8a18-03ea09db75a3'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "5fe125ba-4a82-4fad-8a18-03ea09db75a3",
      "type": "products",
      "attributes": {
        "created_at": "2021-02-18T21:58:00.000000+00:00",
        "updated_at": "2021-02-18T21:58:00.000000+00:00",
        "archived": true,
        "archived_at": "2021-02-18T21:58:00.000000+00:00",
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
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_values": [
          "green"
        ],
        "product_group_id": "a220adae-27d9-4298-8e37-e44d9f89f5db"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[products]=created_at,updated_at,archived`


### Includes

This request does not accept any includes