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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=be5a28c6-edb0-4760-a554-eb1549d3528c&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b42d5397-2ae3-460c-b8e2-af3f6270dbaa",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "1c17b473-2139-4745-958f-14c68dda9271",
        "product_id": "496fea88-fb4f-485d-b8e4-20608020de52"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/1c17b473-2139-4745-958f-14c68dda9271"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/496fea88-fb4f-485d-b8e4-20608020de52"
          }
        }
      }
    },
    {
      "id": "73b71caf-98cd-4e35-ba5f-ea51dbb0a607",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "1c17b473-2139-4745-958f-14c68dda9271",
        "product_id": "496fea88-fb4f-485d-b8e4-20608020de52"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/1c17b473-2139-4745-958f-14c68dda9271"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/496fea88-fb4f-485d-b8e4-20608020de52"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=443f9282-3b3f-4083-b861-cb2df35d6951&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d581b146-0786-4b7e-9bc4-18a39e911c26",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "66c9f611-1e8f-4c62-be80-a23b6fb005c5",
        "product_id": "2abbe442-fb00-4b47-983e-e049ef52f0e9"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/66c9f611-1e8f-4c62-be80-a23b6fb005c5"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/2abbe442-fb00-4b47-983e-e049ef52f0e9"
          }
        }
      }
    },
    {
      "id": "3be8abc3-0389-40b8-b1a2-c44ec1035e21",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "till": "1989-04-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "66c9f611-1e8f-4c62-be80-a23b6fb005c5",
        "product_id": "2abbe442-fb00-4b47-983e-e049ef52f0e9"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/66c9f611-1e8f-4c62-be80-a23b6fb005c5"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/2abbe442-fb00-4b47-983e-e049ef52f0e9"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=0e1d4dff-92e8-426e-b592-f0e5a6b5e16c&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2eab682d-8340-4f08-9b7e-48b32118a9d4",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00.000000+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "ea70a281-30f6-43eb-8a74-db9c197e7934",
        "product_id": "b96aeaee-7662-46f9-9b85-3dc9c24aea91"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/ea70a281-30f6-43eb-8a74-db9c197e7934"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/b96aeaee-7662-46f9-9b85-3dc9c24aea91"
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







