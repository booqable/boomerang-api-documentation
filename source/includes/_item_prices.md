# Item prices

Allows you to calculate pricing for an item based on parameters.

You can calculate a price in a couple ways:

- Providing a `from` and `till`, charge label and length will be derived from the dates provided
- Providing a `charge_length`

## Fields
Every item price has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`item_id` | **Uuid** <br>The associated Item
`from` | **Datetime** <br>Start of charge period
`till` | **Datetime** <br>End of charge period
`original_charge_length` | **Integer** `readonly`<br>Length of charge period before charge rules are applied
`charge_length` | **Integer** <br>Length of charge period in seconds
`original_charge_label` | **String** `readonly`<br>Label of charge period before charge rules are applied
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
-- | --
`item` | **Items** `readonly`<br>Associated Item
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`price_tile` | **Price tiles** `readonly`<br>Associated Price tile


## Calcuating the price of products and/or bundles



> Calculating price for a period:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=a1d0c3fb-2184-4d3b-8f85-94a4d8cb5a77&filter%5Bitem_id%5D%5B%5D=2f9d8e02-765b-4e40-bf7a-f45a64639ef6&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5f5f0631-6b2f-4411-9d9f-987115e34ab7",
      "type": "item_prices",
      "attributes": {
        "item_id": "a1d0c3fb-2184-4d3b-8f85-94a4d8cb5a77",
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
            "id": "a1d0c3fb-2184-4d3b-8f85-94a4d8cb5a77"
          }
        }
      }
    },
    {
      "id": "c614e7fd-e783-4be2-b552-8d8287c8e872",
      "type": "item_prices",
      "attributes": {
        "item_id": "2f9d8e02-765b-4e40-bf7a-f45a64639ef6",
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
            "id": "2f9d8e02-765b-4e40-bf7a-f45a64639ef6"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a1d0c3fb-2184-4d3b-8f85-94a4d8cb5a77",
      "type": "products",
      "attributes": {
        "created_at": "2024-10-14T09:27:13.621813+00:00",
        "updated_at": "2024-10-14T09:27:13.621813+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000072",
        "group_name": "Product 1000072",
        "slug": "product-1000072",
        "sku": "PRODUCT 1000074",
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
        "product_group_id": "856f7700-3603-43ee-a2ac-becf74a29591"
      },
      "relationships": {}
    },
    {
      "id": "2f9d8e02-765b-4e40-bf7a-f45a64639ef6",
      "type": "products",
      "attributes": {
        "created_at": "2024-10-14T09:27:13.850901+00:00",
        "updated_at": "2024-10-14T09:27:13.850901+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000073",
        "group_name": "Product 1000073",
        "slug": "product-1000073",
        "sku": "PRODUCT 1000075",
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
        "product_group_id": "cd17d496-f7a8-4d94-b8ca-bda3497da9fa"
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=602d2838-c5fe-4f34-b01f-94de98ad897a&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8037699b-5e1c-4525-b062-928f89e187d3",
      "type": "item_prices",
      "attributes": {
        "item_id": "602d2838-c5fe-4f34-b01f-94de98ad897a",
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
            "id": "602d2838-c5fe-4f34-b01f-94de98ad897a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "602d2838-c5fe-4f34-b01f-94de98ad897a",
      "type": "products",
      "attributes": {
        "created_at": "2024-10-14T09:27:12.785434+00:00",
        "updated_at": "2024-10-14T09:27:12.785434+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000070",
        "group_name": "Product 1000070",
        "slug": "product-1000070",
        "sku": "PRODUCT 1000072",
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
        "product_group_id": "a4cc1235-4463-4478-9318-11fb8e1cbde5"
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





