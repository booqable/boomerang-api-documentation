# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=309ace87-0248-435a-b1c8-9af545d627c3&filter%5Btill%5D=2022-07-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ee1dbaf3-6baf-5089-9b74-3043eca77160",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    },
    {
      "id": "virtual-ee2fac71-86f6-5361-8bb9-c682f93f5e27",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    },
    {
      "id": "virtual-7da965c8-0581-5120-aba5-79102ff65a31",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    },
    {
      "id": "virtual-b8994e9a-13c6-50cb-babd-045e0d07e104",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    },
    {
      "id": "virtual-16b5ee54-d7c6-5a03-af7c-58c144eb3ed6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    },
    {
      "id": "virtual-cf2b52be-a779-5598-8686-7d64f7ea9098",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    },
    {
      "id": "virtual-14b3f2dc-e2dc-5f60-9ed3-dc0c193d1164",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    },
    {
      "id": "virtual-184fbce1-84ff-5a79-a938-524a7e59107b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    },
    {
      "id": "virtual-7e22de8d-73d8-53f6-a1e8-27a1e5494c57",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    },
    {
      "id": "virtual-4662f9dc-646c-5280-806b-5b908620e62d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "309ace87-0248-435a-b1c8-9af545d627c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/309ace87-0248-435a-b1c8-9af545d627c3"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/report_rental_intervals`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:33:21Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







