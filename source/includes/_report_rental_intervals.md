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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3&filter%5Btill%5D=2023-01-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-2eb469be-78bb-50fc-8e4e-30a0d5b9a754",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
          }
        }
      }
    },
    {
      "id": "virtual-7fbe305f-c2ea-5208-a80d-cb1c50443ac7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
          }
        }
      }
    },
    {
      "id": "virtual-af124322-0436-5d2a-b903-5f425d2287e7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
          }
        }
      }
    },
    {
      "id": "virtual-9590de76-4599-5ca7-82cf-b546f91ed713",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
          }
        }
      }
    },
    {
      "id": "virtual-af9ef923-055d-5f00-8b48-2c72478fb885",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
          }
        }
      }
    },
    {
      "id": "virtual-23d6f1bd-6c02-507d-998b-33cda10a861a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
          }
        }
      }
    },
    {
      "id": "virtual-55bca6ae-7cee-5476-ae2b-b88e0966d104",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
          }
        }
      }
    },
    {
      "id": "virtual-11c225fc-b69b-595b-b618-94191fdf47de",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
          }
        }
      }
    },
    {
      "id": "virtual-37c029a6-79ce-5808-93f6-281de0ec867a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
          }
        }
      }
    },
    {
      "id": "virtual-3e4a202a-caa7-5f75-b719-1cfa638f2bb1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c42aba6a-3b98-4a49-8ef8-8ca2a7d359e3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T16:30:48Z`
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







