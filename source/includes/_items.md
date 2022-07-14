# Items

The Item resource gives the ability to fetch the following resources:

- Product groups
- Products
- Bundles

The description of the behavior for these resources can be found in their respective sections

## Endpoints
`GET /api/boomerang/items`

`POST api/boomerang/items/search`

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
      "id": "d1277aad-331f-406f-b1a3-a63312a58c7f",
      "type": "bundles",
      "attributes": {
        "created_at": "2022-07-14T13:04:27+00:00",
        "updated_at": "2022-07-14T13:04:27+00:00",
        "archived": false,
        "archived_at": null,
        "type": "bundles",
        "name": "iPad Bundle",
        "slug": "ipad-bundle",
        "product_type": "bundle",
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "discountable": true,
        "taxable": true,
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=d1277aad-331f-406f-b1a3-a63312a58c7f"
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=d1277aad-331f-406f-b1a3-a63312a58c7f"
          }
        },
        "categories": {
          "links": {
            "related": "api/boomerang/categories?filter[item_id]=d1277aad-331f-406f-b1a3-a63312a58c7f"
          }
        }
      }
    },
    {
      "id": "3c9aae1a-d65d-448a-864b-4934160d37ce",
      "type": "product_groups",
      "attributes": {
        "created_at": "2022-07-14T13:04:27+00:00",
        "updated_at": "2022-07-14T13:04:27+00:00",
        "archived": false,
        "archived_at": null,
        "type": "product_groups",
        "name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
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
        "tax_category_id": "7c1ec0e0-069f-4d9d-8990-97d688fd0c0a"
      },
      "relationships": {
        "categories": {
          "links": {
            "related": "api/boomerang/categories?filter[item_id]=3c9aae1a-d65d-448a-864b-4934160d37ce"
          }
        },
        "photo": {
          "links": {
            "related": null
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[product_group_id]=3c9aae1a-d65d-448a-864b-4934160d37ce"
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/7c1ec0e0-069f-4d9d-8990-97d688fd0c0a"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=3c9aae1a-d65d-448a-864b-4934160d37ce&filter[owner_type]=product_groups"
          }
        }
      }
    },
    {
      "id": "53e9feb9-e7ac-459e-b7fc-55c347cabebf",
      "type": "products",
      "attributes": {
        "created_at": "2022-07-14T13:04:27+00:00",
        "updated_at": "2022-07-14T13:04:27+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
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
        "product_group_id": "3c9aae1a-d65d-448a-864b-4934160d37ce",
        "tax_category_id": "7c1ec0e0-069f-4d9d-8990-97d688fd0c0a",
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
            "related": "api/boomerang/product_groups/3c9aae1a-d65d-448a-864b-4934160d37ce"
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/7c1ec0e0-069f-4d9d-8990-97d688fd0c0a"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=53e9feb9-e7ac-459e-b7fc-55c347cabebf&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=53e9feb9-e7ac-459e-b7fc-55c347cabebf"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=3c9aae1a-d65d-448a-864b-4934160d37ce&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=3c9aae1a-d65d-448a-864b-4934160d37ce"
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category,price_structure`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T13:03:03Z`
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
`tag_list` | **String**<br>`eq`
`category_id` | **Uuid**<br>`eq`
`tax_category_id` | **Uuid**<br>`eq`, `not_eq`
`price_structure_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`
`product_group_id` | **Uuid**<br>`eq`
`conditions` | **Hash**<br>`eq`


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

`inventory_levels`


`photo`






## Searching items

Use advanced search to make logical filter groups with and/or operators.


> How to search for items:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/items/search' \
    --header 'content-type: application/json' \
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
      "id": "8e1008f3-095e-48ad-bbcd-a732e430809c"
    },
    {
      "id": "42ce478d-229c-4f50-a41b-924de1147314"
    },
    {
      "id": "61a15e90-a932-4b5f-a83e-99b45d6fbf2f"
    },
    {
      "id": "3f4a4b33-c274-4e81-bbe4-2386095e607f"
    },
    {
      "id": "0507046a-d9e8-4f88-8258-cc3b81d4172c"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/items/search`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category,price_structure`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T13:03:03Z`
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
`tag_list` | **String**<br>`eq`
`category_id` | **Uuid**<br>`eq`
`tax_category_id` | **Uuid**<br>`eq`, `not_eq`
`price_structure_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`
`product_group_id` | **Uuid**<br>`eq`
`conditions` | **Hash**<br>`eq`


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

`inventory_levels`


`photo`





