# Item prices

Allows you to calculate pricing for an item based on parameters.

You can calculate a price in a couple ways:

- Providing a `from` and `till`, charge label and length will be derived from the dates provided
- Providing a `charge_length`

## Fields
Every item price has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`item_id` | **Uuid** <br>Required, the item or items to calculate price for
`from` | **Datetime** <br>Start of charge period
`till` | **Datetime** <br>End of charge period
`original_charge_length` | **Integer** `readonly`<br>Length of charge period before charge rules are applied
`charge_length` | **Integer** <br>Length of charge period in seconds
`original_charge_label` | **String** `readonly`<br>Label of charge period before charge rules are applied
`charge_label` | **String** `readonly`<br>Label for the charge period
`original_price_each_in_cents` | **Integer** `readonly`<br>Price per item before charge rules are applied
`price_each_in_cents` | **Integer** `readonly`<br>Final price per item
`price_rule_values` | **Hash** `readonly`<br>What price rules were applied
`price_structure_id` | **Uuid** <br>Optional price structure to use, if the item has a price structure associated with it that will be used by default
`price_ruleset_id` | **Uuid** <br>Associated Price ruleset
`price_tile_id` | **Uuid** `readonly`<br>Associated Price tile


## Relationships
Item prices have the following relationships:

Name | Description
-- | --
`item` | **[Item](#items)** <br>Associated Item
`price_ruleset` | **[Price ruleset](#price-rulesets)** <br>Associated Price ruleset
`price_structure` | **[Price structure](#price-structures)** <br>Associated Price structure
`price_tile` | **[Price tile](#price-tiles)** <br>Associated Price tile


## Calcuating the price of products and/or bundles



> Calculating price for a period:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=e6310064-e250-45a8-a41e-9a549007a5db&filter%5Bitem_id%5D%5B%5D=f435999e-3989-4127-90e6-c6aa40247c28&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c067e8dc-b6d9-4ebb-9b37-7b815dd3f9bd",
      "type": "item_prices",
      "attributes": {
        "item_id": "e6310064-e250-45a8-a41e-9a549007a5db",
        "from": "2030-01-01T12:00:00.000000+00:00",
        "till": "2030-01-14T12:00:00.000000+00:00",
        "original_charge_length": 1123200,
        "charge_length": 1123200,
        "original_charge_label": "13 days",
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
          "data": {
            "type": "products",
            "id": "e6310064-e250-45a8-a41e-9a549007a5db"
          }
        }
      }
    },
    {
      "id": "5f397024-813f-443e-b7d8-7c25dc1aa015",
      "type": "item_prices",
      "attributes": {
        "item_id": "f435999e-3989-4127-90e6-c6aa40247c28",
        "from": "2030-01-01T12:00:00.000000+00:00",
        "till": "2030-01-14T12:00:00.000000+00:00",
        "original_charge_length": 1123200,
        "charge_length": 1123200,
        "original_charge_label": "13 days",
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
          "data": {
            "type": "products",
            "id": "f435999e-3989-4127-90e6-c6aa40247c28"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e6310064-e250-45a8-a41e-9a549007a5db",
      "type": "products",
      "attributes": {
        "created_at": "2024-12-02T13:02:22.259322+00:00",
        "updated_at": "2024-12-02T13:02:22.259322+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000006",
        "group_name": "Product 1000006",
        "slug": "product-1000006",
        "sku": "PRODUCT 1000006",
        "lead_time": 0,
        "lag_time": 0,
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
        "sorting_weight": 1,
        "base_price_in_cents": 100,
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
        "product_group_id": "b78ce7a5-06ea-4d13-96e8-3275025601fa"
      },
      "relationships": {}
    },
    {
      "id": "f435999e-3989-4127-90e6-c6aa40247c28",
      "type": "products",
      "attributes": {
        "created_at": "2024-12-02T13:02:22.612453+00:00",
        "updated_at": "2024-12-02T13:02:22.612453+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000007",
        "group_name": "Product 1000007",
        "slug": "product-1000007",
        "sku": "PRODUCT 1000007",
        "lead_time": 0,
        "lag_time": 0,
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
        "sorting_weight": 1,
        "base_price_in_cents": 5700,
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
        "product_group_id": "78348f4a-2aa3-4dbd-aa13-e589abc30c87"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> Calculating price charge length:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=153255be-d511-4b28-99d6-a64ab30eb116&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1cf03336-8b7c-4d7f-9e7a-93c8b8eab498",
      "type": "item_prices",
      "attributes": {
        "item_id": "153255be-d511-4b28-99d6-a64ab30eb116",
        "from": null,
        "till": null,
        "original_charge_length": 36000,
        "charge_length": 36000,
        "original_charge_label": "10 hours",
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
          "data": {
            "type": "products",
            "id": "153255be-d511-4b28-99d6-a64ab30eb116"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "153255be-d511-4b28-99d6-a64ab30eb116",
      "type": "products",
      "attributes": {
        "created_at": "2024-12-02T13:02:21.201102+00:00",
        "updated_at": "2024-12-02T13:02:21.201102+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000004",
        "group_name": "Product 1000004",
        "slug": "product-1000004",
        "sku": "PRODUCT 1000004",
        "lead_time": 0,
        "lag_time": 0,
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
        "sorting_weight": 1,
        "base_price_in_cents": 100,
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
        "product_group_id": "9c6816d4-0daa-4d01-98cc-7b4fb5254ba9"
      },
      "relationships": {}
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_tile,price_structure,item`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[item_prices]=item_id,from,till`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`item_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`original_charge_length` | **Integer** <br>`eq`
`charge_length` | **Integer** <br>`eq`
`price_structure_id` | **Uuid** <br>`eq`
`price_ruleset_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`price_tile`


`price_structure`


`item`





