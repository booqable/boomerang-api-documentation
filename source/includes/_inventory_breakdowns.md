# Inventory breakdowns

Fetch quantitive information about product inventory compared to the current time, broken down by:

- Location
- Product
- Type
- Mutation date(s)

**Useful for:**

- Examining what the current inventory looks, and will look, like for products
- Performing an inventory count (total in stock vs. out with a customer)

## Fields
Every inventory breakdown has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`from` | **Datetime**<br>When the amount of items will be available (only for status `expected`)
`till` | **Datetime**<br>When the amount of items will become unavailable (only for type `temporary` and/or status `expired`)
`stock_count` | **Integer**<br>The total amount of stock for product and location
`started` | **Integer**<br>The amount if items that are started for product and location. Only rendered when applicable
`status` | **String**<br>One of `expected`, `in_stock`, `expired`
`inventory_breakdown_type` | **String**<br>One of `regular`, `temporary`
`location_id` | **Uuid**<br>The associated Location
`product_id` | **Uuid**<br>The associated Product


## Relationships
Inventory breakdowns have the following relationships:

Name | Description
- | -
`location` | **Locations** `readonly`<br>Associated Location
`product` | **Products** `readonly`<br>Associated Product


## Listing inventory breakdowns



> How to fetch a breakdown of all items in stock:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=6931b292-bb0d-45ab-afd4-9ba0b871f21b&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f8c543b9-38c5-5039-b97c-c131db7e6b40",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "810e93ac-226e-4f38-897e-d65d8639a0bf",
        "product_id": "0945fdd5-b05c-4585-b219-63d138d94a4b"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/810e93ac-226e-4f38-897e-d65d8639a0bf"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/0945fdd5-b05c-4585-b219-63d138d94a4b"
          }
        }
      }
    },
    {
      "id": "virtual-88ccf45a-fc35-5bc1-91ac-feef23a6d5e6",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "810e93ac-226e-4f38-897e-d65d8639a0bf",
        "product_id": "0945fdd5-b05c-4585-b219-63d138d94a4b"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/810e93ac-226e-4f38-897e-d65d8639a0bf"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/0945fdd5-b05c-4585-b219-63d138d94a4b"
          }
        }
      }
    }
  ],
  "meta": {
    "stats": {
      "inventory_breakdown_type": {
        "sum": {
          "regular": 100,
          "temporary": 5
        }
      },
      "started": {
        "sum": 50
      },
      "status": {
        "sum": {
          "in_stock": 105,
          "expected": 17,
          "expired": 22
        }
      },
      "stock_count": {
        "sum": 105
      }
    }
  }
}
```


> How to fetch a breakdown of all expected items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=785c50f4-94dc-4b13-b993-9b89e45f426b&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f8c543b9-38c5-5039-b97c-c131db7e6b40",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "50cd5d71-1009-429c-abae-05e88c395963",
        "product_id": "75d65aba-283b-453e-90c1-1e692c174208"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/50cd5d71-1009-429c-abae-05e88c395963"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/75d65aba-283b-453e-90c1-1e692c174208"
          }
        }
      }
    },
    {
      "id": "virtual-88ccf45a-fc35-5bc1-91ac-feef23a6d5e6",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "till": "1989-04-11T20:00:00+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "50cd5d71-1009-429c-abae-05e88c395963",
        "product_id": "75d65aba-283b-453e-90c1-1e692c174208"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/50cd5d71-1009-429c-abae-05e88c395963"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/75d65aba-283b-453e-90c1-1e692c174208"
          }
        }
      }
    }
  ],
  "meta": {
    "stats": {
      "inventory_breakdown_type": {
        "sum": {
          "regular": 12,
          "temporary": 5
        }
      },
      "started": {
        "sum": 0
      },
      "status": {
        "sum": {
          "in_stock": 105,
          "expected": 17,
          "expired": 22
        }
      },
      "stock_count": {
        "sum": 17
      }
    }
  }
}
```


> How to fetch a breakdown of all expired items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=40b56944-f4f8-4736-9018-e7cb44241d29&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f8c543b9-38c5-5039-b97c-c131db7e6b40",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "6adddae6-6026-4a8a-ab69-53bbd9bf6b28",
        "product_id": "26470c00-ab1b-4f20-8f15-fa11e0f4ee45"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/6adddae6-6026-4a8a-ab69-53bbd9bf6b28"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/26470c00-ab1b-4f20-8f15-fa11e0f4ee45"
          }
        }
      }
    }
  ],
  "meta": {
    "stats": {
      "inventory_breakdown_type": {
        "sum": {
          "regular": 0,
          "temporary": 22
        }
      },
      "started": {
        "sum": 0
      },
      "status": {
        "sum": {
          "in_stock": 105,
          "expected": 17,
          "expired": 22
        }
      },
      "stock_count": {
        "sum": 22
      }
    }
  }
}
```

### HTTP Request

`GET /api/boomerang/inventory_breakdowns`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=location,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[inventory_breakdowns]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-24T12:35:47Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`status` | **String** `required`<br>`eq`
`inventory_breakdown_type` | **String**<br>`eq`
`location_id` | **Uuid**<br>`eq`
`product_id` | **Uuid**<br>`eq`
`product_group_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`status` | **Array**<br>`sum`
`inventory_breakdown_type` | **Array**<br>`sum`
`stock_count` | **Array**<br>`sum`, `count`
`started` | **Array**<br>`sum`


### Includes

This request accepts the following includes:

`location`


`product` => 
`photo`







