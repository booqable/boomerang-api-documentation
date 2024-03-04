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



> How to fetch a breakdown of all expected items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=d4c445b2-e204-4cdf-804c-a0c1f916a6bd&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "91e6307a-95eb-4ad9-bfe4-1050791c75f3",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "d268e87d-e690-4e16-9658-55541142f9a4",
        "product_id": "585196f6-abbc-4168-a37e-81b879b79a63"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/d268e87d-e690-4e16-9658-55541142f9a4"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/585196f6-abbc-4168-a37e-81b879b79a63"
          }
        }
      }
    },
    {
      "id": "35a655f3-9313-4eaf-8fdb-920d1c08c762",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00+00:00",
        "till": "1989-04-11T20:00:00+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "d268e87d-e690-4e16-9658-55541142f9a4",
        "product_id": "585196f6-abbc-4168-a37e-81b879b79a63"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/d268e87d-e690-4e16-9658-55541142f9a4"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/585196f6-abbc-4168-a37e-81b879b79a63"
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


> How to fetch a breakdown of all items in stock:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=32289baa-0734-4e37-8abc-137bfb7ab123&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5c48a89a-4a87-428b-89c6-f4311287db8b",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "1a0c1355-0f04-4299-900c-ef6442cceb02",
        "product_id": "b1d0c65e-888c-4f93-ad8e-cb3745103529"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/1a0c1355-0f04-4299-900c-ef6442cceb02"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/b1d0c65e-888c-4f93-ad8e-cb3745103529"
          }
        }
      }
    },
    {
      "id": "834fba7b-59df-4fa8-b063-b42bc7b5fccf",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "1a0c1355-0f04-4299-900c-ef6442cceb02",
        "product_id": "b1d0c65e-888c-4f93-ad8e-cb3745103529"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/1a0c1355-0f04-4299-900c-ef6442cceb02"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/b1d0c65e-888c-4f93-ad8e-cb3745103529"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=8429a122-e590-43b4-94d4-71e19dddcd0b&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a2ebaa6f-d52d-4e6c-8a4f-a8b7c8f5741b",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "20dc88b4-deb4-497d-ae89-897d3424ee16",
        "product_id": "fd0bbc5b-6d1c-4f40-a86b-c88c082af087"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/20dc88b4-deb4-497d-ae89-897d3424ee16"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/fd0bbc5b-6d1c-4f40-a86b-c88c082af087"
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







