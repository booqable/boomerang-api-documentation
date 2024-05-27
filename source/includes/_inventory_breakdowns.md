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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=27db0892-8540-4cc1-a6d5-adcc608eae58&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "088cc151-bea3-4db0-a47a-ddca02dcf183",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "6c76b025-2ed3-4ec0-bf8d-4b229094d69f",
        "product_id": "663377eb-646e-4d16-bc30-4f14a4b669d7"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/6c76b025-2ed3-4ec0-bf8d-4b229094d69f"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/663377eb-646e-4d16-bc30-4f14a4b669d7"
          }
        }
      }
    },
    {
      "id": "443fda03-bbf9-43c2-850b-c0abf0dce8ba",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "6c76b025-2ed3-4ec0-bf8d-4b229094d69f",
        "product_id": "663377eb-646e-4d16-bc30-4f14a4b669d7"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/6c76b025-2ed3-4ec0-bf8d-4b229094d69f"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/663377eb-646e-4d16-bc30-4f14a4b669d7"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=3f4749bb-06ba-4eb2-ab64-65bd7ebd77b8&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4e85a0d1-5812-4152-aecf-fe2e2bd30efa",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00.000000+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "cb856ce8-0bd2-4502-b443-8fccd9d19293",
        "product_id": "07ea330c-d9e1-4028-946d-0b0e73f3889c"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/cb856ce8-0bd2-4502-b443-8fccd9d19293"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/07ea330c-d9e1-4028-946d-0b0e73f3889c"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=f05694ea-972b-4982-804e-68d7d696307a&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "205fa02b-d0f5-4a17-8e75-88acac4d098b",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "aa230d22-fbbd-4e45-a2fb-6c0c39deffaa",
        "product_id": "5e0ce04e-cbb9-46ca-be00-10ba2857202a"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/aa230d22-fbbd-4e45-a2fb-6c0c39deffaa"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/5e0ce04e-cbb9-46ca-be00-10ba2857202a"
          }
        }
      }
    },
    {
      "id": "101ca5a1-678e-4c9d-8f7f-2e1f6a4a4a71",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "till": "1989-04-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "aa230d22-fbbd-4e45-a2fb-6c0c39deffaa",
        "product_id": "5e0ce04e-cbb9-46ca-be00-10ba2857202a"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/aa230d22-fbbd-4e45-a2fb-6c0c39deffaa"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/5e0ce04e-cbb9-46ca-be00-10ba2857202a"
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







