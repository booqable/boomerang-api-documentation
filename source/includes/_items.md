# Items

The Item resource gives the ability to fetch the following resources:

- Product groups
- Products
- Bundles

The description of the behavior for these resources can be found in their respective sections

## Endpoints
`GET /api/boomerang/items`

`GET /api/boomerang/items/{id}`

## Fields
Every item has the following fields:

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
`base_price_in_cents` | **Integer**<br>The base price in cents
`price_type` | **String**<br>
`price_period` | **String**<br>One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`flat_fee_price_in_cents` | **Integer**<br>Use this value when price type is `simple`
`structure_price_in_cents` | **Integer**<br>Use this value when price type is `structure` or `private_structure`
`deposit_in_cents` | **Integer**<br>The value to use for deposit calculations
`discountable` | **Boolean**<br>Whether discounts should be applied to this item (note that price rules will still apply)
`taxable` | **Boolean**<br>Whether item is taxable
`tag_list` | **Array**<br>List of tags
`properties` | **Hash** `readonly`<br>
`tax_category_id` | **Uuid**<br>The associated Tax category


## Relationships
Items have the following relationships:

Name | Description
- | -
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category


## Listing items

> How to fetch a list of items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "67c763bd-0128-44c3-bd93-d501ddcd8f73",
      "type": "bundles",
      "attributes": {
        "created_at": "2021-10-08T11:22:50+00:00",
        "updated_at": "2021-10-08T11:22:50+00:00",
        "name": "iPad Bundle",
        "slug": "ipad-bundle",
        "product_type": "bundle",
        "archived": false,
        "archived_at": null,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "discountable": true,
        "taxable": true,
        "type": "Bundle",
        "tag_list": [
          "tablets",
          "apple"
        ]
      },
      "relationships": {
        "bundle_items": {
          "links": {
            "related": "api/boomerang/bundle_items?filter[bundle_id]=67c763bd-0128-44c3-bd93-d501ddcd8f73"
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[bundle_id]=67c763bd-0128-44c3-bd93-d501ddcd8f73"
          }
        }
      }
    },
    {
      "id": "ad500002-52fc-4098-af62-17ae2f020c9e",
      "type": "product_groups",
      "attributes": {
        "created_at": "2021-10-08T11:22:51+00:00",
        "updated_at": "2021-10-08T11:22:51+00:00",
        "name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": "sku",
        "type": "ProductGroup",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
        "archived": false,
        "archived_at": null,
        "extra_information": "Charging cable and case included",
        "photo_url": null,
        "description": "The Apple iPad Pro (2021) 12.9 inches 128GB Space Gray is one of the most powerful and fastest tablets of this moment thanks to the new M1 chip. This chip ensures that demanding apps from Adobe or 3D games run smoothly",
        "show_in_store": true,
        "sorting_weight": 0,
        "base_price_in_cents": 1995,
        "price_type": "simple",
        "price_period": "day",
        "flat_fee_price_in_cents": 1995,
        "structure_price_in_cents": 0,
        "deposit_in_cents": 10000,
        "discountable": true,
        "taxable": true,
        "tag_list": [
          "tablets",
          "apple"
        ],
        "properties": {},
        "tax_category_id": "61e0c241-2f48-43d0-9381-3b0779c4b03e",
        "allow_shortage": true,
        "shortage_limit": 3,
        "variation_fields": []
      },
      "relationships": {
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/61e0c241-2f48-43d0-9381-3b0779c4b03e"
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[item_group_id]=ad500002-52fc-4098-af62-17ae2f020c9e"
          }
        }
      }
    },
    {
      "id": "75556e0d-e7b5-4a06-8d9e-411abf87c4a4",
      "type": "products",
      "attributes": {
        "created_at": "2021-10-08T11:22:51+00:00",
        "updated_at": "2021-10-08T11:22:51+00:00",
        "name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": "sku",
        "type": "Product",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
        "archived": false,
        "archived_at": null,
        "extra_information": "Charging cable and case included",
        "photo_url": null,
        "description": "The Apple iPad Pro (2021) 12.9 inches 128GB Space Gray is one of the most powerful and fastest tablets of this moment thanks to the new M1 chip. This chip ensures that demanding apps from Adobe or 3D games run smoothly",
        "show_in_store": true,
        "sorting_weight": 0,
        "base_price_in_cents": 1995,
        "price_type": "simple",
        "price_period": "day",
        "flat_fee_price_in_cents": 0,
        "structure_price_in_cents": 0,
        "deposit_in_cents": 10000,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "tax_category_id": "61e0c241-2f48-43d0-9381-3b0779c4b03e",
        "variation_values": [],
        "allow_shortage": true,
        "shortage_limit": 3,
        "product_group_id": "ad500002-52fc-4098-af62-17ae2f020c9e"
      },
      "relationships": {
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/61e0c241-2f48-43d0-9381-3b0779c4b03e"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/ad500002-52fc-4098-af62-17ae2f020c9e"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=75556e0d-e7b5-4a06-8d9e-411abf87c4a4"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/items`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-08T11:22:48Z`
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
`type` | **String**<br>`eq`, `not_eq`, `prefix`, `match`
`lead_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`trackable` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`extra_information` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`photo_url` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **String**<br>`eq`, `not_eq`, `prefix`, `match`


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

This request accepts the following includes:

`barcode`






## Fetching an item

> How to fetch an item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/items/3e0c9d66-3666-46c5-986b-3294c2a5b1fb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3e0c9d66-3666-46c5-986b-3294c2a5b1fb",
    "type": "products",
    "attributes": {
      "created_at": "2021-10-08T11:22:53+00:00",
      "updated_at": "2021-10-08T11:22:53+00:00",
      "name": "iPad Pro",
      "slug": "ipad-pro",
      "sku": "sku",
      "type": "Product",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "trackable",
      "trackable": true,
      "archived": false,
      "archived_at": null,
      "extra_information": "Charging cable and case included",
      "photo_url": null,
      "description": "The Apple iPad Pro (2021) 12.9 inches 128GB Space Gray is one of the most powerful and fastest tablets of this moment thanks to the new M1 chip. This chip ensures that demanding apps from Adobe or 3D games run smoothly",
      "show_in_store": true,
      "sorting_weight": 0,
      "base_price_in_cents": 1995,
      "price_type": "simple",
      "price_period": "day",
      "flat_fee_price_in_cents": 0,
      "structure_price_in_cents": 0,
      "deposit_in_cents": 10000,
      "discountable": true,
      "taxable": true,
      "tag_list": [],
      "properties": {},
      "tax_category_id": "4ab1198a-a9f3-4be6-8f62-1e05d7615c7d",
      "variation_values": [],
      "allow_shortage": true,
      "shortage_limit": 3,
      "product_group_id": "b571dc35-f4d6-45b4-9440-377640c7ee2d"
    },
    "relationships": {
      "tax_category": {
        "links": {
          "related": "api/boomerang/tax_categories/4ab1198a-a9f3-4be6-8f62-1e05d7615c7d"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/b571dc35-f4d6-45b4-9440-377640c7ee2d"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=3e0c9d66-3666-46c5-986b-3294c2a5b1fb"
        }
      }
    }
  },
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/items/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[items]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`tax_category`


`properties`


`barcode`





