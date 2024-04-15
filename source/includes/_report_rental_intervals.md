# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-04-05+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc&filter%5Btill%5D=2024-04-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bb0e9d67-269f-4d7c-be8b-d24b765f7db9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
          }
        }
      }
    },
    {
      "id": "b90e65e1-8a95-477f-ba25-3ba995aa0287",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
          }
        }
      }
    },
    {
      "id": "c2529c81-ba4f-46c9-b3a7-7b15e42c3b08",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
          }
        }
      }
    },
    {
      "id": "d0a6385c-3fcb-40cf-be58-6fc0e38cb751",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
          }
        }
      }
    },
    {
      "id": "92e2fe61-9482-488b-9493-742a6d7dd664",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
          }
        }
      }
    },
    {
      "id": "e2575529-bcb8-46ca-b505-c708da8dd4a5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
          }
        }
      }
    },
    {
      "id": "4ef1b915-8428-416b-a5a1-5bcef2850d1e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
          }
        }
      }
    },
    {
      "id": "1074506a-68a8-4442-b700-d24e9f4a296e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
          }
        }
      }
    },
    {
      "id": "487473db-23fe-4f26-a657-783b99af8309",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
          }
        }
      }
    },
    {
      "id": "e8db880a-7fa2-4d27-b78c-3b5e534dbbd4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5b32a3a6-68d8-4e9e-b4a2-c6a27bb3a8bc"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







