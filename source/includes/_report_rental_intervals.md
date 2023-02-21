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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a7b722ac-e893-4db1-874b-2e4610642081&filter%5Btill%5D=2023-02-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-1892506c-0d92-5016-b6e8-15af496b39eb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
          }
        }
      }
    },
    {
      "id": "virtual-f9d7422e-7957-5363-ae06-6b9b7750ba3c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
          }
        }
      }
    },
    {
      "id": "virtual-599ce182-f9a5-501f-bc12-f5607d03b7c1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
          }
        }
      }
    },
    {
      "id": "virtual-03e11f61-c72c-5cbf-99e4-de33b785401b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
          }
        }
      }
    },
    {
      "id": "virtual-b15f3f21-167a-55e1-8941-8ef7afd0e718",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
          }
        }
      }
    },
    {
      "id": "virtual-a4df07fd-6d26-5248-9278-f3b6ddda6a40",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
          }
        }
      }
    },
    {
      "id": "virtual-73a6261c-18d7-50b7-b357-f5b53a4f3f0b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
          }
        }
      }
    },
    {
      "id": "virtual-95927bb6-6058-5d13-aff8-0ca2e9c294d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
          }
        }
      }
    },
    {
      "id": "virtual-cd380564-9df2-5010-9cd7-54c917a4d1aa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
          }
        }
      }
    },
    {
      "id": "virtual-dd310142-86fd-5153-89d8-2d63d33d8d05",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a7b722ac-e893-4db1-874b-2e4610642081"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a7b722ac-e893-4db1-874b-2e4610642081"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T10:55:23Z`
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







