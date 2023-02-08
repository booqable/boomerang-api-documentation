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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a7d7351a-6869-4057-aaea-0cf9d34bfe75&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-20ff7053-9cc1-528a-813b-18f29daf2d3a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
          }
        }
      }
    },
    {
      "id": "virtual-903bfa64-241e-5508-a844-b067b5962adc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
          }
        }
      }
    },
    {
      "id": "virtual-5e30f394-8efe-5236-bb0b-9a84b4d04784",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
          }
        }
      }
    },
    {
      "id": "virtual-7b47551d-91b4-5c03-bbec-b4ac6e15fab2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
          }
        }
      }
    },
    {
      "id": "virtual-b1cdc3a8-37d1-5fac-b0ad-d1bf156e515d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
          }
        }
      }
    },
    {
      "id": "virtual-fe3a38f7-8897-5642-b06c-5afba53db63c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
          }
        }
      }
    },
    {
      "id": "virtual-a33d21cd-7268-5cce-a25b-1e20f2e53653",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
          }
        }
      }
    },
    {
      "id": "virtual-a7b6969a-cba1-5e8c-9cb2-6cf017a6e438",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
          }
        }
      }
    },
    {
      "id": "virtual-37065230-00d4-5c38-bb38-c27f8b527cb0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
          }
        }
      }
    },
    {
      "id": "virtual-53966638-499d-5b94-a092-155ff453c36d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7d7351a-6869-4057-aaea-0cf9d34bfe75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7d7351a-6869-4057-aaea-0cf9d34bfe75"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T15:42:27Z`
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







