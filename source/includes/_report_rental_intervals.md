# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=333dcf12-d211-43f6-8170-69dd7608bfb1&filter%5Btill%5D=2022-11-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0c86b561-62c9-520d-a2e8-d48f201902d4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
          }
        }
      }
    },
    {
      "id": "virtual-3de6cbba-7de3-5f88-b1ef-9ea9e14b1218",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
          }
        }
      }
    },
    {
      "id": "virtual-0e2329b0-1ffd-5a88-b1db-bf9c7b03bee8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
          }
        }
      }
    },
    {
      "id": "virtual-5071eb66-3ebe-5d17-bded-2f13be2fde23",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
          }
        }
      }
    },
    {
      "id": "virtual-588b3447-9473-5e00-9448-a06a823a7cea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
          }
        }
      }
    },
    {
      "id": "virtual-80f3b869-3387-5342-bfb8-59b108780ba9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
          }
        }
      }
    },
    {
      "id": "virtual-02146c40-adea-5427-8378-e9fd4e2f5c41",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
          }
        }
      }
    },
    {
      "id": "virtual-375a2c9c-f8e0-56d3-812e-2aac94e9d7ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
          }
        }
      }
    },
    {
      "id": "virtual-3249ed10-0b8c-5200-9fa5-6de5b73e8211",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
          }
        }
      }
    },
    {
      "id": "virtual-d22d8ebc-51f0-5065-97cb-aed9d9a0e680",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "333dcf12-d211-43f6-8170-69dd7608bfb1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/333dcf12-d211-43f6-8170-69dd7608bfb1"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T17:40:55Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







