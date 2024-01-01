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



> How to fetch a breakdown of all expired items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=76034fca-d177-42ca-a9cd-fdbfebbcd492&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0b5e9e87-2ac8-454e-800d-c18ddbe54e28",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "2ad7233d-b4f0-483f-8ffa-c1c699702e88",
        "product_id": "a551cfc3-8f4d-4d2d-8a50-74dc1982493f"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/2ad7233d-b4f0-483f-8ffa-c1c699702e88"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/a551cfc3-8f4d-4d2d-8a50-74dc1982493f"
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


> How to fetch a breakdown of all items in stock:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=cc9bc165-f5d2-40d2-bf79-1f7a4f346ccb&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d8768b62-2c3b-4c71-a84b-a33965048aaa",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "df2f10a8-67e7-42db-80f4-5291c1c7380d",
        "product_id": "a27787ac-1ad7-47e9-8bc0-aaad42371bed"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/df2f10a8-67e7-42db-80f4-5291c1c7380d"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/a27787ac-1ad7-47e9-8bc0-aaad42371bed"
          }
        }
      }
    },
    {
      "id": "5987ed4d-640c-4526-94fc-0e3b319c6ce5",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "df2f10a8-67e7-42db-80f4-5291c1c7380d",
        "product_id": "a27787ac-1ad7-47e9-8bc0-aaad42371bed"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/df2f10a8-67e7-42db-80f4-5291c1c7380d"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/a27787ac-1ad7-47e9-8bc0-aaad42371bed"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=b4489318-cee2-4212-b26c-e1ab28e07bb7&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "abf50082-7099-4eb7-b100-3c524c68632e",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "f3f5d718-ed4a-4bb6-9748-697720753295",
        "product_id": "fae0ab0c-5ac7-4eb5-990f-1ef93ad5bdb2"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/f3f5d718-ed4a-4bb6-9748-697720753295"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/fae0ab0c-5ac7-4eb5-990f-1ef93ad5bdb2"
          }
        }
      }
    },
    {
      "id": "bc613186-bfea-4aa3-a18c-5d2b1b9bb6b5",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "till": "1989-04-11T20:00:00+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "f3f5d718-ed4a-4bb6-9748-697720753295",
        "product_id": "fae0ab0c-5ac7-4eb5-990f-1ef93ad5bdb2"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/f3f5d718-ed4a-4bb6-9748-697720753295"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/fae0ab0c-5ac7-4eb5-990f-1ef93ad5bdb2"
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







