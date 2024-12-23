# Item prices

Allows you to calculate pricing for an item based on parameters.

You can calculate a price in a couple ways:

- Providing a `from` and `till`, charge label and length will be derived from the dates provided
- Providing a `charge_length`

## Relationships
Name | Description
-- | --
`item` | **[Item](#items)** `required`<br>Required, the item or items to calculate price for. 
`price_ruleset` | **[Price ruleset](#price-rulesets)** `required`<br>The advanced pricing rules the apply. 
`price_structure` | **[Price structure](#price-structures)** `required`<br>Optional price structure to use, if the item has a price structure associated with it that will be used by default. 
`price_tile` | **[Price tile](#price-tiles)** `required`<br>The price tile that was selected from the price strucure. 


Check matching attributes under [Fields](#item-prices-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`charge_label` | **string** `readonly`<br>Label for the charge period. 
`charge_length` | **integer** <br>Length of charge period in seconds. 
`from` | **datetime** <br>Start of charge period. 
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** <br>Required, the item or items to calculate price for. 
`original_charge_label` | **string** `readonly`<br>Label of charge period before charge rules are applied. 
`original_charge_length` | **integer** `readonly`<br>Length of charge period before charge rules are applied. 
`original_price_each_in_cents` | **integer** `readonly`<br>Price per item before charge rules are applied. 
`price_each_in_cents` | **integer** `readonly`<br>Final price per item. 
`price_rule_values` | **hash** `readonly`<br>What price rules were applied. 
`price_ruleset_id` | **uuid** <br>The advanced pricing rules the apply. 
`price_structure_id` | **uuid** <br>Optional price structure to use, if the item has a price structure associated with it that will be used by default. 
`price_tile_id` | **uuid** `readonly`<br>The price tile that was selected from the price strucure. 
`till` | **datetime** <br>End of charge period. 


## Calcuating the price of products and/or bundles


> Calculating price for a period:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/item_prices'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2030-01-01 12:00:00 UTC'
       --data-urlencode 'filter[item_id][]=6a8292cc-4002-4f8e-8da2-1e182dbacc08'
       --data-urlencode 'filter[item_id][]=6ac6ad52-9587-4088-8fd8-af88a9295a8e'
       --data-urlencode 'filter[till]=2030-01-14 12:00:00 UTC'
       --data-urlencode 'include=item'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "7d3ef505-b175-4f03-8151-9d77c4e8d823",
        "type": "item_prices",
        "attributes": {
          "item_id": "6a8292cc-4002-4f8e-8da2-1e182dbacc08",
          "from": "2028-03-25T10:11:00.000000+00:00",
          "till": "2028-04-07T10:11:00.000000+00:00",
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
              "id": "6a8292cc-4002-4f8e-8da2-1e182dbacc08"
            }
          }
        }
      },
      {
        "id": "1200d3ab-3efd-419e-8837-dbefde64a5c8",
        "type": "item_prices",
        "attributes": {
          "item_id": "6ac6ad52-9587-4088-8fd8-af88a9295a8e",
          "from": "2028-03-25T10:11:00.000000+00:00",
          "till": "2028-04-07T10:11:00.000000+00:00",
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
              "id": "6ac6ad52-9587-4088-8fd8-af88a9295a8e"
            }
          }
        }
      }
    ],
    "included": [
      {
        "id": "6a8292cc-4002-4f8e-8da2-1e182dbacc08",
        "type": "products",
        "attributes": {
          "created_at": "2023-03-17T07:36:00.000000+00:00",
          "updated_at": "2023-03-17T07:36:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "type": "products",
          "name": "Product 1000004",
          "group_name": "Product 1000004",
          "slug": "product-1000004",
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
          "allow_shortage": false,
          "shortage_limit": 0,
          "variation_values": [],
          "product_group_id": "248e9f40-8ade-4dd1-8bbc-2049129c3146"
        },
        "relationships": {}
      },
      {
        "id": "6ac6ad52-9587-4088-8fd8-af88a9295a8e",
        "type": "products",
        "attributes": {
          "created_at": "2023-03-17T07:36:00.000000+00:00",
          "updated_at": "2023-03-17T07:36:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "type": "products",
          "name": "Product 1000005",
          "group_name": "Product 1000005",
          "slug": "product-1000005",
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
          "allow_shortage": false,
          "shortage_limit": 0,
          "variation_values": [],
          "product_group_id": "88d23396-b095-4122-82f6-992f846605af"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

> Calculating price charge length:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/item_prices'
       --header 'content-type: application/json'
       --data-urlencode 'filter[charge_length]=36000'
       --data-urlencode 'filter[item_id]=f513ca7d-c6b0-432c-84fa-1b60f29a4cfa'
       --data-urlencode 'include=item'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "f010a8cf-b5d9-4ff8-853c-307a79289325",
        "type": "item_prices",
        "attributes": {
          "item_id": "f513ca7d-c6b0-432c-84fa-1b60f29a4cfa",
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
              "id": "f513ca7d-c6b0-432c-84fa-1b60f29a4cfa"
            }
          }
        }
      }
    ],
    "included": [
      {
        "id": "f513ca7d-c6b0-432c-84fa-1b60f29a4cfa",
        "type": "products",
        "attributes": {
          "created_at": "2023-06-13T08:19:05.000000+00:00",
          "updated_at": "2023-06-13T08:19:05.000000+00:00",
          "archived": false,
          "archived_at": null,
          "type": "products",
          "name": "Product 1000006",
          "group_name": "Product 1000006",
          "slug": "product-1000006",
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
          "allow_shortage": false,
          "shortage_limit": 0,
          "variation_values": [],
          "product_group_id": "c9235b08-a9f1-43e5-8ae8-cf204f682b53"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[item_prices]=item_id,from,till`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_tile,price_structure,item`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`charge_length` | **integer** <br>`eq`
`from` | **datetime** <br>`eq`
`item_id` | **uuid** <br>`eq`
`original_charge_length` | **integer** <br>`eq`
`price_ruleset_id` | **uuid** <br>`eq`
`price_structure_id` | **uuid** <br>`eq`
`till` | **datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`price_tile`


`price_structure`


`item`





