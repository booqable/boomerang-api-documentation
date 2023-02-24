# Item prices

Allows you to calculate pricing for an item based on parameters.

You can calculate a price in a couple ways:

- Providing a `from` and `till`, charge label and length will be derived from the dates provided
- Providing a `charge_length`

## Fields
Every item price has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`item_id` | **Uuid** <br>The associated Item
`from` | **Datetime** <br>Start of charge period
`till` | **Datetime** <br>End of charge period
`charge_length` | **Integer** <br>Length of charge period in seconds
`charge_label` | **String** `readonly`<br>Label for the charge period
`original_price_each_in_cents` | **Integer** `readonly`<br>Price per item before charge rules are applied
`price_each_in_cents` | **Integer** `readonly`<br>Final price per item
`price_rule_values` | **Hash** `readonly`<br>What price rules were applied
`price_structure_id` | **Uuid** <br>The associated Price structure
`price_ruleset_id` | **Uuid** <br>The associated Price ruleset
`price_tile_id` | **Uuid** `readonly`<br>The associated Price tile


## Relationships
Item prices have the following relationships:

Name | Description
- | -
`item` | **Items** `readonly`<br>Associated Item
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset
`price_tile` | **Price tiles** `readonly`<br>Associated Price tile


## Calcuating the price of products and/or bundles



> Calculating price for a period:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=031915d0-aa5f-49dd-a8f6-21fe0f5210b9&filter%5Bitem_id%5D%5B%5D=1ea6a6de-6cdf-48e0-a150-1a138899b35a&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-12c92b5f-a909-5e8c-8795-430217a01b27",
      "type": "item_prices",
      "attributes": {
        "item_id": "031915d0-aa5f-49dd-a8f6-21fe0f5210b9",
        "from": "2030-01-01T12:00:00+00:00",
        "till": "2030-01-14T12:00:00+00:00",
        "charge_length": null,
        "charge_label": "13 days",
        "original_price_each_in_cents": 0,
        "price_each_in_cents": 0,
        "price_rule_values": null,
        "price_structure_id": null,
        "price_ruleset_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/031915d0-aa5f-49dd-a8f6-21fe0f5210b9"
          },
          "data": {
            "type": "products",
            "id": "031915d0-aa5f-49dd-a8f6-21fe0f5210b9"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "price_tile": {
          "links": {
            "related": null
          }
        }
      }
    },
    {
      "id": "virtual-8cccc7fb-f912-5d15-ae46-eb6461e06be6",
      "type": "item_prices",
      "attributes": {
        "item_id": "1ea6a6de-6cdf-48e0-a150-1a138899b35a",
        "from": "2030-01-01T12:00:00+00:00",
        "till": "2030-01-14T12:00:00+00:00",
        "charge_length": null,
        "charge_label": "13 days",
        "original_price_each_in_cents": 0,
        "price_each_in_cents": 0,
        "price_rule_values": null,
        "price_structure_id": null,
        "price_ruleset_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/1ea6a6de-6cdf-48e0-a150-1a138899b35a"
          },
          "data": {
            "type": "products",
            "id": "1ea6a6de-6cdf-48e0-a150-1a138899b35a"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "price_tile": {
          "links": {
            "related": null
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "031915d0-aa5f-49dd-a8f6-21fe0f5210b9",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-24T09:47:59+00:00",
        "updated_at": "2023-02-24T09:47:59+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 8",
        "slug": "product-8",
        "sku": "PRODUCT 10",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 1,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "hour",
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
        "variation_values": [],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "2f8b6ee4-2b71-472f-9f78-aa52f358aff9"
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
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=031915d0-aa5f-49dd-a8f6-21fe0f5210b9"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=2f8b6ee4-2b71-472f-9f78-aa52f358aff9&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/2f8b6ee4-2b71-472f-9f78-aa52f358aff9"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=031915d0-aa5f-49dd-a8f6-21fe0f5210b9&filter[owner_type]=products"
          }
        }
      }
    },
    {
      "id": "1ea6a6de-6cdf-48e0-a150-1a138899b35a",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-24T09:47:59+00:00",
        "updated_at": "2023-02-24T09:47:59+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 9",
        "slug": "product-9",
        "sku": "PRODUCT 11",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
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
        "variation_values": [],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "a23768f7-fb83-49d1-a61a-88886395e270"
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
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=1ea6a6de-6cdf-48e0-a150-1a138899b35a"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=a23768f7-fb83-49d1-a61a-88886395e270&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/a23768f7-fb83-49d1-a61a-88886395e270"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1ea6a6de-6cdf-48e0-a150-1a138899b35a&filter[owner_type]=products"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> Calculating price charge length:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=4cb66854-aa50-45ac-9ca2-21f05439f39f&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-12c92b5f-a909-5e8c-8795-430217a01b27",
      "type": "item_prices",
      "attributes": {
        "item_id": "4cb66854-aa50-45ac-9ca2-21f05439f39f",
        "from": null,
        "till": null,
        "charge_length": 36000,
        "charge_label": "10 hours",
        "original_price_each_in_cents": null,
        "price_each_in_cents": 0,
        "price_rule_values": null,
        "price_structure_id": null,
        "price_ruleset_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/4cb66854-aa50-45ac-9ca2-21f05439f39f"
          },
          "data": {
            "type": "products",
            "id": "4cb66854-aa50-45ac-9ca2-21f05439f39f"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "price_tile": {
          "links": {
            "related": null
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4cb66854-aa50-45ac-9ca2-21f05439f39f",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-24T09:48:00+00:00",
        "updated_at": "2023-02-24T09:48:00+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 10",
        "slug": "product-10",
        "sku": "PRODUCT 12",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": false,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 1,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "hour",
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
        "variation_values": [],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "ae0248b6-cced-49d3-ba6a-d38c99717eb7"
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
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=4cb66854-aa50-45ac-9ca2-21f05439f39f"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=ae0248b6-cced-49d3-ba6a-d38c99717eb7&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/ae0248b6-cced-49d3-ba6a-d38c99717eb7"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4cb66854-aa50-45ac-9ca2-21f05439f39f&filter[owner_type]=products"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/item_prices`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=item,price_structure,price_ruleset`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[item_prices]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:21Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`charge_length` | **Integer** <br>`eq`
`price_structure_id` | **Uuid** <br>`eq`
`price_ruleset_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`price_tile`


`price_structure`


`item`





