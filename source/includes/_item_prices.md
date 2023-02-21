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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=c8577fde-917f-4d19-a2e8-941fb8892759&filter%5Bitem_id%5D%5B%5D=4b3a1a0f-33ec-4a1e-8090-bf061a18c4f2&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-87598a94-e0e8-5749-8726-b948cdf3b10b",
      "type": "item_prices",
      "attributes": {
        "item_id": "c8577fde-917f-4d19-a2e8-941fb8892759",
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
            "related": "api/boomerang/items/c8577fde-917f-4d19-a2e8-941fb8892759"
          },
          "data": {
            "type": "products",
            "id": "c8577fde-917f-4d19-a2e8-941fb8892759"
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
      "id": "virtual-9e5273fb-24ca-5b9a-9542-9fd5ac4f85e0",
      "type": "item_prices",
      "attributes": {
        "item_id": "4b3a1a0f-33ec-4a1e-8090-bf061a18c4f2",
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
            "related": "api/boomerang/items/4b3a1a0f-33ec-4a1e-8090-bf061a18c4f2"
          },
          "data": {
            "type": "products",
            "id": "4b3a1a0f-33ec-4a1e-8090-bf061a18c4f2"
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
      "id": "c8577fde-917f-4d19-a2e8-941fb8892759",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-21T10:49:13+00:00",
        "updated_at": "2023-02-21T10:49:13+00:00",
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
        "product_group_id": "811cebb6-fded-4d43-8858-70bfbf36fc0e"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=c8577fde-917f-4d19-a2e8-941fb8892759"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=811cebb6-fded-4d43-8858-70bfbf36fc0e&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/811cebb6-fded-4d43-8858-70bfbf36fc0e"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c8577fde-917f-4d19-a2e8-941fb8892759&filter[owner_type]=products"
          }
        }
      }
    },
    {
      "id": "4b3a1a0f-33ec-4a1e-8090-bf061a18c4f2",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-21T10:49:13+00:00",
        "updated_at": "2023-02-21T10:49:13+00:00",
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
        "product_group_id": "a0b47d4d-378b-4785-b199-5da602b3535a"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=4b3a1a0f-33ec-4a1e-8090-bf061a18c4f2"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=a0b47d4d-378b-4785-b199-5da602b3535a&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/a0b47d4d-378b-4785-b199-5da602b3535a"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4b3a1a0f-33ec-4a1e-8090-bf061a18c4f2&filter[owner_type]=products"
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=2620a6ac-0a1e-45fe-964b-23a2e3273d54&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8cda3f5c-6d37-5e53-a305-aec407e0b7bc",
      "type": "item_prices",
      "attributes": {
        "item_id": "2620a6ac-0a1e-45fe-964b-23a2e3273d54",
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
            "related": "api/boomerang/items/2620a6ac-0a1e-45fe-964b-23a2e3273d54"
          },
          "data": {
            "type": "products",
            "id": "2620a6ac-0a1e-45fe-964b-23a2e3273d54"
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
      "id": "2620a6ac-0a1e-45fe-964b-23a2e3273d54",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-21T10:49:13+00:00",
        "updated_at": "2023-02-21T10:49:13+00:00",
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
        "product_group_id": "7adbae5f-cf40-448f-8c97-6bb7c61acd3b"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=2620a6ac-0a1e-45fe-964b-23a2e3273d54"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=7adbae5f-cf40-448f-8c97-6bb7c61acd3b&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/7adbae5f-cf40-448f-8c97-6bb7c61acd3b"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2620a6ac-0a1e-45fe-964b-23a2e3273d54&filter[owner_type]=products"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T10:47:38Z`
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





