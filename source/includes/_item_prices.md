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
`item_id` | **Uuid**<br>The associated Item
`from` | **Datetime**<br>Start of charge period
`till` | **Datetime**<br>End of charge period
`charge_length` | **Integer**<br>Length of charge period in seconds
`charge_label` | **String** `readonly`<br>Label for the charge period
`original_price_each_in_cents` | **Integer** `readonly`<br>Price per item before charge rules are applied
`price_each_in_cents` | **Integer** `readonly`<br>Final price per item
`price_rule_values` | **Hash** `readonly`<br>What price rules were applied
`price_structure_id` | **Uuid**<br>The associated Price structure
`price_tile_id` | **Uuid** `readonly`<br>The associated Price tile


## Relationships
Item prices have the following relationships:

Name | Description
- | -
`item` | **Items** `readonly`<br>Associated Item
`price_structure` | **Price structures**<br>Associated Price structure
`price_tile` | **Price tiles** `readonly`<br>Associated Price tile


## Calcuating the price of products and/or bundles



> Calculating price for a period:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=d777631c-6ded-453d-bc74-14e91017d293&filter%5Bitem_id%5D%5B%5D=89f0d025-54c0-4ae2-a778-c046cd3ffb57&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-3b8c1f20-50d2-5c07-8232-c28204295ebc",
      "type": "item_prices",
      "attributes": {
        "item_id": "d777631c-6ded-453d-bc74-14e91017d293",
        "from": "2030-01-01T12:00:00+00:00",
        "till": "2030-01-14T12:00:00+00:00",
        "charge_length": null,
        "charge_label": "13 days",
        "original_price_each_in_cents": 31200,
        "price_each_in_cents": 31200,
        "price_rule_values": null,
        "price_structure_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/d777631c-6ded-453d-bc74-14e91017d293"
          },
          "data": {
            "type": "products",
            "id": "d777631c-6ded-453d-bc74-14e91017d293"
          }
        },
        "price_structure": {
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
      "id": "virtual-62b2173b-36cd-5e9e-948f-4cd260a48f09",
      "type": "item_prices",
      "attributes": {
        "item_id": "89f0d025-54c0-4ae2-a778-c046cd3ffb57",
        "from": "2030-01-01T12:00:00+00:00",
        "till": "2030-01-14T12:00:00+00:00",
        "charge_length": null,
        "charge_label": "13 days",
        "original_price_each_in_cents": 74100,
        "price_each_in_cents": 74100,
        "price_rule_values": null,
        "price_structure_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/89f0d025-54c0-4ae2-a778-c046cd3ffb57"
          },
          "data": {
            "type": "products",
            "id": "89f0d025-54c0-4ae2-a778-c046cd3ffb57"
          }
        },
        "price_structure": {
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
      "id": "d777631c-6ded-453d-bc74-14e91017d293",
      "type": "products",
      "attributes": {
        "created_at": "2022-07-14T10:34:36+00:00",
        "updated_at": "2022-07-14T10:34:36+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 4",
        "slug": "product-4",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
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
        "product_group_id": "7cb90536-f9f2-4d21-85e2-988ae07c3ed3",
        "tax_category_id": null,
        "price_structure_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/7cb90536-f9f2-4d21-85e2-988ae07c3ed3"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d777631c-6ded-453d-bc74-14e91017d293&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=d777631c-6ded-453d-bc74-14e91017d293"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=7cb90536-f9f2-4d21-85e2-988ae07c3ed3&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=7cb90536-f9f2-4d21-85e2-988ae07c3ed3"
          }
        }
      }
    },
    {
      "id": "89f0d025-54c0-4ae2-a778-c046cd3ffb57",
      "type": "products",
      "attributes": {
        "created_at": "2022-07-14T10:34:36+00:00",
        "updated_at": "2022-07-14T10:34:36+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 5",
        "slug": "product-5",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
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
        "product_group_id": "77852c52-2676-4856-b73f-5c1262ad686b",
        "tax_category_id": null,
        "price_structure_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/77852c52-2676-4856-b73f-5c1262ad686b"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=89f0d025-54c0-4ae2-a778-c046cd3ffb57&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=89f0d025-54c0-4ae2-a778-c046cd3ffb57"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=77852c52-2676-4856-b73f-5c1262ad686b&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=77852c52-2676-4856-b73f-5c1262ad686b"
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=bf714727-30fb-45a6-8ab6-a2ecddc57faf&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a5cb3508-3dca-55fe-b585-6afa2e8d622a",
      "type": "item_prices",
      "attributes": {
        "item_id": "bf714727-30fb-45a6-8ab6-a2ecddc57faf",
        "from": null,
        "till": null,
        "charge_length": 36000,
        "charge_label": "10 hours",
        "original_price_each_in_cents": null,
        "price_each_in_cents": 1000,
        "price_rule_values": null,
        "price_structure_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/bf714727-30fb-45a6-8ab6-a2ecddc57faf"
          },
          "data": {
            "type": "products",
            "id": "bf714727-30fb-45a6-8ab6-a2ecddc57faf"
          }
        },
        "price_structure": {
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
      "id": "bf714727-30fb-45a6-8ab6-a2ecddc57faf",
      "type": "products",
      "attributes": {
        "created_at": "2022-07-14T10:34:36+00:00",
        "updated_at": "2022-07-14T10:34:36+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "Product 6",
        "slug": "product-6",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
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
        "product_group_id": "c4faf23f-d450-408e-8c63-b75f63ab2d5f",
        "tax_category_id": null,
        "price_structure_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/c4faf23f-d450-408e-8c63-b75f63ab2d5f"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bf714727-30fb-45a6-8ab6-a2ecddc57faf&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=bf714727-30fb-45a6-8ab6-a2ecddc57faf"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=c4faf23f-d450-408e-8c63-b75f63ab2d5f&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=c4faf23f-d450-408e-8c63-b75f63ab2d5f"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,price_structure,price_tile`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[item_prices]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:33:21Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid**<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`
`charge_length` | **Integer**<br>`eq`
`price_structure_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`price_tile`


`price_structure`


`item`





