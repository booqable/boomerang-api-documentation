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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=7a59be05-1c4e-4d8b-a008-ce0bd386b932&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-51161d7b-7710-5fdb-8a70-53090e63e1f1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
          }
        }
      }
    },
    {
      "id": "virtual-f52666ef-9254-5944-94b3-d1bb329e6067",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
          }
        }
      }
    },
    {
      "id": "virtual-a3eba124-1c89-5a9c-b945-146163fb2c98",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
          }
        }
      }
    },
    {
      "id": "virtual-d7e79d22-d3f5-577a-9388-3ae345a401f8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
          }
        }
      }
    },
    {
      "id": "virtual-a4770055-8a44-55be-a768-1f4a58c0faf7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
          }
        }
      }
    },
    {
      "id": "virtual-593d0e19-ce26-5ce6-bb1b-c806305c6ad4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
          }
        }
      }
    },
    {
      "id": "virtual-b1b513f2-be0d-5441-8411-3c199651d60c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
          }
        }
      }
    },
    {
      "id": "virtual-a2d9d810-db34-5fb4-a6ae-49f32dcb7702",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
          }
        }
      }
    },
    {
      "id": "virtual-08b9e543-0645-59bb-9bce-8a79f092cd91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
          }
        }
      }
    },
    {
      "id": "virtual-9b5af2bf-7836-573a-beab-a900cb1ca9cb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a59be05-1c4e-4d8b-a008-ce0bd386b932"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a59be05-1c4e-4d8b-a008-ce0bd386b932"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T12:59:53Z`
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







