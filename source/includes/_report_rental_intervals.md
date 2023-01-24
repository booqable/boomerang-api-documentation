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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=9323d261-3844-4d18-a60e-b4038fba0fee&filter%5Btill%5D=2023-01-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-74970923-6b4c-5079-aeba-e704fb6d7e60",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
          }
        }
      }
    },
    {
      "id": "virtual-823787ef-c07e-5a57-ac6d-faae098edd25",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
          }
        }
      }
    },
    {
      "id": "virtual-667017b0-ab1c-5055-b3b5-de46d815ad29",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
          }
        }
      }
    },
    {
      "id": "virtual-03a3d6a7-3002-51ac-973e-7a40a7d59a72",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
          }
        }
      }
    },
    {
      "id": "virtual-27c22f15-5ad5-525b-be86-f6cf75775fb9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
          }
        }
      }
    },
    {
      "id": "virtual-8b0372a3-a9a1-5166-ace7-c77d0bc658ac",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
          }
        }
      }
    },
    {
      "id": "virtual-d3f9d5e3-c99e-5502-a63a-cc2d73d68df0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
          }
        }
      }
    },
    {
      "id": "virtual-d7a94505-872e-52fc-9f38-29c41cbd0585",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
          }
        }
      }
    },
    {
      "id": "virtual-c264ade5-f6fd-562a-813a-f7eda569f98c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
          }
        }
      }
    },
    {
      "id": "virtual-1532a71c-076e-5223-995d-bbc502791c28",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9323d261-3844-4d18-a60e-b4038fba0fee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9323d261-3844-4d18-a60e-b4038fba0fee"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:59:47Z`
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







