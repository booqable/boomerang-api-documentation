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
-- | --
`item` | **Items** `readonly`<br>Associated Item
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset
`price_tile` | **Price tiles** `readonly`<br>Associated Price tile


## Calcuating the price of products and/or bundles



> Calculating price for a period:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=c529d230-7080-4c5e-97ac-115c45d4d4db&filter%5Bitem_id%5D%5B%5D=66a612e7-01a7-4690-a947-bdc38cb200e0&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b748d70a-4e94-585f-b78e-c0004b09d665",
      "type": "item_prices",
      "attributes": {
        "item_id": "c529d230-7080-4c5e-97ac-115c45d4d4db",
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
            "related": "api/boomerang/items/c529d230-7080-4c5e-97ac-115c45d4d4db"
          },
          "data": {
            "type": "products",
            "id": "c529d230-7080-4c5e-97ac-115c45d4d4db"
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
      "id": "virtual-d0db9c36-8857-5ed0-8c79-4adf45f24c9c",
      "type": "item_prices",
      "attributes": {
        "item_id": "66a612e7-01a7-4690-a947-bdc38cb200e0",
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
            "related": "api/boomerang/items/66a612e7-01a7-4690-a947-bdc38cb200e0"
          },
          "data": {
            "type": "products",
            "id": "66a612e7-01a7-4690-a947-bdc38cb200e0"
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
      "id": "c529d230-7080-4c5e-97ac-115c45d4d4db",
      "type": "products",
      "attributes": {
        "created_at": "2023-07-10T09:17:13+00:00",
        "updated_at": "2023-07-10T09:17:13+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000007",
        "group_name": "Product 1000007",
        "slug": "product-1000007",
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
        "product_group_id": "bb4e3ad1-0654-44db-8d14-2b89da33867c"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=c529d230-7080-4c5e-97ac-115c45d4d4db"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=bb4e3ad1-0654-44db-8d14-2b89da33867c&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/bb4e3ad1-0654-44db-8d14-2b89da33867c"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c529d230-7080-4c5e-97ac-115c45d4d4db&filter[owner_type]=products"
          }
        }
      }
    },
    {
      "id": "66a612e7-01a7-4690-a947-bdc38cb200e0",
      "type": "products",
      "attributes": {
        "created_at": "2023-07-10T09:17:14+00:00",
        "updated_at": "2023-07-10T09:17:14+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000008",
        "group_name": "Product 1000008",
        "slug": "product-1000008",
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
        "product_group_id": "943b2e72-236b-4382-aa57-ec9152043c8a"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=66a612e7-01a7-4690-a947-bdc38cb200e0"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=943b2e72-236b-4382-aa57-ec9152043c8a&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/943b2e72-236b-4382-aa57-ec9152043c8a"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=66a612e7-01a7-4690-a947-bdc38cb200e0&filter[owner_type]=products"
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=e4dbbc2e-2810-4420-b219-00c1e3606de4&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b748d70a-4e94-585f-b78e-c0004b09d665",
      "type": "item_prices",
      "attributes": {
        "item_id": "e4dbbc2e-2810-4420-b219-00c1e3606de4",
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
            "related": "api/boomerang/items/e4dbbc2e-2810-4420-b219-00c1e3606de4"
          },
          "data": {
            "type": "products",
            "id": "e4dbbc2e-2810-4420-b219-00c1e3606de4"
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
      "id": "e4dbbc2e-2810-4420-b219-00c1e3606de4",
      "type": "products",
      "attributes": {
        "created_at": "2023-07-10T09:17:14+00:00",
        "updated_at": "2023-07-10T09:17:14+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000009",
        "group_name": "Product 1000009",
        "slug": "product-1000009",
        "sku": "PRODUCT 1000011",
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
        "product_group_id": "b8afef23-f063-437a-b46f-82b5c6429f2f"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=e4dbbc2e-2810-4420-b219-00c1e3606de4"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=b8afef23-f063-437a-b46f-82b5c6429f2f&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/b8afef23-f063-437a-b46f-82b5c6429f2f"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e4dbbc2e-2810-4420-b219-00c1e3606de4&filter[owner_type]=products"
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





