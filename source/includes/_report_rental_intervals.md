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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-13+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=d0d71007-0c83-4c60-b65d-f743543ad356&filter%5Btill%5D=2023-02-22+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a8980092-8afe-5fb4-ba58-bd17abda98ff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
          }
        }
      }
    },
    {
      "id": "virtual-46bdca20-164b-5182-9b8b-4a11de93b98b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
          }
        }
      }
    },
    {
      "id": "virtual-d2dd5ec2-44c2-5dba-a558-08db39264070",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
          }
        }
      }
    },
    {
      "id": "virtual-c8377a30-cbb3-5a17-855c-e139e1c96c92",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
          }
        }
      }
    },
    {
      "id": "virtual-06595a14-8fb6-500b-8690-cd1223c05d91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
          }
        }
      }
    },
    {
      "id": "virtual-e8c9e8e6-5faa-5df6-b1d4-195ca6efb50b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
          }
        }
      }
    },
    {
      "id": "virtual-cd60fb47-e60e-578f-b3c5-ace7303f9d6e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
          }
        }
      }
    },
    {
      "id": "virtual-ef444300-6ec8-5066-a0f6-59306a06cb5a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
          }
        }
      }
    },
    {
      "id": "virtual-916b2133-2681-50c5-bc74-11b3a6a54519",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
          }
        }
      }
    },
    {
      "id": "virtual-db88f243-e17a-57a1-ae09-61efe8087de3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d0d71007-0c83-4c60-b65d-f743543ad356"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d0d71007-0c83-4c60-b65d-f743543ad356"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T13:49:21Z`
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







