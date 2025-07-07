# Product groups

Product groups hold general information and configuration about products.
A product group always contains at least one product. When a product group is
enabled to have variations, it can have multiple products.

Product groups are not plannable on orders. Products are the resource that is planned.

## Product Types

- **Rental:** Rental products are your main products that you rent out.
  Even if your main product is officially a service, in Booqable you will
  want to add it as a rental product.
- **Consumable:** Consumable products are products that you do not plan on getting back.
  These are meant to be small items that you plan on selling along with a rental but do
  not expect to be returned with the rest of the order.
  <aside class="warning inline">
    The <code>consumable</code> type will be renamed to <code>sales_item</code> in the near future.
  </aside>
- **Service:** Service Item or Service Products are the optional extra services (or items)
  you want to offer to your products. These are not trackable, therefore they do not have an identifier.

## Tracking Types

The tracking type determines how the product is tracked.

- **None:** Products are not tracked (only for product_type `service`, `consumable`)
- **Trackable:** Trackable Products tend to be the larger ticket items; the products you want to know specifically who has what stock item of what product and when. With trackable products, every stock item has its own identifier so you can assign and track the individual products (only for product_type `rental`).
- **Bulk:** Bulk products are for those products you don't necessarily need to track each specific stock item but rather you just need to know how many you have in stock. These tend to be your smaller ticket items or items that are quicker to replace in bulk if some are lost (only for product_type `rental`, `consumable`).

### Pricing Types

- **None:** Products are free (applies to all product types)
- **Fixed:** Charge a fixed price (applies to all product types).
- **Simple:** Apply simple pricing (depends on `price_period`, only for product_type `rental`, `service`).
- **Structure:** Applies associated price structure (only for product_type `rental`, `service`).
- **Private structure:** Applies associated private price structure (only for product_type `rental`, `service`).

## Relationships
Name | Description
-- | --
`inventory_levels` | **[Inventory levels](#inventory-levels)** `hasmany`<br>Availability of this item. 
`photo` | **[Photo](#photos)** `optional`<br>Primary [Photo](#photos) of this product group. 
`photos` | **[Photos](#photos)** `hasmany`<br>All [Photos](#photos) of this product group. The primary `photo` must be selected from this set. 
`price_ruleset` | **[Price ruleset](#price-rulesets)** `optional`<br>The [PriceRuleset](#price-ruleset) used for advanced price calculations. 
`price_structure` | **[Price structure](#price-structures)** `optional`<br>The [PriceStructure](#price-structure) to use when this product group uses tiered pricing. 
`products` | **[Products](#products)** `hasmany`<br>When this product group does **not** have variations: there will be exactly one product. When this product group **does** have variations: one or more products. These products can be distinguished by their `variation_values`. 
`properties` | **[Properties](#properties)** `hasmany`<br>Custom structured data about this product group, based on [DefaultProperties](#default-properties). These properties apply to all products in the same product group. 
`tax_category` | **[Tax category](#tax-categories)** `optional`<br>[TaxCategory](#tax-categories) for tax calculations. 


Check matching attributes under [Fields](#product-groups-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether the product group is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the product group was archived. 
`base_price_in_cents` | **integer** `readonly`<br>The value that is being calculated with (based on the current `price_type`). 
`confirm_shortage` | **boolean** `writeonly`<br>Set this to `true` to override certain shortage warnings. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`flat_fee_price_in_cents` | **integer** <br>Use this value when price type is `simple`. 
`id` | **uuid** `readonly`<br>Primary key.
`photo_base64` | **string** `writeonly`<br>Base64 encoded photo, use this field to store a main photo. 
`photo_id` | **uuid** `readonly` `nullable`<br>Primary [Photo](#photos) of this product group. 
`photo_url` | **string** `readonly` `nullable`<br>Main photo URL. 
`properties_attributes` | **array** `writeonly`<br>Create or update multiple properties associated with this product group. 
`remote_photo_url` | **string** `writeonly`<br>URL to an image on the web. 
`sorting_weight` | **integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists. 
`stock_item_properties` | **array[string]** <br>Names of custom properties for stock items of this product group. 
`structure_price_in_cents` | **integer** <br>Use this value when price type is `structure` or `private_structure`. 
`type` | **string** `readonly`<br>Always product group. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`variation_fields` | **array** <br>Array of fields that distinguish variations (e.g. color or size). `product_group.variation_fields` are the keys, and `product.variation_values` are the values, and they are matched by their index in the arrays. 


## Inherited Fields

 Name | Description
-- | --
`allow_shortage` | **boolean** <br>Whether shortages are allowed. Changing this setting affects availability, and can trigger a shortage warning. 
`buffer_time_after` | **integer** <br>The amount of seconds the item should be unavailable after a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   <code>buffer_time_after</code> is the replacement for <code>lag_time</code>.   For a short while, both attributes will be accepted and returned. </aside> 
`buffer_time_before` | **integer** <br>The amount of seconds the item should be unavailable before a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   <code>buffer_time_before</code> is the replacement for <code>lead_time</code>.   For a short while, both attributes will be accepted and returned. </aside> 
`deposit_in_cents` | **integer** <br>The value to use for deposit calculations. 
`description` | **string** `nullable`<br>Description used in the online store. 
`discountable` | **boolean** <br>Whether discounts should be applied to this product groups and products in it (note that price rules will still apply). 
`excerpt` | **string** `nullable`<br>Excerpt used in the online store. 
`extra_information` | **string** `nullable`<br>Extra information about the product group, shown on orders and documents. 
`group_name` | **string** `readonly`<br>Same as `name`. 
`has_variations` | **boolean** <br>Whether variations are enabled. Variations can be enabled after a product group has been created, but variations cannot be disabled once they have been enabled. Product group of product_type `service` cannot have variations. 
`lag_time` | **integer** <br>The amount of seconds the item should be unavailable after a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   The <code>lag_time</code> attribute will be renamed to <code>buffer_time_after</code> in the near future.   For a short while, both attributes will be accepted and returned. </aside> 
`lead_time` | **integer** <br>The amount of seconds the item should be unavailable before a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   The <code>lead_time</code> attribute will be renamed to <code>buffer_time_before</code> in the near future.   For a short while, both attributes will be accepted and returned. </aside> 
`name` | **string** <br>Name of the item. 
`price_period` | **enum** <br>The period which is the base for price calculation when price type `simple`.<br> One of: `hour`, `day`, `week`, `month`.
`price_ruleset_id` | **uuid** `nullable`<br>The [PriceRuleset](#price-ruleset) used for advanced price calculations. 
`price_structure_id` | **uuid** `nullable`<br>The [PriceStructure](#price-structure) to use when this product group uses tiered pricing. 
`price_type` | **enum** <br>How prices are calculated for this product group and all products in it.<br> One of: `structure`, `private_structure`, `fixed`, `simple`, `none`.
`product_type` | **enum** `readonly-after-create`<br>Type of product. Can only be set when creating a ProductGroup.<br><aside class="warning inline">   The <code>consumable</code> type will be renamed to <code>sales_item</code> in the near future.   For a short while, both attribute values will be accepted when creating a ProductGroup. </aside><br> One of: `bundle`, `rental`, `consumable`, `sales_item`, `service`.
`properties` | **hash** `readonly`<br>Hash of properties. Sideload the properties relation when more information is needed. 
`seo_description` | **string** `nullable`<br>SEO meta description tag. 
`seo_title` | **string** `nullable`<br>SEO title tag. 
`shortage_limit` | **integer** <br>The maximum allowed shortage for any date range. Changing this setting affects availability, and can trigger a shortage warning. 
`show_in_store` | **boolean** <br>Whether to show this product group in the online store. 
`sku` | **string** <br>Stock keeping unit. 
`slug` | **string** <br>Slug of the item. 
`tag_list` | **array[string]** <br>List of tags. 
`tax_category_id` | **uuid** `nullable`<br>[TaxCategory](#tax-categories) for tax calculations. 
`taxable` | **boolean** <br>Whether this product group is taxable. 
`trackable` | **boolean** `readonly-after-create`<br>Whether stock items are tracked. 
`tracking_type` | **enum** `readonly-after-create`<br>How the product is tracked. Can only be set when creating a ProductGroup.<br> One of: `none`, `bulk`, `trackable`.
`variation` | **boolean** `readonly`<br>Whether this Item is a variation in a [ProductGroup](#product-groups). 


## List product groups


> How to fetch a list of product groups:

```shell
  curl --get 'https://example.booqable.com/api/4/product_groups'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "f0f79b63-e2b9-4178-81f6-3b28593c5419",
        "type": "product_groups",
        "attributes": {
          "created_at": "2026-12-03T23:48:01.000000+00:00",
          "updated_at": "2026-12-03T23:48:01.000000+00:00",
          "type": "product_groups",
          "archived": false,
          "archived_at": null,
          "name": "iPad Pro",
          "group_name": null,
          "slug": "ipad-pro",
          "sku": "SKU",
          "lead_time": 0,
          "lag_time": 0,
          "buffer_time_before": 0,
          "buffer_time_after": 0,
          "product_type": "rental",
          "tracking_type": "bulk",
          "trackable": false,
          "has_variations": false,
          "variation": false,
          "extra_information": null,
          "photo_url": null,
          "description": null,
          "excerpt": null,
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
          "tax_category_id": null,
          "price_ruleset_id": null,
          "price_structure_id": null,
          "allow_shortage": false,
          "shortage_limit": 0,
          "variation_fields": [],
          "flat_fee_price_in_cents": 0,
          "structure_price_in_cents": 0,
          "stock_item_properties": []
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/product_groups`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[product_groups]=created_at,updated_at,type`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,properties`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`allow_shortage` | **boolean** <br>`eq`
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`buffer_time_after` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`buffer_time_before` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`collection_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`discountable` | **boolean** <br>`eq`
`excerpt` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`extra_information` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`flat_fee_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
`q` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`shortage_limit` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`show_in_store` | **boolean** <br>`eq`
`sku` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`structure_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
  <li><code>photo</code></li>
  <li><code>properties</code></li>
</ul>


## Search product groups

Use advanced search to make logical filter groups with and/or operators.

> How to search for product groups:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/product_groups/search'
       --header 'content-type: application/json'
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
        "id": "4c211b3b-f619-45e3-8a3a-c020abe4ddf8"
      },
      {
        "id": "b0871c21-545a-427e-87a2-34b8dd0977b6"
      },
      {
        "id": "caa90af2-e33d-464c-836f-2e933d2bc1c8"
      }
    ]
  }
```

### HTTP Request

`POST /api/4/product_groups/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[product_groups]=created_at,updated_at,type`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,properties`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`allow_shortage` | **boolean** <br>`eq`
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`buffer_time_after` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`buffer_time_before` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`collection_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`discountable` | **boolean** <br>`eq`
`excerpt` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`extra_information` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`flat_fee_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
`q` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`shortage_limit` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`show_in_store` | **boolean** <br>`eq`
`sku` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`structure_price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
  <li><code>photo</code></li>
  <li><code>properties</code></li>
</ul>


## Fetch a product group


> How to fetch a product group:

```shell
  curl --get 'https://example.booqable.com/api/4/product_groups/edabcdd8-89b1-46a8-8163-98ae0d275cd1'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "edabcdd8-89b1-46a8-8163-98ae0d275cd1",
      "type": "product_groups",
      "attributes": {
        "created_at": "2025-01-22T17:59:01.000000+00:00",
        "updated_at": "2025-01-22T17:59:01.000000+00:00",
        "type": "product_groups",
        "archived": false,
        "archived_at": null,
        "name": "iPad Pro",
        "group_name": null,
        "slug": "ipad-pro",
        "sku": "SKU",
        "lead_time": 0,
        "lag_time": 0,
        "buffer_time_before": 0,
        "buffer_time_after": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": false,
        "variation": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
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
        "tax_category_id": null,
        "price_ruleset_id": null,
        "price_structure_id": null,
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_fields": [],
        "flat_fee_price_in_cents": 0,
        "structure_price_in_cents": 0,
        "stock_item_properties": []
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/product_groups/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[product_groups]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,properties,tax_category`


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>photo</code></li>
  <li>
    <code>price_structure</code>
    <ul>
      <li><code>price_tiles</code></li>
    </ul>
  </li>
  <li><code>products</code></li>
  <li><code>properties</code></li>
  <li><code>tax_category</code></li>
</ul>


## Create a product group


> How to create a product group:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/product_groups'
       --header 'content-type: application/json'
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
      "id": "56ea2eb6-d09f-4f5d-8482-6eb1e7af9908",
      "type": "product_groups",
      "attributes": {
        "created_at": "2018-12-20T06:18:00.000000+00:00",
        "updated_at": "2018-12-20T06:18:00.000000+00:00",
        "type": "product_groups",
        "archived": false,
        "archived_at": null,
        "name": "iPad mini",
        "group_name": null,
        "slug": "ipad-mini",
        "sku": "IPAD_MINI",
        "lead_time": 0,
        "lag_time": 0,
        "buffer_time_before": 0,
        "buffer_time_after": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
        "has_variations": false,
        "variation": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
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
        "tax_category_id": null,
        "price_ruleset_id": null,
        "price_structure_id": null,
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_fields": [],
        "flat_fee_price_in_cents": 0,
        "structure_price_in_cents": 0,
        "stock_item_properties": []
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/product_groups`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[product_groups]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,properties,tax_category`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][allow_shortage]` | **boolean** <br>Whether shortages are allowed. Changing this setting affects availability, and can trigger a shortage warning. 
`data[attributes][buffer_time_after]` | **integer** <br>The amount of seconds the item should be unavailable after a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   <code>buffer_time_after</code> is the replacement for <code>lag_time</code>.   For a short while, both attributes will be accepted and returned. </aside> 
`data[attributes][buffer_time_before]` | **integer** <br>The amount of seconds the item should be unavailable before a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   <code>buffer_time_before</code> is the replacement for <code>lead_time</code>.   For a short while, both attributes will be accepted and returned. </aside> 
`data[attributes][confirm_shortage]` | **boolean** <br>Set this to `true` to override certain shortage warnings. 
`data[attributes][deposit_in_cents]` | **integer** <br>The value to use for deposit calculations. 
`data[attributes][discountable]` | **boolean** <br>Whether discounts should be applied to this product groups and products in it (note that price rules will still apply). 
`data[attributes][excerpt]` | **string** <br>Excerpt used in the online store. 
`data[attributes][extra_information]` | **string** <br>Extra information about the product group, shown on orders and documents. 
`data[attributes][flat_fee_price_in_cents]` | **integer** <br>Use this value when price type is `simple`. 
`data[attributes][has_variations]` | **boolean** <br>Whether variations are enabled. Variations can be enabled after a product group has been created, but variations cannot be disabled once they have been enabled. Product group of product_type `service` cannot have variations. 
`data[attributes][lag_time]` | **integer** <br>The amount of seconds the item should be unavailable after a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   The <code>lag_time</code> attribute will be renamed to <code>buffer_time_after</code> in the near future.   For a short while, both attributes will be accepted and returned. </aside> 
`data[attributes][lead_time]` | **integer** <br>The amount of seconds the item should be unavailable before a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   The <code>lead_time</code> attribute will be renamed to <code>buffer_time_before</code> in the near future.   For a short while, both attributes will be accepted and returned. </aside> 
`data[attributes][name]` | **string** <br>Name of the item. 
`data[attributes][photo_base64]` | **string** <br>Base64 encoded photo, use this field to store a main photo. 
`data[attributes][price_period]` | **enum** <br>The period which is the base for price calculation when price type `simple`.<br> One of: `hour`, `day`, `week`, `month`.
`data[attributes][price_ruleset_id]` | **uuid** <br>The [PriceRuleset](#price-ruleset) used for advanced price calculations. 
`data[attributes][price_structure_id]` | **uuid** <br>The [PriceStructure](#price-structure) to use when this product group uses tiered pricing. 
`data[attributes][price_type]` | **enum** <br>How prices are calculated for this product group and all products in it.<br> One of: `structure`, `private_structure`, `fixed`, `simple`, `none`.
`data[attributes][product_type]` | **enum** <br>Type of product. Can only be set when creating a ProductGroup.<br><aside class="warning inline">   The <code>consumable</code> type will be renamed to <code>sales_item</code> in the near future.   For a short while, both attribute values will be accepted when creating a ProductGroup. </aside><br> One of: `bundle`, `rental`, `consumable`, `sales_item`, `service`.
`data[attributes][properties_attributes][]` | **array** <br>Create or update multiple properties associated with this product group. 
`data[attributes][remote_photo_url]` | **string** <br>URL to an image on the web. 
`data[attributes][seo_description]` | **string** <br>SEO meta description tag. 
`data[attributes][seo_title]` | **string** <br>SEO title tag. 
`data[attributes][shortage_limit]` | **integer** <br>The maximum allowed shortage for any date range. Changing this setting affects availability, and can trigger a shortage warning. 
`data[attributes][show_in_store]` | **boolean** <br>Whether to show this product group in the online store. 
`data[attributes][sku]` | **string** <br>Stock keeping unit. 
`data[attributes][slug]` | **string** <br>Slug of the item. 
`data[attributes][sorting_weight]` | **integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists. 
`data[attributes][stock_item_properties]` | **array[string]** <br>Names of custom properties for stock items of this product group. 
`data[attributes][structure_price_in_cents]` | **integer** <br>Use this value when price type is `structure` or `private_structure`. 
`data[attributes][tag_list]` | **array[string]** <br>List of tags. 
`data[attributes][tax_category_id]` | **uuid** <br>[TaxCategory](#tax-categories) for tax calculations. 
`data[attributes][taxable]` | **boolean** <br>Whether this product group is taxable. 
`data[attributes][trackable]` | **boolean** <br>Whether stock items are tracked. 
`data[attributes][tracking_type]` | **enum** <br>How the product is tracked. Can only be set when creating a ProductGroup.<br> One of: `none`, `bulk`, `trackable`.
`data[attributes][variation_fields][]` | **array** <br>Array of fields that distinguish variations (e.g. color or size). `product_group.variation_fields` are the keys, and `product.variation_values` are the values, and they are matched by their index in the arrays. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>photo</code></li>
  <li>
    <code>price_structure</code>
    <ul>
      <li><code>price_tiles</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
  <li><code>tax_category</code></li>
</ul>


## Update a product group


> How to update a product group:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/product_groups/a32d904d-cb11-4b83-80c4-5974eff77dc8'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "a32d904d-cb11-4b83-80c4-5974eff77dc8",
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
      "id": "a32d904d-cb11-4b83-80c4-5974eff77dc8",
      "type": "product_groups",
      "attributes": {
        "created_at": "2017-06-27T18:12:01.000000+00:00",
        "updated_at": "2017-06-27T18:12:01.000000+00:00",
        "type": "product_groups",
        "archived": false,
        "archived_at": null,
        "name": "iPad mini",
        "group_name": null,
        "slug": "ipad-pro",
        "sku": "SKU",
        "lead_time": 0,
        "lag_time": 0,
        "buffer_time_before": 0,
        "buffer_time_after": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": false,
        "variation": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
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
        "tax_category_id": null,
        "price_ruleset_id": null,
        "price_structure_id": null,
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_fields": [],
        "flat_fee_price_in_cents": 0,
        "structure_price_in_cents": 0,
        "stock_item_properties": []
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/product_groups/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[product_groups]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=photo,properties,tax_category`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][allow_shortage]` | **boolean** <br>Whether shortages are allowed. Changing this setting affects availability, and can trigger a shortage warning. 
`data[attributes][buffer_time_after]` | **integer** <br>The amount of seconds the item should be unavailable after a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   <code>buffer_time_after</code> is the replacement for <code>lag_time</code>.   For a short while, both attributes will be accepted and returned. </aside> 
`data[attributes][buffer_time_before]` | **integer** <br>The amount of seconds the item should be unavailable before a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   <code>buffer_time_before</code> is the replacement for <code>lead_time</code>.   For a short while, both attributes will be accepted and returned. </aside> 
`data[attributes][confirm_shortage]` | **boolean** <br>Set this to `true` to override certain shortage warnings. 
`data[attributes][deposit_in_cents]` | **integer** <br>The value to use for deposit calculations. 
`data[attributes][discountable]` | **boolean** <br>Whether discounts should be applied to this product groups and products in it (note that price rules will still apply). 
`data[attributes][excerpt]` | **string** <br>Excerpt used in the online store. 
`data[attributes][extra_information]` | **string** <br>Extra information about the product group, shown on orders and documents. 
`data[attributes][flat_fee_price_in_cents]` | **integer** <br>Use this value when price type is `simple`. 
`data[attributes][has_variations]` | **boolean** <br>Whether variations are enabled. Variations can be enabled after a product group has been created, but variations cannot be disabled once they have been enabled. Product group of product_type `service` cannot have variations. 
`data[attributes][lag_time]` | **integer** <br>The amount of seconds the item should be unavailable after a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   The <code>lag_time</code> attribute will be renamed to <code>buffer_time_after</code> in the near future.   For a short while, both attributes will be accepted and returned. </aside> 
`data[attributes][lead_time]` | **integer** <br>The amount of seconds the item should be unavailable before a reservation. Changing this setting affects availability, and can trigger a shortage warning.<br><aside class="warning inline">   The <code>lead_time</code> attribute will be renamed to <code>buffer_time_before</code> in the near future.   For a short while, both attributes will be accepted and returned. </aside> 
`data[attributes][name]` | **string** <br>Name of the item. 
`data[attributes][photo_base64]` | **string** <br>Base64 encoded photo, use this field to store a main photo. 
`data[attributes][price_period]` | **enum** <br>The period which is the base for price calculation when price type `simple`.<br> One of: `hour`, `day`, `week`, `month`.
`data[attributes][price_ruleset_id]` | **uuid** <br>The [PriceRuleset](#price-ruleset) used for advanced price calculations. 
`data[attributes][price_structure_id]` | **uuid** <br>The [PriceStructure](#price-structure) to use when this product group uses tiered pricing. 
`data[attributes][price_type]` | **enum** <br>How prices are calculated for this product group and all products in it.<br> One of: `structure`, `private_structure`, `fixed`, `simple`, `none`.
`data[attributes][product_type]` | **enum** <br>Type of product. Can only be set when creating a ProductGroup.<br><aside class="warning inline">   The <code>consumable</code> type will be renamed to <code>sales_item</code> in the near future.   For a short while, both attribute values will be accepted when creating a ProductGroup. </aside><br> One of: `bundle`, `rental`, `consumable`, `sales_item`, `service`.
`data[attributes][properties_attributes][]` | **array** <br>Create or update multiple properties associated with this product group. 
`data[attributes][remote_photo_url]` | **string** <br>URL to an image on the web. 
`data[attributes][seo_description]` | **string** <br>SEO meta description tag. 
`data[attributes][seo_title]` | **string** <br>SEO title tag. 
`data[attributes][shortage_limit]` | **integer** <br>The maximum allowed shortage for any date range. Changing this setting affects availability, and can trigger a shortage warning. 
`data[attributes][show_in_store]` | **boolean** <br>Whether to show this product group in the online store. 
`data[attributes][sku]` | **string** <br>Stock keeping unit. 
`data[attributes][slug]` | **string** <br>Slug of the item. 
`data[attributes][sorting_weight]` | **integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists. 
`data[attributes][stock_item_properties]` | **array[string]** <br>Names of custom properties for stock items of this product group. 
`data[attributes][structure_price_in_cents]` | **integer** <br>Use this value when price type is `structure` or `private_structure`. 
`data[attributes][tag_list]` | **array[string]** <br>List of tags. 
`data[attributes][tax_category_id]` | **uuid** <br>[TaxCategory](#tax-categories) for tax calculations. 
`data[attributes][taxable]` | **boolean** <br>Whether this product group is taxable. 
`data[attributes][trackable]` | **boolean** <br>Whether stock items are tracked. 
`data[attributes][tracking_type]` | **enum** <br>How the product is tracked. Can only be set when creating a ProductGroup.<br> One of: `none`, `bulk`, `trackable`.
`data[attributes][variation_fields][]` | **array** <br>Array of fields that distinguish variations (e.g. color or size). `product_group.variation_fields` are the keys, and `product.variation_values` are the values, and they are matched by their index in the arrays. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>photo</code></li>
  <li>
    <code>price_structure</code>
    <ul>
      <li><code>price_tiles</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
  <li><code>tax_category</code></li>
</ul>


## Archive a product group


> How to delete a product group:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/product_groups/0845ee1b-c095-41c8-8179-28d5fe7fd2f3'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "0845ee1b-c095-41c8-8179-28d5fe7fd2f3",
      "type": "product_groups",
      "attributes": {
        "created_at": "2025-02-14T15:30:00.000000+00:00",
        "updated_at": "2025-02-14T15:30:00.000000+00:00",
        "type": "product_groups",
        "archived": true,
        "archived_at": "2025-02-14T15:30:00.000000+00:00",
        "name": "iPad Pro",
        "group_name": null,
        "slug": "0845ee1b-c095-41c8-8179-28d5fe7fd2f3",
        "sku": "SKU",
        "lead_time": 0,
        "lag_time": 0,
        "buffer_time_before": 0,
        "buffer_time_after": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": false,
        "variation": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
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
        "tax_category_id": null,
        "price_ruleset_id": null,
        "price_structure_id": null,
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_fields": [],
        "flat_fee_price_in_cents": 0,
        "structure_price_in_cents": 0,
        "stock_item_properties": []
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/product_groups/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[product_groups]=created_at,updated_at,type`


### Includes

This request does not accept any includes