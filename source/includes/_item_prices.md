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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=135d82a1-3b26-4822-ae7e-a9fb331e2eed&filter%5Bitem_id%5D%5B%5D=e1e89e8d-9d4f-404d-8978-3469e53af0c5&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0653715f-e7bd-418b-83c8-9b67ed815d0f",
      "type": "item_prices",
      "attributes": {
        "item_id": "135d82a1-3b26-4822-ae7e-a9fb331e2eed",
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
            "id": "135d82a1-3b26-4822-ae7e-a9fb331e2eed"
          }
        }
      }
    },
    {
      "id": "5e8409c0-b5f6-44ea-baa6-98e14e426fb2",
      "type": "item_prices",
      "attributes": {
        "item_id": "e1e89e8d-9d4f-404d-8978-3469e53af0c5",
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
            "id": "e1e89e8d-9d4f-404d-8978-3469e53af0c5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "135d82a1-3b26-4822-ae7e-a9fb331e2eed",
      "type": "products",
      "attributes": {
        "created_at": "2024-09-16T09:26:22.788160+00:00",
        "updated_at": "2024-09-16T09:26:22.788160+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000048",
        "group_name": "Product 1000048",
        "slug": "product-1000048",
        "sku": "PRODUCT 1000048",
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
        "product_group_id": "081f96ea-23b1-4d71-b1e7-b7dae4ac013b"
      },
      "relationships": {}
    },
    {
      "id": "e1e89e8d-9d4f-404d-8978-3469e53af0c5",
      "type": "products",
      "attributes": {
        "created_at": "2024-09-16T09:26:23.032030+00:00",
        "updated_at": "2024-09-16T09:26:23.032030+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000049",
        "group_name": "Product 1000049",
        "slug": "product-1000049",
        "sku": "PRODUCT 1000049",
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
        "product_group_id": "09e5365b-a9b0-40ac-b5a4-c25ee4368863"
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=2eddc912-732e-4427-ad86-de0725a04112&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dc0564e6-2b5a-422c-b294-ebd32f735627",
      "type": "item_prices",
      "attributes": {
        "item_id": "2eddc912-732e-4427-ad86-de0725a04112",
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
            "id": "2eddc912-732e-4427-ad86-de0725a04112"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2eddc912-732e-4427-ad86-de0725a04112",
      "type": "products",
      "attributes": {
        "created_at": "2024-09-16T09:26:23.695903+00:00",
        "updated_at": "2024-09-16T09:26:23.695903+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000050",
        "group_name": "Product 1000050",
        "slug": "product-1000050",
        "sku": "PRODUCT 1000050",
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
        "product_group_id": "424a34b5-2544-41bd-8749-41dd81bbbc8d"
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





