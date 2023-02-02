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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=7b06cb67-1052-478f-9f9c-b92bfd353083&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-1833fbbe-d4ac-5a31-962a-10530bc5ac09",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
          }
        }
      }
    },
    {
      "id": "virtual-20f0af57-7ce3-54b0-9194-bb20cd670af3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
          }
        }
      }
    },
    {
      "id": "virtual-82804be7-c362-5e4e-a7e6-d2fbc2481d63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
          }
        }
      }
    },
    {
      "id": "virtual-2b261097-e449-5c0b-af89-d5f1ab9923de",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
          }
        }
      }
    },
    {
      "id": "virtual-39bf700a-f2ec-5436-83ba-377267face41",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
          }
        }
      }
    },
    {
      "id": "virtual-ef9e5091-48a0-52a5-8191-76ca14afb289",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
          }
        }
      }
    },
    {
      "id": "virtual-a3fbf9fe-5fc6-50a1-aefe-ea22a82fd633",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
          }
        }
      }
    },
    {
      "id": "virtual-e86ff875-54ca-5900-ba35-d8bcb1c745da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
          }
        }
      }
    },
    {
      "id": "virtual-9324fc21-e7ea-5af2-8e3f-6c5f214719da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
          }
        }
      }
    },
    {
      "id": "virtual-66b65f23-cc1c-58d8-aa11-774daa18dff1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7b06cb67-1052-478f-9f9c-b92bfd353083"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7b06cb67-1052-478f-9f9c-b92bfd353083"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:57:52Z`
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







