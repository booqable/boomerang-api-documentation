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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-22+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=388af14f-175b-4b0c-887c-74a813101335&filter%5Btill%5D=2023-01-31+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-34f3908d-5ce2-563e-b9d7-a1bbfa28058a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
          }
        }
      }
    },
    {
      "id": "virtual-6f4ade79-7e3c-5d22-b596-84275c3ae922",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
          }
        }
      }
    },
    {
      "id": "virtual-5284ed0a-b540-5d08-89e2-6e0089f8b319",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
          }
        }
      }
    },
    {
      "id": "virtual-36dc4b60-f516-5ab5-864b-51ccce67169c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
          }
        }
      }
    },
    {
      "id": "virtual-14f244f4-09e5-5898-a1e1-e60af46628ce",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
          }
        }
      }
    },
    {
      "id": "virtual-3eee92f2-a111-5a08-a213-c7aa80b6720f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
          }
        }
      }
    },
    {
      "id": "virtual-eecf2972-c7ea-5a41-9132-13986ed3ade8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
          }
        }
      }
    },
    {
      "id": "virtual-4cab097a-cc6f-53bc-8e33-4074ce51e344",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
          }
        }
      }
    },
    {
      "id": "virtual-fe8467c9-8878-5ccf-b2a5-f50101c2e079",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
          }
        }
      }
    },
    {
      "id": "virtual-f2d865c1-bc2f-5752-ab19-37436adf5db4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "388af14f-175b-4b0c-887c-74a813101335"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/388af14f-175b-4b0c-887c-74a813101335"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T13:17:47Z`
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







