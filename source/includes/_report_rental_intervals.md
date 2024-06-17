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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-06-07+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e96ee3f5-1b5e-46f1-9975-f84a7004e709&filter%5Btill%5D=2024-06-16+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d17d206c-7079-4bcd-91db-a81dc1d46964",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
          }
        }
      }
    },
    {
      "id": "bb710204-bc4b-4d03-b9ca-44bc5346e5d0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
          }
        }
      }
    },
    {
      "id": "469d16cf-6a6a-427d-b6c9-85b83bb5a022",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
          }
        }
      }
    },
    {
      "id": "8bcce436-00f7-4dc8-ac83-20f82275a2d0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
          }
        }
      }
    },
    {
      "id": "e07af4b0-2b96-4b64-9302-7a118ce97d5a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
          }
        }
      }
    },
    {
      "id": "918aee80-a221-45b6-bbe4-036349fe67d7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
          }
        }
      }
    },
    {
      "id": "f13d349b-daf5-4dc4-b2cf-8894008be13f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
          }
        }
      }
    },
    {
      "id": "ea4438b8-f40a-41f8-9589-b5e3e652bd63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
          }
        }
      }
    },
    {
      "id": "0c77f7c3-2120-4cdd-a902-5d2e054b7527",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
          }
        }
      }
    },
    {
      "id": "6ce5649c-5bd6-4fc0-8529-7a3cacee6efd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e96ee3f5-1b5e-46f1-9975-f84a7004e709"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e96ee3f5-1b5e-46f1-9975-f84a7004e709"
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







