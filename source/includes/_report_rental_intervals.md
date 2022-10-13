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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0aa35f85-b48a-44ed-a7f0-3ab91cf988ee&filter%5Btill%5D=2022-10-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a2261efb-b9ec-58c8-adc1-c153a7b8633f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
          }
        }
      }
    },
    {
      "id": "virtual-d2ae8021-4cb0-596c-adda-165a5d82f367",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
          }
        }
      }
    },
    {
      "id": "virtual-ec627d03-1775-5030-9da0-94e7721d3b65",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
          }
        }
      }
    },
    {
      "id": "virtual-95ef48b6-4eda-5121-bade-527c9d003535",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
          }
        }
      }
    },
    {
      "id": "virtual-e070cf8d-465e-5e0e-a5ce-520c9d2dd477",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
          }
        }
      }
    },
    {
      "id": "virtual-f51f8f43-fee5-5d11-a117-41ccb86c661c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
          }
        }
      }
    },
    {
      "id": "virtual-16f25320-98b0-524a-9832-eefdf9dd00f1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
          }
        }
      }
    },
    {
      "id": "virtual-8fec1c7b-c8ef-593b-802a-5d152dbc890f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
          }
        }
      }
    },
    {
      "id": "virtual-bd063bea-8c53-57f8-84ae-4081d0cb12c2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
          }
        }
      }
    },
    {
      "id": "virtual-1eec1987-cc1b-5ddc-9239-ccd3f0fe2b6e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0aa35f85-b48a-44ed-a7f0-3ab91cf988ee"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T12:36:39Z`
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







