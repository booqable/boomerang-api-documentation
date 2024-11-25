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
`item` | **Items** `readonly`<br>Associated Item
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`price_tile` | **Price tiles** `readonly`<br>Associated Price tile


## Calcuating the price of products and/or bundles



> Calculating price for a period:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=7b65331b-0292-4031-b4f7-d7a60d4dba6c&filter%5Bitem_id%5D%5B%5D=70a7e969-4f6e-4ef0-b139-80232f05df2e&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "83e40fa6-8c74-4664-b069-0a0e61ddd32c",
      "type": "item_prices",
      "attributes": {
        "item_id": "7b65331b-0292-4031-b4f7-d7a60d4dba6c",
        "from": "2030-01-01T12:00:00.000000+00:00",
        "till": "2030-01-14T12:00:00.000000+00:00",
        "original_charge_length": 1123200,
        "charge_length": 1123200,
        "original_charge_label": "13 days",
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
          "data": {
            "type": "products",
            "id": "7b65331b-0292-4031-b4f7-d7a60d4dba6c"
          }
        }
      }
    },
    {
      "id": "f4dd88f9-9df8-4fc4-a965-884ecd2cfc85",
      "type": "item_prices",
      "attributes": {
        "item_id": "70a7e969-4f6e-4ef0-b139-80232f05df2e",
        "from": "2030-01-01T12:00:00.000000+00:00",
        "till": "2030-01-14T12:00:00.000000+00:00",
        "original_charge_length": 1123200,
        "charge_length": 1123200,
        "original_charge_label": "13 days",
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
          "data": {
            "type": "products",
            "id": "70a7e969-4f6e-4ef0-b139-80232f05df2e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7b65331b-0292-4031-b4f7-d7a60d4dba6c",
      "type": "products",
      "attributes": {
        "created_at": "2024-11-25T09:25:39.303934+00:00",
        "updated_at": "2024-11-25T09:25:39.303934+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000008",
        "group_name": "Product 1000008",
        "slug": "product-1000008",
        "sku": "PRODUCT 1000008",
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
        "product_group_id": "4e07fac5-170f-4afc-bc08-e0889f16f984"
      },
      "relationships": {}
    },
    {
      "id": "70a7e969-4f6e-4ef0-b139-80232f05df2e",
      "type": "products",
      "attributes": {
        "created_at": "2024-11-25T09:25:39.666597+00:00",
        "updated_at": "2024-11-25T09:25:39.666597+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000009",
        "group_name": "Product 1000009",
        "slug": "product-1000009",
        "sku": "PRODUCT 1000009",
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
        "product_group_id": "9735cf05-48d4-4c6b-9fc0-b70bece2d4eb"
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=5a5cae8b-3d8d-49a9-b553-b498a60f37fc&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "33bae5ce-eb6e-4bc4-8701-9fcb6bf189ea",
      "type": "item_prices",
      "attributes": {
        "item_id": "5a5cae8b-3d8d-49a9-b553-b498a60f37fc",
        "from": null,
        "till": null,
        "original_charge_length": 36000,
        "charge_length": 36000,
        "original_charge_label": "10 hours",
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
          "data": {
            "type": "products",
            "id": "5a5cae8b-3d8d-49a9-b553-b498a60f37fc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5a5cae8b-3d8d-49a9-b553-b498a60f37fc",
      "type": "products",
      "attributes": {
        "created_at": "2024-11-25T09:25:40.780978+00:00",
        "updated_at": "2024-11-25T09:25:40.780978+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000010",
        "group_name": "Product 1000010",
        "slug": "product-1000010",
        "sku": "PRODUCT 1000010",
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
        "product_group_id": "d61abf42-ad2d-42ef-91ba-7aca3c85f934"
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





