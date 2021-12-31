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
`price_rule_values` | **Array** `readonly`<br>What price rules were applied
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
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=fd21d09b-f91c-430e-86c3-96617c691737&filter%5Bitem_id%5D%5B%5D=b175688f-af4d-4ab5-aae1-12363d3a0132&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "",
      "type": "item_prices",
      "attributes": {
        "item_id": "fd21d09b-f91c-430e-86c3-96617c691737",
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
            "related": "api/boomerang/items/fd21d09b-f91c-430e-86c3-96617c691737"
          },
          "data": {
            "type": "products",
            "id": "fd21d09b-f91c-430e-86c3-96617c691737"
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
      "id": "fd21d09b-f91c-430e-86c3-96617c691737",
      "type": "products",
      "attributes": {
        "created_at": "2021-12-30T11:21:42+00:00",
        "updated_at": "2021-12-30T11:21:42+00:00",
        "type": "products",
        "name": "Product 1",
        "slug": "product-1",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "archived": false,
        "archived_at": null,
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
        "product_group_id": "46cdbd60-b9e9-49e7-9751-467ae506e106",
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
            "related": "api/boomerang/product_groups/46cdbd60-b9e9-49e7-9751-467ae506e106"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=fd21d09b-f91c-430e-86c3-96617c691737&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=46cdbd60-b9e9-49e7-9751-467ae506e106&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=46cdbd60-b9e9-49e7-9751-467ae506e106"
          }
        }
      }
    },
    {
      "id": "b175688f-af4d-4ab5-aae1-12363d3a0132",
      "type": "products",
      "attributes": {
        "created_at": "2021-12-30T11:21:42+00:00",
        "updated_at": "2021-12-30T11:21:42+00:00",
        "type": "products",
        "name": "Product 2",
        "slug": "product-2",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "archived": false,
        "archived_at": null,
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
        "product_group_id": "e7a93854-e867-478a-bfb7-a52a8500dec4",
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
            "related": "api/boomerang/product_groups/e7a93854-e867-478a-bfb7-a52a8500dec4"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b175688f-af4d-4ab5-aae1-12363d3a0132&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=e7a93854-e867-478a-bfb7-a52a8500dec4&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=e7a93854-e867-478a-bfb7-a52a8500dec4"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=fd21d09b-f91c-430e-86c3-96617c691737&filter%5Bitem_id%5D%5B%5D=b175688f-af4d-4ab5-aae1-12363d3a0132&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=fd21d09b-f91c-430e-86c3-96617c691737&filter%5Bitem_id%5D%5B%5D=b175688f-af4d-4ab5-aae1-12363d3a0132&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=fd21d09b-f91c-430e-86c3-96617c691737&filter%5Bitem_id%5D%5B%5D=b175688f-af4d-4ab5-aae1-12363d3a0132&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/item_prices?filter%5Bfrom%5D=2030-01-01+12%3A00%3A00+UTC&filter%5Bitem_id%5D%5B%5D=fd21d09b-f91c-430e-86c3-96617c691737&filter%5Bitem_id%5D%5B%5D=b175688f-af4d-4ab5-aae1-12363d3a0132&filter%5Btill%5D=2030-01-14+12%3A00%3A00+UTC&include=item&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> Calculating price charge length:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=b368ae79-d489-4f23-aee8-c7f93fae4aa4&include=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "",
      "type": "item_prices",
      "attributes": {
        "item_id": "b368ae79-d489-4f23-aee8-c7f93fae4aa4",
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
            "related": "api/boomerang/items/b368ae79-d489-4f23-aee8-c7f93fae4aa4"
          },
          "data": {
            "type": "products",
            "id": "b368ae79-d489-4f23-aee8-c7f93fae4aa4"
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
      "id": "b368ae79-d489-4f23-aee8-c7f93fae4aa4",
      "type": "products",
      "attributes": {
        "created_at": "2021-12-30T11:21:43+00:00",
        "updated_at": "2021-12-30T11:21:43+00:00",
        "type": "products",
        "name": "Product 3",
        "slug": "product-3",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "archived": false,
        "archived_at": null,
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
        "product_group_id": "27b13352-ef45-4bb9-9ed3-01fec3d40315",
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
            "related": "api/boomerang/product_groups/27b13352-ef45-4bb9-9ed3-01fec3d40315"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b368ae79-d489-4f23-aee8-c7f93fae4aa4&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=27b13352-ef45-4bb9-9ed3-01fec3d40315&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=27b13352-ef45-4bb9-9ed3-01fec3d40315"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=b368ae79-d489-4f23-aee8-c7f93fae4aa4&include=item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=b368ae79-d489-4f23-aee8-c7f93fae4aa4&include=item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=b368ae79-d489-4f23-aee8-c7f93fae4aa4&include=item&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/item_prices?filter%5Bcharge_length%5D=36000&filter%5Bitem_id%5D=b368ae79-d489-4f23-aee8-c7f93fae4aa4&include=item&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-30T11:20:24Z`
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





