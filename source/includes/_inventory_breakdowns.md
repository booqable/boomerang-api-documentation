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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=658c45fd-e4ce-4913-a691-e2af4833a4d4&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
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
        "location_id": "66150472-2871-454c-b600-1959f00d05cd",
        "product_id": "ba58d814-2485-44db-a6cd-0ac01a80181e"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/66150472-2871-454c-b600-1959f00d05cd"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ba58d814-2485-44db-a6cd-0ac01a80181e"
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
        "location_id": "66150472-2871-454c-b600-1959f00d05cd",
        "product_id": "ba58d814-2485-44db-a6cd-0ac01a80181e"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/66150472-2871-454c-b600-1959f00d05cd"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ba58d814-2485-44db-a6cd-0ac01a80181e"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=3d208e5e-bcb4-4520-967c-b909e8de07cb&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
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
        "location_id": "cb22602d-cb0a-4cda-8159-fc40d93e7996",
        "product_id": "6ba0dad0-2be7-4df6-a0c7-869535f74d56"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/cb22602d-cb0a-4cda-8159-fc40d93e7996"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/6ba0dad0-2be7-4df6-a0c7-869535f74d56"
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
        "location_id": "cb22602d-cb0a-4cda-8159-fc40d93e7996",
        "product_id": "6ba0dad0-2be7-4df6-a0c7-869535f74d56"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/cb22602d-cb0a-4cda-8159-fc40d93e7996"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/6ba0dad0-2be7-4df6-a0c7-869535f74d56"
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
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=22f89785-c73f-41c5-8f7e-6aa2d259e584&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
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
        "location_id": "8a190e7c-f246-4355-a31c-9afd770c8434",
        "product_id": "ec317f8c-7133-498f-8d32-e8bdb0a35fdc"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/8a190e7c-f246-4355-a31c-9afd770c8434"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ec317f8c-7133-498f-8d32-e8bdb0a35fdc"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T13:57:26Z`
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







