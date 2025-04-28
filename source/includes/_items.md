# Items

The Item resource makes it possible to fetch (and search!) the following resources in a single request:

- [Product groups](#product-groups)
- [Products](#products)
- [Bundles](#bundles)

The description of the relationships and attributes of these resources can be found in their respective sections

## List items


> How to fetch a list of items:

```shell
  curl --get 'https://example.booqable.com/api/4/items'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "d7759df8-1381-4df4-832c-9ddde2efce9a",
        "type": "bundles",
        "attributes": {
          "created_at": "2027-05-05T08:14:00.000000+00:00",
          "updated_at": "2027-05-05T08:14:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "type": "bundles",
          "name": "iPad Bundle",
          "slug": "ipad-bundle",
          "product_type": "bundle",
          "extra_information": null,
          "photo_url": null,
          "description": null,
          "excerpt": null,
          "show_in_store": true,
          "sorting_weight": 0,
          "discountable": true,
          "taxable": true,
          "seo_title": null,
          "seo_description": null,
          "tag_list": [
            "tablets",
            "apple"
          ],
          "photo_id": null,
          "tax_category_id": null
        },
        "relationships": {}
      },
      {
        "id": "c721f29a-0574-4af4-8fb2-ab4715f97998",
        "type": "product_groups",
        "attributes": {
          "created_at": "2027-05-05T08:14:00.000000+00:00",
          "updated_at": "2027-05-05T08:14:00.000000+00:00",
          "type": "product_groups",
          "archived": false,
          "archived_at": null,
          "name": "iPad Pro",
          "group_name": null,
          "slug": "ipad-pro",
          "sku": "SKU",
          "lead_time": 0,
          "lag_time": 0,
          "product_type": "rental",
          "tracking_type": "trackable",
          "trackable": true,
          "has_variations": false,
          "variation": false,
          "extra_information": "Charging cable and case included",
          "photo_url": null,
          "description": "The Apple iPad Pro (2021) 12.9 inches 128GB Space Gray is one of the most powerful and fastest tablets of this moment thanks to the new M1 chip. This chip ensures that demanding apps from Adobe or 3D games run smoothly",
          "excerpt": null,
          "show_in_store": true,
          "sorting_weight": 0,
          "base_price_in_cents": 1995,
          "price_type": "simple",
          "price_period": "day",
          "deposit_in_cents": 10000,
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
          "tax_category_id": "58186c7a-50b1-4584-881d-3054f4f5790d",
          "price_ruleset_id": null,
          "price_structure_id": null,
          "allow_shortage": true,
          "shortage_limit": 3,
          "variation_fields": [],
          "flat_fee_price_in_cents": 1995,
          "structure_price_in_cents": 0,
          "stock_item_properties": []
        },
        "relationships": {}
      },
      {
        "id": "89e8b2cd-7a7e-47b2-8571-1379ad6e21f1",
        "type": "products",
        "attributes": {
          "created_at": "2027-05-05T08:14:00.000000+00:00",
          "updated_at": "2027-05-05T08:14:00.000000+00:00",
          "type": "products",
          "archived": false,
          "archived_at": null,
          "name": "iPad Pro",
          "group_name": "iPad Pro",
          "slug": "ipad-pro",
          "sku": "SKU",
          "lead_time": 0,
          "lag_time": 0,
          "product_type": "rental",
          "tracking_type": "trackable",
          "trackable": true,
          "has_variations": false,
          "variation": false,
          "extra_information": "Charging cable and case included",
          "photo_url": null,
          "description": "The Apple iPad Pro (2021) 12.9 inches 128GB Space Gray is one of the most powerful and fastest tablets of this moment thanks to the new M1 chip. This chip ensures that demanding apps from Adobe or 3D games run smoothly",
          "excerpt": null,
          "show_in_store": true,
          "sorting_weight": 1,
          "base_price_in_cents": 1995,
          "price_type": "simple",
          "price_period": "day",
          "deposit_in_cents": 10000,
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
          "tax_category_id": "58186c7a-50b1-4584-881d-3054f4f5790d",
          "price_ruleset_id": null,
          "price_structure_id": null,
          "allow_shortage": true,
          "shortage_limit": 3,
          "variation_values": [],
          "product_group_id": "c721f29a-0574-4af4-8fb2-ab4715f97998"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[items]=created_at,updated_at,type`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,bundle_items,inventory_levels`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`collection_id` | **uuid** <br>`eq`, `not_eq`
`conditions` | **hash** <br>`eq`
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
`price_period` | **enum** <br>`eq`
`price_ruleset_id` | **uuid** <br>`eq`, `not_eq`
`price_structure_id` | **uuid** <br>`eq`, `not_eq`
`price_type` | **enum** <br>`eq`
`product_group_id` | **uuid** <br>`eq`
`product_type` | **enum** <br>`eq`
`q` | **string** <br>`eq`
`seo_description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **boolean** <br>`eq`
`sku` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tag_list` | **string** <br>`eq`
`tax_category_id` | **uuid** <br>`eq`, `not_eq`
`taxable` | **boolean** <br>`eq`
`trackable` | **boolean** <br>`eq`
`tracking_type` | **enum** <br>`eq`
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

<ul>
  <li><code>barcode</code></li>
  <li><code>bundle_items</code></li>
  <li><code>inventory_levels</code></li>
  <li><code>photo</code></li>
  <li><code>properties</code></li>
</ul>


## Search items

Use advanced search to make logical filter groups with and/or operators.

> How to search for items:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/items/search'
       --header 'content-type: application/json'
       --data '{
         "fields": {
           "items": "id"
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
        "id": "569def8b-7636-476f-8a1f-be15feb8defb"
      },
      {
        "id": "90acfcac-e08a-40a8-8189-769b49dd2197"
      },
      {
        "id": "000f9d47-49fe-4495-8d4c-39a2187d00f2"
      },
      {
        "id": "b71ea42f-340e-4143-81c1-ca6a463d21ac"
      },
      {
        "id": "f5b4b96e-515c-42f6-8214-95013aa9cdc4"
      }
    ]
  }
```

### HTTP Request

`POST api/boomerang/items/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[items]=created_at,updated_at,type`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,bundle_items,inventory_levels`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`collection_id` | **uuid** <br>`eq`, `not_eq`
`conditions` | **hash** <br>`eq`
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
`price_period` | **enum** <br>`eq`
`price_ruleset_id` | **uuid** <br>`eq`, `not_eq`
`price_structure_id` | **uuid** <br>`eq`, `not_eq`
`price_type` | **enum** <br>`eq`
`product_group_id` | **uuid** <br>`eq`
`product_type` | **enum** <br>`eq`
`q` | **string** <br>`eq`
`seo_description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **boolean** <br>`eq`
`sku` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tag_list` | **string** <br>`eq`
`tax_category_id` | **uuid** <br>`eq`, `not_eq`
`taxable` | **boolean** <br>`eq`
`trackable` | **boolean** <br>`eq`
`tracking_type` | **enum** <br>`eq`
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

<ul>
  <li><code>barcode</code></li>
  <li><code>bundle_items</code></li>
  <li><code>inventory_levels</code></li>
  <li><code>photo</code></li>
  <li><code>properties</code></li>
</ul>


## Fetch an item


> How to fetch an item:

```shell
  curl --get 'https://example.booqable.com/api/4/items/15cd96a9-f5ba-4fb6-8ca3-16b2581f1385'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "15cd96a9-f5ba-4fb6-8ca3-16b2581f1385",
      "type": "product_groups",
      "attributes": {
        "created_at": "2015-07-22T22:42:00.000000+00:00",
        "updated_at": "2015-07-22T22:42:00.000000+00:00",
        "type": "product_groups",
        "archived": false,
        "archived_at": null,
        "name": "iPad Pro",
        "group_name": null,
        "slug": "ipad-pro",
        "sku": "SKU",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
        "has_variations": false,
        "variation": false,
        "extra_information": "Charging cable and case included",
        "photo_url": null,
        "description": "The Apple iPad Pro (2021) 12.9 inches 128GB Space Gray is one of the most powerful and fastest tablets of this moment thanks to the new M1 chip. This chip ensures that demanding apps from Adobe or 3D games run smoothly",
        "excerpt": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "base_price_in_cents": 1995,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 10000,
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
        "tax_category_id": "2a2acff0-f752-4c88-85d7-23015f91caff",
        "price_ruleset_id": null,
        "price_structure_id": null,
        "allow_shortage": true,
        "shortage_limit": 3,
        "variation_fields": [],
        "flat_fee_price_in_cents": 1995,
        "structure_price_in_cents": 0,
        "stock_item_properties": []
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[items]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,bundle_items,inventory_levels`


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>bundle_items</code></li>
  <li><code>inventory_levels</code></li>
  <li><code>photo</code></li>
  <li><code>properties</code></li>
</ul>

