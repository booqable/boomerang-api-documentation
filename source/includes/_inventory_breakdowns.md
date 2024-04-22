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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=463ec9cc-80be-4211-8d33-b343fc76fb89&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f004296e-f67e-4a30-8c15-a28f833a2354",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "9076a177-b7cd-45b9-be04-901f38c30455",
        "product_id": "d1411117-6586-4424-bcf8-f89d66a0b435"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/9076a177-b7cd-45b9-be04-901f38c30455"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/d1411117-6586-4424-bcf8-f89d66a0b435"
          }
        }
      }
    },
    {
      "id": "1fb2066d-4c11-43bb-927f-bfaf252d6a4f",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "9076a177-b7cd-45b9-be04-901f38c30455",
        "product_id": "d1411117-6586-4424-bcf8-f89d66a0b435"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/9076a177-b7cd-45b9-be04-901f38c30455"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/d1411117-6586-4424-bcf8-f89d66a0b435"
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


> How to fetch a breakdown of all expired items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=b2288b49-8161-4d4b-8492-66abf2391747&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4a77f6dd-c05f-4c0c-917d-2d7d27183874",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "9ec46f5c-9cec-447c-add7-ae21818ad693",
        "product_id": "5d1237a4-250b-443d-a3de-ee8c0d52434b"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/9ec46f5c-9cec-447c-add7-ae21818ad693"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/5d1237a4-250b-443d-a3de-ee8c0d52434b"
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


> How to fetch a breakdown of all expected items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=401067cb-0a2a-46ff-9e67-0204a9997367&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dd32896f-d052-4115-a22d-5ce7160252de",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "26d6d060-334a-4330-b9e9-062140509252",
        "product_id": "6e2af1c3-df75-463a-91f4-afb0db73849c"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/26d6d060-334a-4330-b9e9-062140509252"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/6e2af1c3-df75-463a-91f4-afb0db73849c"
          }
        }
      }
    },
    {
      "id": "b912a85a-3dd6-48f2-a503-06a2044894d5",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "till": "1989-04-11T20:00:00+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "26d6d060-334a-4330-b9e9-062140509252",
        "product_id": "6e2af1c3-df75-463a-91f4-afb0db73849c"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/26d6d060-334a-4330-b9e9-062140509252"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/6e2af1c3-df75-463a-91f4-afb0db73849c"
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







