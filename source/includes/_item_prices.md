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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=e5c3dc21-7b0d-4ed6-b0ed-361574720226&filter%5Bitem_id%5D%5B%5D=9f918375-8e19-486f-9318-4bb487d11b85&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0be8807a-a3fb-55de-a233-5a1c3e94fa13",
      "type": "item_prices",
      "attributes": {
        "item_id": "e5c3dc21-7b0d-4ed6-b0ed-361574720226",
        "from": "2030-01-01T12:00:00+00:00",
        "till": "2030-01-14T12:00:00+00:00",
        "charge_length": null,
        "charge_label": "13 days",
        "original_price_each_in_cents": 31200,
        "price_each_in_cents": 31200,
        "price_rule_values": null,
        "price_structure_id": null,
        "price_ruleset_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/e5c3dc21-7b0d-4ed6-b0ed-361574720226"
          },
          "data": {
            "type": "products",
            "id": "e5c3dc21-7b0d-4ed6-b0ed-361574720226"
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
      "id": "virtual-74aaa588-2907-5018-bcae-4e54dd51b99d",
      "type": "item_prices",
      "attributes": {
        "item_id": "9f918375-8e19-486f-9318-4bb487d11b85",
        "from": "2030-01-01T12:00:00+00:00",
        "till": "2030-01-14T12:00:00+00:00",
        "charge_length": null,
        "charge_label": "13 days",
        "original_price_each_in_cents": 74100,
        "price_each_in_cents": 74100,
        "price_rule_values": null,
        "price_structure_id": null,
        "price_ruleset_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/9f918375-8e19-486f-9318-4bb487d11b85"
          },
          "data": {
            "type": "products",
            "id": "9f918375-8e19-486f-9318-4bb487d11b85"
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
      "id": "e5c3dc21-7b0d-4ed6-b0ed-361574720226",
      "type": "products",
      "attributes": {
        "created_at": "2022-10-07T11:56:57+00:00",
        "updated_at": "2022-10-07T11:56:57+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 4",
        "slug": "product-4",
        "sku": "PRODUCT 6",
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
        "base_price_in_cents": 100,
        "price_type": "simple",
        "price_period": "hour",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "variation_values": [],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "83be9762-90be-4535-9284-7206be2703dc",
        "tax_category_id": null,
        "price_structure_id": null,
        "price_ruleset_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/83be9762-90be-4535-9284-7206be2703dc"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e5c3dc21-7b0d-4ed6-b0ed-361574720226&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=e5c3dc21-7b0d-4ed6-b0ed-361574720226"
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=83be9762-90be-4535-9284-7206be2703dc&filter[owner_type]=products"
          }
        }
      }
    },
    {
      "id": "9f918375-8e19-486f-9318-4bb487d11b85",
      "type": "products",
      "attributes": {
        "created_at": "2022-10-07T11:56:57+00:00",
        "updated_at": "2022-10-07T11:56:57+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 5",
        "slug": "product-5",
        "sku": "PRODUCT 7",
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
        "base_price_in_cents": 5700,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "variation_values": [],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "ed20affc-dd0e-47d3-a8d0-5d444b1a9d69",
        "tax_category_id": null,
        "price_structure_id": null,
        "price_ruleset_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/ed20affc-dd0e-47d3-a8d0-5d444b1a9d69"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9f918375-8e19-486f-9318-4bb487d11b85&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=9f918375-8e19-486f-9318-4bb487d11b85"
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=ed20affc-dd0e-47d3-a8d0-5d444b1a9d69&filter[owner_type]=products"
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=7c496c48-1e9f-4742-b78c-9a2160778302&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0f59a7fd-9cba-5926-b499-2c86ce9379ce",
      "type": "item_prices",
      "attributes": {
        "item_id": "7c496c48-1e9f-4742-b78c-9a2160778302",
        "from": null,
        "till": null,
        "charge_length": 36000,
        "charge_label": "10 hours",
        "original_price_each_in_cents": null,
        "price_each_in_cents": 1000,
        "price_rule_values": null,
        "price_structure_id": null,
        "price_ruleset_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/7c496c48-1e9f-4742-b78c-9a2160778302"
          },
          "data": {
            "type": "products",
            "id": "7c496c48-1e9f-4742-b78c-9a2160778302"
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
      "id": "7c496c48-1e9f-4742-b78c-9a2160778302",
      "type": "products",
      "attributes": {
        "created_at": "2022-10-07T11:56:58+00:00",
        "updated_at": "2022-10-07T11:56:58+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 6",
        "slug": "product-6",
        "sku": "PRODUCT 8",
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
        "base_price_in_cents": 100,
        "price_type": "simple",
        "price_period": "hour",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "variation_values": [],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "73eddb7b-90da-416a-a72c-f5337b95c6a7",
        "tax_category_id": null,
        "price_structure_id": null,
        "price_ruleset_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/73eddb7b-90da-416a-a72c-f5337b95c6a7"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7c496c48-1e9f-4742-b78c-9a2160778302&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=7c496c48-1e9f-4742-b78c-9a2160778302"
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=73eddb7b-90da-416a-a72c-f5337b95c6a7&filter[owner_type]=products"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T11:55:30Z`
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





