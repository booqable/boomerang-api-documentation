# Inventory breakdowns

Fetch quantitive information about product inventory compared to the now, broken down by:

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
`total` | **Integer**<br>The total amount of stock for product and location
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=7f495550-ba8a-487e-b332-702d9bc38ba3&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Btotal%5D%5B%5D=sum' \
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
        "total": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "f4e577f5-ec6c-45ac-bb01-48b2e8aedbbd",
        "product_id": "5d5e5aba-f891-46e7-a4a3-65b0ce744d8e"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/f4e577f5-ec6c-45ac-bb01-48b2e8aedbbd"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/5d5e5aba-f891-46e7-a4a3-65b0ce744d8e"
          }
        }
      }
    },
    {
      "id": "virtual-88ccf45a-fc35-5bc1-91ac-feef23a6d5e6",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00+00:00",
        "total": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "f4e577f5-ec6c-45ac-bb01-48b2e8aedbbd",
        "product_id": "5d5e5aba-f891-46e7-a4a3-65b0ce744d8e"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/f4e577f5-ec6c-45ac-bb01-48b2e8aedbbd"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/5d5e5aba-f891-46e7-a4a3-65b0ce744d8e"
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
      "total": {
        "sum": 105
      }
    }
  }
}
```


> How to fetch a breakdown of all expected items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=cd133d29-5c66-43b3-a68f-365402c63c17&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Btotal%5D%5B%5D=sum' \
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
        "total": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "c8f608b5-860e-46cb-b580-286b0316b699",
        "product_id": "584bd50f-3807-4923-93b4-49c275933e26"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/c8f608b5-860e-46cb-b580-286b0316b699"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/584bd50f-3807-4923-93b4-49c275933e26"
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
        "total": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "c8f608b5-860e-46cb-b580-286b0316b699",
        "product_id": "584bd50f-3807-4923-93b4-49c275933e26"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/c8f608b5-860e-46cb-b580-286b0316b699"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/584bd50f-3807-4923-93b4-49c275933e26"
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
      "total": {
        "sum": 17
      }
    }
  }
}
```


> How to fetch a breakdown of all expired items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=d7c15537-7221-4733-a28b-832ed67adb7f&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Btotal%5D%5B%5D=sum' \
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
        "total": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "e0bfff2b-eb15-4acc-a6d6-45729c685e50",
        "product_id": "0fa04f1b-d0b9-4c27-9c35-d28990b38011"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/e0bfff2b-eb15-4acc-a6d6-45729c685e50"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/0fa04f1b-d0b9-4c27-9c35-d28990b38011"
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
      "total": {
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-10T23:44:40Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`location_id` | **Uuid**<br>`eq`
`product_id` | **Uuid**<br>`eq`
`product_group_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`status` | **Array**<br>`sum`
`inventory_breakdown_type` | **Array**<br>`sum`
`total` | **Array**<br>`sum`, `count`
`started` | **Array**<br>`sum`


### Includes

This request accepts the following includes:

`location`


`product` => 
`photo`







