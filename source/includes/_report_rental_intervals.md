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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-07+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=d07e3653-e1ca-4852-801b-8a3bd0bc4190&filter%5Btill%5D=2022-11-16+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b5d0ccd9-f116-5010-99c1-7b2c24e305d4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
          }
        }
      }
    },
    {
      "id": "virtual-0a6b68c2-dab2-582b-b2e6-718bb0eda885",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
          }
        }
      }
    },
    {
      "id": "virtual-266f46b2-88df-5310-9e5a-3615a9d14f6f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
          }
        }
      }
    },
    {
      "id": "virtual-7066d0ef-316f-5a49-bcc7-a75734da94ba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
          }
        }
      }
    },
    {
      "id": "virtual-b2c1c6aa-0db0-5e10-bf45-42691c62ced5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
          }
        }
      }
    },
    {
      "id": "virtual-7aa729ea-d7bf-5ecf-8252-059d35b6a0a8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
          }
        }
      }
    },
    {
      "id": "virtual-2638353c-cf9d-5cb0-81c3-b5bc96a9d35e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
          }
        }
      }
    },
    {
      "id": "virtual-f4b3fa80-73b9-5d20-97f5-21c909986db1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
          }
        }
      }
    },
    {
      "id": "virtual-8449406e-299a-5646-979f-4fb4122051e4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
          }
        }
      }
    },
    {
      "id": "virtual-887cde0f-f6bd-5734-9b7c-dbeff896fe0d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d07e3653-e1ca-4852-801b-8a3bd0bc4190"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d07e3653-e1ca-4852-801b-8a3bd0bc4190"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-17T10:15:41Z`
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







