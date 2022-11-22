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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2757f6df-2723-4be8-be85-fd062b006e84&filter%5Btill%5D=2022-11-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0ce0c2a4-c9fd-5845-8f6d-3e3d8697688b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
          }
        }
      }
    },
    {
      "id": "virtual-b3a57511-cdc1-53b2-9024-e02194ff47a7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
          }
        }
      }
    },
    {
      "id": "virtual-1b46eaf6-4646-52ae-bea8-d31a17fb7d98",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
          }
        }
      }
    },
    {
      "id": "virtual-4e7ec7aa-bf36-5aef-ba17-a86afa423170",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
          }
        }
      }
    },
    {
      "id": "virtual-3403f843-56d4-54a3-b1f4-ef1cc60c7d76",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
          }
        }
      }
    },
    {
      "id": "virtual-44e0a05d-3078-5275-a1a6-e123037a0cb5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
          }
        }
      }
    },
    {
      "id": "virtual-85918d47-04e7-5fa8-a3b9-db6191268392",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
          }
        }
      }
    },
    {
      "id": "virtual-f36714ee-7af0-5c85-833d-bdc26fda3947",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
          }
        }
      }
    },
    {
      "id": "virtual-be657cb9-1c99-5661-9d48-9cfc8fb52fc6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
          }
        }
      }
    },
    {
      "id": "virtual-3746b2e1-dd65-5f09-9808-989d4ca8ba43",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2757f6df-2723-4be8-be85-fd062b006e84"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2757f6df-2723-4be8-be85-fd062b006e84"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:33:13Z`
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







