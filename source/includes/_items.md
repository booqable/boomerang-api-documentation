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
      "id": "fbfa1c1d-0efa-424a-878b-9ef71f2da063",
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=fbfa1c1d-0efa-424a-878b-9ef71f2da063"
          }
        }
      }
    },
    {
      "id": "43624d63-e006-4749-9ab1-e01d813a4e8b",
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
        "tax_category_id": "ff7858aa-dbb6-4218-9b16-b853da422c4d",
        "allow_shortage": true,
        "shortage_limit": 3,
        "variation_fields": []
      },
      "relationships": {
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/ff7858aa-dbb6-4218-9b16-b853da422c4d"
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[item_group_id]=43624d63-e006-4749-9ab1-e01d813a4e8b"
          }
        }
      }
    },
    {
      "id": "2a94c5da-e4fc-4306-abbc-eccb17cc1ac6",
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
        "tax_category_id": "ff7858aa-dbb6-4218-9b16-b853da422c4d",
        "variation_values": [],
        "allow_shortage": true,
        "shortage_limit": 3,
        "product_group_id": "43624d63-e006-4749-9ab1-e01d813a4e8b"
      },
      "relationships": {
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/ff7858aa-dbb6-4218-9b16-b853da422c4d"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/43624d63-e006-4749-9ab1-e01d813a4e8b"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2a94c5da-e4fc-4306-abbc-eccb17cc1ac6"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-20T13:38:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/items/4453c4fd-6151-4fe7-bba6-0e27d4c6cc24' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4453c4fd-6151-4fe7-bba6-0e27d4c6cc24",
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
      "tax_category_id": "e4509232-7852-49ba-b219-d8c2bfc43add",
      "variation_values": [],
      "allow_shortage": true,
      "shortage_limit": 3,
      "product_group_id": "f8d44f68-3774-4f49-adda-d90809ee0422"
    },
    "relationships": {
      "tax_category": {
        "links": {
          "related": "api/boomerang/tax_categories/e4509232-7852-49ba-b219-d8c2bfc43add"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/f8d44f68-3774-4f49-adda-d90809ee0422"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=4453c4fd-6151-4fe7-bba6-0e27d4c6cc24"
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





