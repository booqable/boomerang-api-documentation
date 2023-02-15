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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-05+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e84d53fa-3fac-484e-ae4e-c0b394d32306&filter%5Btill%5D=2023-02-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-19f14cdd-6152-5e31-917e-a4d698802a48",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
          }
        }
      }
    },
    {
      "id": "virtual-0dd49bfc-4e42-55ee-b733-811652c2c1a0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
          }
        }
      }
    },
    {
      "id": "virtual-0efc217a-c7ac-5d57-8bae-3eded3c702f1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
          }
        }
      }
    },
    {
      "id": "virtual-87490a88-b1eb-52a6-a07d-3bd8da9c7816",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
          }
        }
      }
    },
    {
      "id": "virtual-5b30a5bc-9eea-5f67-9d01-c2d36ccae451",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
          }
        }
      }
    },
    {
      "id": "virtual-4d3a58a0-304d-5414-8c94-50e9fb1ec801",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
          }
        }
      }
    },
    {
      "id": "virtual-3e96e655-3c20-56a9-a478-f989eb5a0f7a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
          }
        }
      }
    },
    {
      "id": "virtual-53c582b8-a5b5-51cb-a3b5-fe76deec1043",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
          }
        }
      }
    },
    {
      "id": "virtual-8ae2880d-7ef9-5836-bba7-e8bdfe0d882f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
          }
        }
      }
    },
    {
      "id": "virtual-53569ef2-f8c5-57b0-a7e7-a3f2824b3c88",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e84d53fa-3fac-484e-ae4e-c0b394d32306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e84d53fa-3fac-484e-ae4e-c0b394d32306"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-15T13:21:01Z`
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







