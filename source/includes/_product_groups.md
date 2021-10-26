# Product groups

Product groups hold general information and configuration about products. A product group is always associated with at least one product. When a product group is enabled to have variations, it can have multiple products. Note that product groups are not plannable on orders.

**A product group supports the following product types:**

- **Rental:** Rental products are your main products that you rent out. Even if your main product is officially a service, in Booqable you will want to add it as a rental product.
- **Conusmable:** Consumable products are products that you do not plan on getting back. These are meant to be small items that you plan on selling along with a rental but do not expect to be returned with the rest of the order.
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
`name` | **String**<br>Name of the item
`slug` | **String** `readonly`<br>Slug of the item
`sku` | **String**<br>Stock keeping unit
`type` | **String** `readonly`<br>One of `ProductGroup`, `Product`, `Bundle`
`lead_time` | **Integer**<br>The amount of seconds the item should be unavailable before a reservation
`lag_time` | **Integer**<br>The amount of seconds the item should be unavailable after a reservation
`product_type` | **String**<br>One of `rental`, `consumable`, `service`
`tracking_type` | **String**<br>Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`trackable` | **Boolean**<br>Wheter stock items are tracked
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `readonly`<br>When the item was archived
`extra_information` | **String** `nullable`<br>Extra information about the item, shown on orders and documents
`photo_url` | **String** `readonly`<br>Main photo url
`photo_base64` | **String** `writeonly`<br>Base64 encoded photo, use this field to store a main photo
`description` | **String** `nullable`<br>Description used in the online store
`show_in_store` | **Boolean**<br>Whether to show this item in the online
`sorting_weight` | **Integer**<br>Defines sort order in the online store, the higher the weight - the higher it shows up in lists
`base_price_in_cents` | **Integer** `readonly`<br>The base price in cents (based on the current `price_type`)
`price_type` | **String**<br>One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`price_period` | **String**<br>One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`flat_fee_price_in_cents` | **Integer**<br>Use this value when price type is `simple`
`structure_price_in_cents` | **Integer**<br>Use this value when price type is `structure` or `private_structure`
`deposit_in_cents` | **Integer**<br>The value to use for deposit calculations
`discountable` | **Boolean**<br>Whether discounts should be applied to this item (note that price rules will still apply)
`taxable` | **Boolean**<br>Whether item is taxable
`tag_list` | **Array**<br>List of tags
`properties` | **Hash** `readonly`<br>Key value pairs of associated properties
`tax_category_id` | **Uuid**<br>The associated Tax category
`allow_shortage` | **Boolean**<br>Whether shortages are allowed
`shortage_limit` | **Integer**<br>The maximum allowed shortage for any date range
`variation_fields` | **Array**<br>Array of fields that distinguish variations (e.g. color or size)
`quantity` | **Integer** `writeonly`<br>When creating a product group you can specify the quantity of items you have in stock. Note that for a trackable product group, stock items are generated automatically based on this quantity
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)


## Relationships
Product groups have the following relationships:

Name | Description
- | -
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`products` | **Products** `readonly`<br>Associated Products


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
      "id": "f6ac1d41-f9e5-4b97-a7d6-55a6df60f3b2",
      "type": "product_groups",
      "attributes": {
        "name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": "sku",
        "type": "ProductGroup",
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
        "allow_shortage": false,
        "shortage_limit": 0,
        "variation_fields": []
      },
      "relationships": {
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[item_group_id]=f6ac1d41-f9e5-4b97-a7d6-55a6df60f3b2"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/search/items?filter%5Btype%5D=product_group&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/search/items?filter%5Btype%5D=product_group&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/search/items?filter%5Btype%5D=product_group&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/product_groups`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-26T09:51:27Z`
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
`lead_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`trackable` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`extra_information` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`allow_shortage` | **Boolean**<br>`eq`
`shortage_limit` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


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
## Fetching a product group



> How to fetch a product group:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/product_groups/a6a744b1-74bd-4fc4-834f-b8b8da6ac314' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a6a744b1-74bd-4fc4-834f-b8b8da6ac314",
    "type": "product_groups",
    "attributes": {
      "name": "iPad Pro",
      "slug": "ipad-pro",
      "sku": "sku",
      "type": "ProductGroup",
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
      "allow_shortage": false,
      "shortage_limit": 0,
      "variation_fields": []
    },
    "relationships": {
      "tax_category": {
        "links": {
          "related": null
        }
      },
      "products": {
        "links": {
          "related": "api/boomerang/products?filter[item_group_id]=a6a744b1-74bd-4fc4-834f-b8b8da6ac314"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`tax_category`


`properties`


`barcode`






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
    "id": "03f6b159-4297-40bb-b6b8-34b572b4ef5a",
    "type": "product_groups",
    "attributes": {
      "name": "iPad mini",
      "slug": "ipad-mini",
      "sku": "I_PAD_MINI",
      "type": "ProductGroup",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "trackable",
      "trackable": true,
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
      "tag_list": [
        "tablets",
        "apple"
      ],
      "properties": {},
      "tax_category_id": null,
      "allow_shortage": false,
      "shortage_limit": 0,
      "variation_fields": []
    },
    "relationships": {
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "products": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/product_groups?data%5Battributes%5D%5Bname%5D=iPad+mini&data%5Battributes%5D%5Bprice_period%5D=day&data%5Battributes%5D%5Bprice_type%5D=simple&data%5Battributes%5D%5Btag_list%5D%5B%5D=tablets&data%5Battributes%5D%5Btag_list%5D%5B%5D=apple&data%5Battributes%5D%5Btrackable%5D=true&data%5Battributes%5D%5Btracking_type%5D=trackable&data%5Btype%5D=product_groups&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/product_groups?data%5Battributes%5D%5Bname%5D=iPad+mini&data%5Battributes%5D%5Bprice_period%5D=day&data%5Battributes%5D%5Bprice_type%5D=simple&data%5Battributes%5D%5Btag_list%5D%5B%5D=tablets&data%5Battributes%5D%5Btag_list%5D%5B%5D=apple&data%5Battributes%5D%5Btrackable%5D=true&data%5Battributes%5D%5Btracking_type%5D=trackable&data%5Btype%5D=product_groups&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/product_groups?data%5Battributes%5D%5Bname%5D=iPad+mini&data%5Battributes%5D%5Bprice_period%5D=day&data%5Battributes%5D%5Bprice_type%5D=simple&data%5Battributes%5D%5Btag_list%5D%5B%5D=tablets&data%5Battributes%5D%5Btag_list%5D%5B%5D=apple&data%5Battributes%5D%5Btrackable%5D=true&data%5Battributes%5D%5Btracking_type%5D=trackable&data%5Btype%5D=product_groups&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/product_groups`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the item
`data[attributes][sku]` | **String**<br>Stock keeping unit
`data[attributes][lead_time]` | **Integer**<br>The amount of seconds the item should be unavailable before a reservation
`data[attributes][lag_time]` | **Integer**<br>The amount of seconds the item should be unavailable after a reservation
`data[attributes][product_type]` | **String**<br>One of `rental`, `consumable`, `service`
`data[attributes][tracking_type]` | **String**<br>Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`data[attributes][trackable]` | **Boolean**<br>Wheter stock items are tracked
`data[attributes][extra_information]` | **String**<br>Extra information about the item, shown on orders and documents
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][show_in_store]` | **Boolean**<br>Whether to show this item in the online
`data[attributes][sorting_weight]` | **Integer**<br>Defines sort order in the online store, the higher the weight - the higher it shows up in lists
`data[attributes][price_type]` | **String**<br>One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`data[attributes][price_period]` | **String**<br>One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`data[attributes][flat_fee_price_in_cents]` | **Integer**<br>Use this value when price type is `simple`
`data[attributes][structure_price_in_cents]` | **Integer**<br>Use this value when price type is `structure` or `private_structure`
`data[attributes][deposit_in_cents]` | **Integer**<br>The value to use for deposit calculations
`data[attributes][discountable]` | **Boolean**<br>Whether discounts should be applied to this item (note that price rules will still apply)
`data[attributes][taxable]` | **Boolean**<br>Whether item is taxable
`data[attributes][tag_list][]` | **Array**<br>List of tags
`data[attributes][tax_category_id]` | **Uuid**<br>The associated Tax category
`data[attributes][allow_shortage]` | **Boolean**<br>Whether shortages are allowed
`data[attributes][shortage_limit]` | **Integer**<br>The maximum allowed shortage for any date range
`data[attributes][variation_fields][]` | **Array**<br>Array of fields that distinguish variations (e.g. color or size)
`data[attributes][quantity]` | **Integer**<br>When creating a product group you can specify the quantity of items you have in stock. Note that for a trackable product group, stock items are generated automatically based on this quantity
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)


### Includes

This request accepts the following includes:

`tax_category`






## Updating a product group



> How to update a product group:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/product_groups/6688409f-fb75-4b97-8c6c-29aca650d19d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6688409f-fb75-4b97-8c6c-29aca650d19d",
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
    "id": "6688409f-fb75-4b97-8c6c-29aca650d19d",
    "type": "product_groups",
    "attributes": {
      "name": "iPad mini",
      "slug": "ipad-pro",
      "sku": "sku",
      "type": "ProductGroup",
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
      "allow_shortage": false,
      "shortage_limit": 0,
      "variation_fields": []
    },
    "relationships": {
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "products": {
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the item
`data[attributes][sku]` | **String**<br>Stock keeping unit
`data[attributes][lead_time]` | **Integer**<br>The amount of seconds the item should be unavailable before a reservation
`data[attributes][lag_time]` | **Integer**<br>The amount of seconds the item should be unavailable after a reservation
`data[attributes][product_type]` | **String**<br>One of `rental`, `consumable`, `service`
`data[attributes][tracking_type]` | **String**<br>Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`data[attributes][trackable]` | **Boolean**<br>Wheter stock items are tracked
`data[attributes][extra_information]` | **String**<br>Extra information about the item, shown on orders and documents
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][show_in_store]` | **Boolean**<br>Whether to show this item in the online
`data[attributes][sorting_weight]` | **Integer**<br>Defines sort order in the online store, the higher the weight - the higher it shows up in lists
`data[attributes][price_type]` | **String**<br>One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`data[attributes][price_period]` | **String**<br>One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`data[attributes][flat_fee_price_in_cents]` | **Integer**<br>Use this value when price type is `simple`
`data[attributes][structure_price_in_cents]` | **Integer**<br>Use this value when price type is `structure` or `private_structure`
`data[attributes][deposit_in_cents]` | **Integer**<br>The value to use for deposit calculations
`data[attributes][discountable]` | **Boolean**<br>Whether discounts should be applied to this item (note that price rules will still apply)
`data[attributes][taxable]` | **Boolean**<br>Whether item is taxable
`data[attributes][tag_list][]` | **Array**<br>List of tags
`data[attributes][tax_category_id]` | **Uuid**<br>The associated Tax category
`data[attributes][allow_shortage]` | **Boolean**<br>Whether shortages are allowed
`data[attributes][shortage_limit]` | **Integer**<br>The maximum allowed shortage for any date range
`data[attributes][variation_fields][]` | **Array**<br>Array of fields that distinguish variations (e.g. color or size)
`data[attributes][quantity]` | **Integer**<br>When creating a product group you can specify the quantity of items you have in stock. Note that for a trackable product group, stock items are generated automatically based on this quantity
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)


### Includes

This request accepts the following includes:

`tax_category`






## Archiving a product group



> How to delete a product group:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/product_groups/1788b55b-e168-4e35-afc0-f413155201b1' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[product_groups]=id,created_at,updated_at`


### Includes

This request does not accept any includes