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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-22+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=66bf8e77-6e49-406b-8946-8827a214e8ee&filter%5Btill%5D=2023-01-31+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-89d5270c-3d56-5232-a35e-b6ce0f94fcac",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
          }
        }
      }
    },
    {
      "id": "virtual-d5833e51-00a7-520b-bba7-419b1756f407",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
          }
        }
      }
    },
    {
      "id": "virtual-c77b8d9a-977a-5166-a55f-dad33d31908d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
          }
        }
      }
    },
    {
      "id": "virtual-5f666f12-9f73-5f03-8a4e-795e8a25ec6e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
          }
        }
      }
    },
    {
      "id": "virtual-6ed3654e-dda6-54af-a7c3-e2bee0587ce8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
          }
        }
      }
    },
    {
      "id": "virtual-ecd7b07a-5905-56cf-9e7f-e4087f485ba1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
          }
        }
      }
    },
    {
      "id": "virtual-e9b0894c-fa3a-565b-912f-abbfb0ada1a3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
          }
        }
      }
    },
    {
      "id": "virtual-41acefd8-8356-545b-8ef2-638438327fd4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
          }
        }
      }
    },
    {
      "id": "virtual-31e85803-61eb-5dd6-81fc-98fc94f97a92",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
          }
        }
      }
    },
    {
      "id": "virtual-5cd8d421-e778-5634-8dd9-b51912e892c8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "66bf8e77-6e49-406b-8946-8827a214e8ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/66bf8e77-6e49-406b-8946-8827a214e8ee"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T12:58:46Z`
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







