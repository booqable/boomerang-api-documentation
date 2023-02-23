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
`from` | **Datetime** <br>When the amount of items will be available (only for status `expected`)
`till` | **Datetime** <br>When the amount of items will become unavailable (only for type `temporary` and/or status `expired`)
`stock_count` | **Integer** <br>The total amount of stock for product and location
`started` | **Integer** <br>The amount if items that are started for product and location. Only rendered when applicable
`status` | **String** <br>One of `expected`, `in_stock`, `expired`
`inventory_breakdown_type` | **String** <br>One of `regular`, `temporary`
`location_id` | **Uuid** <br>The associated Location
`product_id` | **Uuid** <br>The associated Product


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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=2be6b691-5cdd-4203-98bc-0bbf5af19e6c&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
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
        "location_id": "9ed2dcfb-4f99-4bed-a72d-c42744b9062f",
        "product_id": "29d940bc-8347-4860-b32a-4fca359ce931"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/9ed2dcfb-4f99-4bed-a72d-c42744b9062f"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/29d940bc-8347-4860-b32a-4fca359ce931"
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
        "location_id": "9ed2dcfb-4f99-4bed-a72d-c42744b9062f",
        "product_id": "29d940bc-8347-4860-b32a-4fca359ce931"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/9ed2dcfb-4f99-4bed-a72d-c42744b9062f"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/29d940bc-8347-4860-b32a-4fca359ce931"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=a594ff37-2660-4a5a-85ee-7e3e1d0d4eac&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
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
        "location_id": "d98c09c3-fe52-4caf-a24f-7b7146b48c20",
        "product_id": "59240f8b-f8ed-4cbb-b189-d2e8e5c9bf84"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/d98c09c3-fe52-4caf-a24f-7b7146b48c20"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/59240f8b-f8ed-4cbb-b189-d2e8e5c9bf84"
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
        "location_id": "d98c09c3-fe52-4caf-a24f-7b7146b48c20",
        "product_id": "59240f8b-f8ed-4cbb-b189-d2e8e5c9bf84"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/d98c09c3-fe52-4caf-a24f-7b7146b48c20"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/59240f8b-f8ed-4cbb-b189-d2e8e5c9bf84"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=a33db063-5afd-4d76-8ff3-84b78d0712b8&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
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
        "location_id": "e33b2f39-ea5a-4e11-a63d-8594c6da275a",
        "product_id": "ff7932ac-a0bb-4af1-bc64-e51531e31861"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/e33b2f39-ea5a-4e11-a63d-8594c6da275a"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ff7932ac-a0bb-4af1-bc64-e51531e31861"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=location,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[inventory_breakdowns]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T13:35:38Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`status` | **String** `required`<br>`eq`
`inventory_breakdown_type` | **String** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`product_id` | **Uuid** <br>`eq`
`product_group_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`status` | **Array** <br>`sum`
`inventory_breakdown_type` | **Array** <br>`sum`
`stock_count` | **Array** <br>`sum`, `count`
`started` | **Array** <br>`sum`


### Includes

This request accepts the following includes:

`location`


`product` => 
`photo`







