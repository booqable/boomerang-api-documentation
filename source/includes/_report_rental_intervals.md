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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b3f69818-9729-4f83-a496-90575ccef8bb&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-000e223b-89ab-55b2-b89b-374efece7c46",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
          }
        }
      }
    },
    {
      "id": "virtual-e96f6f92-be6c-50d7-80af-8de4cc0cf191",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
          }
        }
      }
    },
    {
      "id": "virtual-a7336325-bf1f-59ef-bb5e-6ed4a8e3cc64",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
          }
        }
      }
    },
    {
      "id": "virtual-e31b95f3-da9a-51f1-956d-48c5be48059c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
          }
        }
      }
    },
    {
      "id": "virtual-45a519e3-a1da-53aa-821c-6ff65d0333e5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
          }
        }
      }
    },
    {
      "id": "virtual-590efba7-9238-5738-a3eb-10dde2054246",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
          }
        }
      }
    },
    {
      "id": "virtual-360db62c-5b27-58e4-ac9b-ba1c454c1f9e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
          }
        }
      }
    },
    {
      "id": "virtual-f53900a1-f31a-58fa-baeb-b2069f402897",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
          }
        }
      }
    },
    {
      "id": "virtual-fa533939-ac0e-5c8d-9a6c-a74951b1e5fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
          }
        }
      }
    },
    {
      "id": "virtual-5b965a23-3b44-5e77-b71e-a927c377575c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f69818-9729-4f83-a496-90575ccef8bb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f69818-9729-4f83-a496-90575ccef8bb"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T14:24:57Z`
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







