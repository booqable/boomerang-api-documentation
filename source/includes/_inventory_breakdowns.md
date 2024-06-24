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
-- | --
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
-- | --
`location` | **Locations** `readonly`<br>Associated Location
`product` | **Products** `readonly`<br>Associated Product


## Listing inventory breakdowns



> How to fetch a breakdown of all items in stock:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=8228b9f3-2819-4884-b74b-99101deaf98f&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "07b98e05-4e4a-4eea-a278-821459616661",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "df7f55ab-add4-47a1-a1d1-d9ab7876c129",
        "product_id": "79e1da33-f9c6-4fbf-8ce7-ff7cde8e908d"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/df7f55ab-add4-47a1-a1d1-d9ab7876c129"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/79e1da33-f9c6-4fbf-8ce7-ff7cde8e908d"
          }
        }
      }
    },
    {
      "id": "b67d129f-a963-47c5-99dd-1335061a00ec",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "df7f55ab-add4-47a1-a1d1-d9ab7876c129",
        "product_id": "79e1da33-f9c6-4fbf-8ce7-ff7cde8e908d"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/df7f55ab-add4-47a1-a1d1-d9ab7876c129"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/79e1da33-f9c6-4fbf-8ce7-ff7cde8e908d"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=c6a6778b-6980-4034-83a7-b3f00183ca76&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d0d6c488-23fd-49f9-a4f7-02a8d559fdb3",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "204784e0-eabd-4471-8789-aaf91a63391a",
        "product_id": "ade76bf2-2a11-48d9-90bc-e0a3d20d89da"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/204784e0-eabd-4471-8789-aaf91a63391a"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ade76bf2-2a11-48d9-90bc-e0a3d20d89da"
          }
        }
      }
    },
    {
      "id": "c4255f49-4b7c-4eb0-af0f-9392b5f1f88a",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "till": "1989-04-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "204784e0-eabd-4471-8789-aaf91a63391a",
        "product_id": "ade76bf2-2a11-48d9-90bc-e0a3d20d89da"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/204784e0-eabd-4471-8789-aaf91a63391a"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ade76bf2-2a11-48d9-90bc-e0a3d20d89da"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=800cfc87-2b6e-4574-886a-6d0581c34dc9&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2b2d542b-3b7c-4990-bae0-4efa1373d811",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00.000000+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "43a432ed-53ba-4d10-8096-553759b48933",
        "product_id": "3549411e-538a-40ff-b9ac-5d3f18430ad3"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/43a432ed-53ba-4d10-8096-553759b48933"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/3549411e-538a-40ff-b9ac-5d3f18430ad3"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=location,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[inventory_breakdowns]=from,till,stock_count`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`status` | **String** `required`<br>`eq`
`inventory_breakdown_type` | **String** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`product_id` | **Uuid** <br>`eq`
`product_group_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
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







