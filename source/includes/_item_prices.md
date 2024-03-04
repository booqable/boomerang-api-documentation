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



> Calculating price charge length:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=1145452c-2121-49cf-a41e-d4ab9c32a171&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7c9faa9a-094f-4b22-a960-9286e5d8f146",
      "type": "item_prices",
      "attributes": {
        "item_id": "1145452c-2121-49cf-a41e-d4ab9c32a171",
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
            "related": "api/boomerang/items/1145452c-2121-49cf-a41e-d4ab9c32a171"
          },
          "data": {
            "type": "products",
            "id": "1145452c-2121-49cf-a41e-d4ab9c32a171"
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
      "id": "1145452c-2121-49cf-a41e-d4ab9c32a171",
      "type": "products",
      "attributes": {
        "created_at": "2024-03-04T09:14:22+00:00",
        "updated_at": "2024-03-04T09:14:22+00:00",
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
        "product_group_id": "f37ebfc0-9b54-45ac-bc1a-323cb48c62fe"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=1145452c-2121-49cf-a41e-d4ab9c32a171"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=f37ebfc0-9b54-45ac-bc1a-323cb48c62fe&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/f37ebfc0-9b54-45ac-bc1a-323cb48c62fe"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1145452c-2121-49cf-a41e-d4ab9c32a171&filter[owner_type]=products"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> Calculating price for a period:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=f633fc9d-ae1b-4f71-8385-d36152353494&filter%5Bitem_id%5D%5B%5D=8f4e11a7-0a20-411b-847f-114796ab1f4a&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bbf08b9a-a83d-4681-a686-e7520a5c8557",
      "type": "item_prices",
      "attributes": {
        "item_id": "f633fc9d-ae1b-4f71-8385-d36152353494",
        "from": "2030-01-01T12:00:00+00:00",
        "till": "2030-01-14T12:00:00+00:00",
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
            "related": "api/boomerang/items/f633fc9d-ae1b-4f71-8385-d36152353494"
          },
          "data": {
            "type": "products",
            "id": "f633fc9d-ae1b-4f71-8385-d36152353494"
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
      "id": "39b24eb6-7e88-415c-ae92-7be2dc2c995c",
      "type": "item_prices",
      "attributes": {
        "item_id": "8f4e11a7-0a20-411b-847f-114796ab1f4a",
        "from": "2030-01-01T12:00:00+00:00",
        "till": "2030-01-14T12:00:00+00:00",
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
            "related": "api/boomerang/items/8f4e11a7-0a20-411b-847f-114796ab1f4a"
          },
          "data": {
            "type": "products",
            "id": "8f4e11a7-0a20-411b-847f-114796ab1f4a"
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
      "id": "f633fc9d-ae1b-4f71-8385-d36152353494",
      "type": "products",
      "attributes": {
        "created_at": "2024-03-04T09:14:23+00:00",
        "updated_at": "2024-03-04T09:14:23+00:00",
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
        "product_group_id": "385757f5-65c6-449d-bc24-3b5ae9c4c490"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=f633fc9d-ae1b-4f71-8385-d36152353494"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=385757f5-65c6-449d-bc24-3b5ae9c4c490&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/385757f5-65c6-449d-bc24-3b5ae9c4c490"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f633fc9d-ae1b-4f71-8385-d36152353494&filter[owner_type]=products"
          }
        }
      }
    },
    {
      "id": "8f4e11a7-0a20-411b-847f-114796ab1f4a",
      "type": "products",
      "attributes": {
        "created_at": "2024-03-04T09:14:23+00:00",
        "updated_at": "2024-03-04T09:14:23+00:00",
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
        "product_group_id": "4c824963-678b-470f-91f5-a3f4839631dd"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=8f4e11a7-0a20-411b-847f-114796ab1f4a"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=4c824963-678b-470f-91f5-a3f4839631dd&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/4c824963-678b-470f-91f5-a3f4839631dd"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8f4e11a7-0a20-411b-847f-114796ab1f4a&filter[owner_type]=products"
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





