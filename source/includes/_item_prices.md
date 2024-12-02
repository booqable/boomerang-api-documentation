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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=0242a431-5419-4e04-9af8-636133df5191&filter%5Bitem_id%5D%5B%5D=14af8ee1-56af-48d0-9c03-0ad3a907a046&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "61da1c1f-f442-4624-8feb-3f46e4944034",
      "type": "item_prices",
      "attributes": {
        "item_id": "0242a431-5419-4e04-9af8-636133df5191",
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
            "id": "0242a431-5419-4e04-9af8-636133df5191"
          }
        }
      }
    },
    {
      "id": "2398b61b-2f2e-4f72-92a0-6c6927b3da50",
      "type": "item_prices",
      "attributes": {
        "item_id": "14af8ee1-56af-48d0-9c03-0ad3a907a046",
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
            "id": "14af8ee1-56af-48d0-9c03-0ad3a907a046"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0242a431-5419-4e04-9af8-636133df5191",
      "type": "products",
      "attributes": {
        "created_at": "2024-12-02T09:26:50.654430+00:00",
        "updated_at": "2024-12-02T09:26:50.654430+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000076",
        "group_name": "Product 1000076",
        "slug": "product-1000076",
        "sku": "PRODUCT 1000078",
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
        "product_group_id": "ee974e06-af07-420d-b9a0-8c6310972f09"
      },
      "relationships": {}
    },
    {
      "id": "14af8ee1-56af-48d0-9c03-0ad3a907a046",
      "type": "products",
      "attributes": {
        "created_at": "2024-12-02T09:26:50.921936+00:00",
        "updated_at": "2024-12-02T09:26:50.921936+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000077",
        "group_name": "Product 1000077",
        "slug": "product-1000077",
        "sku": "PRODUCT 1000079",
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
        "product_group_id": "25b0a610-4bbd-45d7-9f97-f59552c700e4"
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=5e4d002b-dd8f-4a55-97ac-ad721134d40e&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "edde7a9f-94a9-4f15-9109-ae9daa036b65",
      "type": "item_prices",
      "attributes": {
        "item_id": "5e4d002b-dd8f-4a55-97ac-ad721134d40e",
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
            "id": "5e4d002b-dd8f-4a55-97ac-ad721134d40e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5e4d002b-dd8f-4a55-97ac-ad721134d40e",
      "type": "products",
      "attributes": {
        "created_at": "2024-12-02T09:26:51.653956+00:00",
        "updated_at": "2024-12-02T09:26:51.653956+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000078",
        "group_name": "Product 1000078",
        "slug": "product-1000078",
        "sku": "PRODUCT 1000080",
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
        "product_group_id": "14df4d50-2637-4a7e-86b1-8329241a3cf6"
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





