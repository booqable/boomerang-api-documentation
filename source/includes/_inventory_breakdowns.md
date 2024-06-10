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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=2ced87fd-1bf4-4484-baa5-dd9c5875d817&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e341eec5-bba9-4956-a0ef-44045559ecd2",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "75464367-8999-44c2-8a00-9e6d4b24158a",
        "product_id": "7fc48466-83b8-4444-8e16-7ce59a449b27"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/75464367-8999-44c2-8a00-9e6d4b24158a"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/7fc48466-83b8-4444-8e16-7ce59a449b27"
          }
        }
      }
    },
    {
      "id": "89e9792a-bb0d-4e4d-88a0-f47b3954d5ad",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "75464367-8999-44c2-8a00-9e6d4b24158a",
        "product_id": "7fc48466-83b8-4444-8e16-7ce59a449b27"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/75464367-8999-44c2-8a00-9e6d4b24158a"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/7fc48466-83b8-4444-8e16-7ce59a449b27"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=30ca9ce9-5488-429c-923f-c92845033cee&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a918d5a3-a5a5-412e-b572-cbc338ebe00c",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "8c96bec2-932f-4e99-9dcf-c651b73cb7c0",
        "product_id": "c90a6142-4d54-4135-86d1-3114d4a8e022"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/8c96bec2-932f-4e99-9dcf-c651b73cb7c0"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/c90a6142-4d54-4135-86d1-3114d4a8e022"
          }
        }
      }
    },
    {
      "id": "52c8bcaf-8349-445c-ba76-c8f213661468",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "till": "1989-04-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "8c96bec2-932f-4e99-9dcf-c651b73cb7c0",
        "product_id": "c90a6142-4d54-4135-86d1-3114d4a8e022"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/8c96bec2-932f-4e99-9dcf-c651b73cb7c0"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/c90a6142-4d54-4135-86d1-3114d4a8e022"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=8391b2b3-b3ba-4684-b909-44200f166210&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9eaf85cd-6680-4197-a28a-6bc13d31bf8a",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00.000000+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "78a53866-1284-49c0-9456-649a035bf248",
        "product_id": "10d11be0-fb68-49c8-a2f8-69af67c890c7"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/78a53866-1284-49c0-9456-649a035bf248"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/10d11be0-fb68-49c8-a2f8-69af67c890c7"
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







