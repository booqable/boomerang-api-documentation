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
For this resource fields are described in the following resources:

- Product groups
- Products
- Bundles

## Relationships
For this resource relationships are described in the following resources:

- Product groups
- Products
- Bundles

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
      "id": "405a2e65-0c13-4050-a845-43a87218df59",
      "type": "bundles",
      "attributes": {
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=405a2e65-0c13-4050-a845-43a87218df59"
          }
        }
      }
    },
    {
      "id": "d5dc7a78-ab3b-4257-a5e9-6e39a8c1c35f",
      "type": "product_groups",
      "attributes": {
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
        "tax_category_id": "e3bd7988-0d28-4981-be48-c31b43f46581",
        "allow_shortage": true,
        "shortage_limit": 3,
        "variation_fields": []
      },
      "relationships": {
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/e3bd7988-0d28-4981-be48-c31b43f46581"
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[item_group_id]=d5dc7a78-ab3b-4257-a5e9-6e39a8c1c35f"
          }
        }
      }
    },
    {
      "id": "9dc60f16-7def-48e3-9725-5dc8167b6e1b",
      "type": "products",
      "attributes": {
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
        "tag_list": [
          "tablets",
          "apple"
        ],
        "properties": {},
        "tax_category_id": "e3bd7988-0d28-4981-be48-c31b43f46581",
        "variation_values": [],
        "allow_shortage": true,
        "shortage_limit": 3,
        "product_group_id": "d5dc7a78-ab3b-4257-a5e9-6e39a8c1c35f"
      },
      "relationships": {
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/e3bd7988-0d28-4981-be48-c31b43f46581"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/d5dc7a78-ab3b-4257-a5e9-6e39a8c1c35f"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9dc60f16-7def-48e3-9725-5dc8167b6e1b"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/search/items?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/search/items?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/search/items?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-21T11:39:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/items/48ffcaf3-f270-4b67-9f97-8521750c0747' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "48ffcaf3-f270-4b67-9f97-8521750c0747",
    "type": "products",
    "attributes": {
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
      "tag_list": [
        "tablets",
        "apple"
      ],
      "properties": {},
      "tax_category_id": "c69d6961-af73-4245-beef-99b5151539f4",
      "variation_values": [],
      "allow_shortage": true,
      "shortage_limit": 3,
      "product_group_id": "ec748f84-0d5c-4ccd-9510-6670d60e839c"
    },
    "relationships": {
      "tax_category": {
        "links": {
          "related": "api/boomerang/tax_categories/c69d6961-af73-4245-beef-99b5151539f4"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/ec748f84-0d5c-4ccd-9510-6670d60e839c"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=48ffcaf3-f270-4b67-9f97-8521750c0747"
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





