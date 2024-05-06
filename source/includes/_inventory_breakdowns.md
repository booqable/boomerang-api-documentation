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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=4872e756-ce7a-41dc-b050-339b5cb742e1&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9a6fadec-2815-4a53-b653-f5684d21e9e1",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "b4800bec-f8bc-4a70-a226-3ea3ab7826d7",
        "product_id": "ecfc98ae-1e61-4eaa-8eec-fc846356e6b2"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/b4800bec-f8bc-4a70-a226-3ea3ab7826d7"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ecfc98ae-1e61-4eaa-8eec-fc846356e6b2"
          }
        }
      }
    },
    {
      "id": "59d01a95-b324-492b-95b6-6e81aede5683",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "b4800bec-f8bc-4a70-a226-3ea3ab7826d7",
        "product_id": "ecfc98ae-1e61-4eaa-8eec-fc846356e6b2"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/b4800bec-f8bc-4a70-a226-3ea3ab7826d7"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ecfc98ae-1e61-4eaa-8eec-fc846356e6b2"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=549c443d-32d5-4475-bf9c-c5508847694c&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "835a99e6-a485-4936-9498-e8d8e68fd83f",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "6d2e9c65-dcce-43df-9e04-3ac6d139a7ba",
        "product_id": "880a8f28-8c49-4e7d-9004-e4608fd741d5"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/6d2e9c65-dcce-43df-9e04-3ac6d139a7ba"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/880a8f28-8c49-4e7d-9004-e4608fd741d5"
          }
        }
      }
    },
    {
      "id": "76e78bb7-bcd0-47a2-8349-39ce79bd3732",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "till": "1989-04-11T20:00:00+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "6d2e9c65-dcce-43df-9e04-3ac6d139a7ba",
        "product_id": "880a8f28-8c49-4e7d-9004-e4608fd741d5"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/6d2e9c65-dcce-43df-9e04-3ac6d139a7ba"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/880a8f28-8c49-4e7d-9004-e4608fd741d5"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=75eba07f-1eb9-42ae-bf7a-912467ad3149&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c5e17c53-e12b-40df-b8db-aa27afb15674",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "abaec605-dd9a-47d9-8254-f7650145d4de",
        "product_id": "5188c853-fb87-4086-a62e-4dd57bbcca47"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/abaec605-dd9a-47d9-8254-f7650145d4de"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/5188c853-fb87-4086-a62e-4dd57bbcca47"
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







