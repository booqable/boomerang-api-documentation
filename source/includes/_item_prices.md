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
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset
`price_tile` | **Price tiles** `readonly`<br>Associated Price tile


## Calcuating the price of products and/or bundles



> Calculating price for a period:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=f7b4b703-401b-4782-b984-3280ace1eca5&filter%5Bitem_id%5D%5B%5D=9bfe7cc3-d250-4c5a-9763-c0130f43b05c&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8e6e9fbc-34b6-48e7-8b50-2811636dc5ca",
      "type": "item_prices",
      "attributes": {
        "item_id": "f7b4b703-401b-4782-b984-3280ace1eca5",
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
          "links": {
            "related": "api/boomerang/items/f7b4b703-401b-4782-b984-3280ace1eca5"
          },
          "data": {
            "type": "products",
            "id": "f7b4b703-401b-4782-b984-3280ace1eca5"
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
      "id": "bc392b6d-879c-48d2-b59c-7470c900e2a5",
      "type": "item_prices",
      "attributes": {
        "item_id": "9bfe7cc3-d250-4c5a-9763-c0130f43b05c",
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
          "links": {
            "related": "api/boomerang/items/9bfe7cc3-d250-4c5a-9763-c0130f43b05c"
          },
          "data": {
            "type": "products",
            "id": "9bfe7cc3-d250-4c5a-9763-c0130f43b05c"
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
      "id": "f7b4b703-401b-4782-b984-3280ace1eca5",
      "type": "products",
      "attributes": {
        "created_at": "2024-06-10T09:22:44.242600+00:00",
        "updated_at": "2024-06-10T09:22:44.242600+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000002",
        "group_name": "Product 1000002",
        "slug": "product-1000002",
        "sku": "PRODUCT 1000002",
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
        "product_group_id": "a0c80d22-e85e-459d-bf47-28ed17196140"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=f7b4b703-401b-4782-b984-3280ace1eca5"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=a0c80d22-e85e-459d-bf47-28ed17196140&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/a0c80d22-e85e-459d-bf47-28ed17196140"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f7b4b703-401b-4782-b984-3280ace1eca5&filter[owner_type]=products"
          }
        }
      }
    },
    {
      "id": "9bfe7cc3-d250-4c5a-9763-c0130f43b05c",
      "type": "products",
      "attributes": {
        "created_at": "2024-06-10T09:22:44.608907+00:00",
        "updated_at": "2024-06-10T09:22:44.608907+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000003",
        "group_name": "Product 1000003",
        "slug": "product-1000003",
        "sku": "PRODUCT 1000003",
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
        "product_group_id": "4617b6a9-c49f-448f-9355-cd3738e95b63"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=9bfe7cc3-d250-4c5a-9763-c0130f43b05c"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=4617b6a9-c49f-448f-9355-cd3738e95b63&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/4617b6a9-c49f-448f-9355-cd3738e95b63"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9bfe7cc3-d250-4c5a-9763-c0130f43b05c&filter[owner_type]=products"
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=f2aafe1d-6319-496a-b62b-06f37e68cb05&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "31019686-73a8-42ab-b6b6-0370e2ce80aa",
      "type": "item_prices",
      "attributes": {
        "item_id": "f2aafe1d-6319-496a-b62b-06f37e68cb05",
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
          "links": {
            "related": "api/boomerang/items/f2aafe1d-6319-496a-b62b-06f37e68cb05"
          },
          "data": {
            "type": "products",
            "id": "f2aafe1d-6319-496a-b62b-06f37e68cb05"
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
      "id": "f2aafe1d-6319-496a-b62b-06f37e68cb05",
      "type": "products",
      "attributes": {
        "created_at": "2024-06-10T09:22:43.126112+00:00",
        "updated_at": "2024-06-10T09:22:43.126112+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 1000000",
        "group_name": "Product 1000000",
        "slug": "product-1000000",
        "sku": "PRODUCT 1000000",
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
        "product_group_id": "e40b0f54-e10f-4b4e-bbc3-a5cbd1cb13d7"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=f2aafe1d-6319-496a-b62b-06f37e68cb05"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=e40b0f54-e10f-4b4e-bbc3-a5cbd1cb13d7&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/e40b0f54-e10f-4b4e-bbc3-a5cbd1cb13d7"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f2aafe1d-6319-496a-b62b-06f37e68cb05&filter[owner_type]=products"
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





