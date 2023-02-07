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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a06417d9-6b2f-447d-9db5-3df769af7bd6&filter%5Btill%5D=2023-02-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e3a27d07-18c2-547d-88e2-c872c76a22be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
          }
        }
      }
    },
    {
      "id": "virtual-816edd41-e824-50d6-95c5-d89c2474e23f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
          }
        }
      }
    },
    {
      "id": "virtual-e601a68a-4706-5026-a529-27a999ec4076",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
          }
        }
      }
    },
    {
      "id": "virtual-cfc4703c-0965-54aa-8865-bb32f0406b08",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
          }
        }
      }
    },
    {
      "id": "virtual-fff544fb-40c8-5f8b-9298-26585b4481af",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
          }
        }
      }
    },
    {
      "id": "virtual-8717c702-0199-5be0-91d7-daef3abd777a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
          }
        }
      }
    },
    {
      "id": "virtual-7b7e4c7e-7026-5db2-ad4d-503b742c501f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
          }
        }
      }
    },
    {
      "id": "virtual-92acd98c-562b-5103-b8f7-f1b628ed800b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
          }
        }
      }
    },
    {
      "id": "virtual-9e7b590d-0f2a-5eec-a426-ee326322cc26",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
          }
        }
      }
    },
    {
      "id": "virtual-7558cf8a-98e0-575f-9925-b514ce3756cf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a06417d9-6b2f-447d-9db5-3df769af7bd6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a06417d9-6b2f-447d-9db5-3df769af7bd6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T10:56:31Z`
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







