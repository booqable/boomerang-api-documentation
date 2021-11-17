# Items

The Item resource gives the ability to fetch the following resources:

- Product groups
- Products
- Bundles

The description of the behavior for these resources can be found in their respective sections

## Endpoints
`GET /api/boomerang/items`

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
      "id": "ef7ac084-e9ef-4207-9f98-186aa50e21fd",
      "type": "bundles",
      "attributes": {
        "created_at": "2021-11-17T09:30:20+00:00",
        "updated_at": "2021-11-17T09:30:20+00:00",
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
        ],
        "photo_id": null,
        "tax_category_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "bundle_items": {
          "links": {
            "related": "api/boomerang/bundle_items?filter[bundle_id]=ef7ac084-e9ef-4207-9f98-186aa50e21fd"
          }
        },
        "categories": {
          "links": {
            "related": "api/boomerang/categories?filter[item_id]=ef7ac084-e9ef-4207-9f98-186aa50e21fd"
          }
        }
      }
    },
    {
      "id": "3425534e-24fd-4407-97b6-e25b219caad2",
      "type": "product_groups",
      "attributes": {
        "created_at": "2021-11-17T09:30:20+00:00",
        "updated_at": "2021-11-17T09:30:20+00:00",
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
        "deposit_in_cents": 10000,
        "discountable": true,
        "taxable": true,
        "tag_list": [
          "tablets",
          "apple"
        ],
        "properties": {},
        "photo_id": null,
        "allow_shortage": true,
        "shortage_limit": 3,
        "variation_fields": [],
        "flat_fee_price_in_cents": 1995,
        "structure_price_in_cents": 0,
        "tax_category_id": "f14a70e9-c3c6-4ec3-a8e5-5d9453b72dab"
      },
      "relationships": {
        "categories": {
          "links": {
            "related": "api/boomerang/categories?filter[item_id]=3425534e-24fd-4407-97b6-e25b219caad2"
          }
        },
        "photo": {
          "links": {
            "related": null
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[item_group_id]=3425534e-24fd-4407-97b6-e25b219caad2"
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/f14a70e9-c3c6-4ec3-a8e5-5d9453b72dab"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=3425534e-24fd-4407-97b6-e25b219caad2&filter[owner_type]=ProductGroup"
          }
        }
      }
    },
    {
      "id": "b9e5aad9-abd1-4f75-913d-f44deeae03a2",
      "type": "products",
      "attributes": {
        "created_at": "2021-11-17T09:30:20+00:00",
        "updated_at": "2021-11-17T09:30:20+00:00",
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
        "sorting_weight": 1,
        "base_price_in_cents": 1995,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 10000,
        "discountable": true,
        "taxable": true,
        "tag_list": [
          "tablets",
          "apple"
        ],
        "properties": {},
        "photo_id": null,
        "variation_values": [],
        "allow_shortage": true,
        "shortage_limit": 3,
        "product_group_id": "3425534e-24fd-4407-97b6-e25b219caad2",
        "tax_category_id": "f14a70e9-c3c6-4ec3-a8e5-5d9453b72dab"
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/3425534e-24fd-4407-97b6-e25b219caad2"
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/f14a70e9-c3c6-4ec3-a8e5-5d9453b72dab"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b9e5aad9-abd1-4f75-913d-f44deeae03a2"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=3425534e-24fd-4407-97b6-e25b219caad2"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=3425534e-24fd-4407-97b6-e25b219caad2"
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-17T09:29:36Z`
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
`photo_id` | **Uuid**<br>`eq`, `not_eq`
`category_id` | **Uuid**<br>`eq`, `not_eq`
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
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`discountable` | **Array**<br>`count`
`taxable` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`tax_category_id` | **Array**<br>`count`
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes