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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=5d42d6e7-7a31-4703-b47c-4483fdeb342e&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
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
        "location_id": "1198f5f8-07e3-4e39-9a45-176ae9aa9019",
        "product_id": "69cda922-ba59-4a40-b425-0702716197c4"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/1198f5f8-07e3-4e39-9a45-176ae9aa9019"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/69cda922-ba59-4a40-b425-0702716197c4"
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
        "location_id": "1198f5f8-07e3-4e39-9a45-176ae9aa9019",
        "product_id": "69cda922-ba59-4a40-b425-0702716197c4"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/1198f5f8-07e3-4e39-9a45-176ae9aa9019"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/69cda922-ba59-4a40-b425-0702716197c4"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=15a1b5d8-0597-4490-9d52-4009b216fb0f&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
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
        "location_id": "6da351a1-bab4-4882-a51c-3d81379b04e8",
        "product_id": "cf1835e5-b9c1-44b4-9690-466603e1aa65"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/6da351a1-bab4-4882-a51c-3d81379b04e8"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/cf1835e5-b9c1-44b4-9690-466603e1aa65"
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
        "location_id": "6da351a1-bab4-4882-a51c-3d81379b04e8",
        "product_id": "cf1835e5-b9c1-44b4-9690-466603e1aa65"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/6da351a1-bab4-4882-a51c-3d81379b04e8"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/cf1835e5-b9c1-44b4-9690-466603e1aa65"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=5bbd3683-ba84-4414-a7db-c7af72d86d53&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
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
        "location_id": "bc04b3b4-e11a-4e7f-8efc-725e4cd0dc4d",
        "product_id": "72639ceb-1c07-420b-a486-a7d110159e47"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/bc04b3b4-e11a-4e7f-8efc-725e4cd0dc4d"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/72639ceb-1c07-420b-a486-a7d110159e47"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
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







