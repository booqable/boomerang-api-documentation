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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a3814022-e2bf-41b2-b110-8a1eb4a8b2d4&filter%5Btill%5D=2023-02-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-685f3dba-720f-5642-b4cb-37272869462f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
          }
        }
      }
    },
    {
      "id": "virtual-2ba6fabb-9a26-52d5-987c-8746a4df62c9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
          }
        }
      }
    },
    {
      "id": "virtual-82aad4a1-2b9e-56a6-9359-32c4a3ce2106",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
          }
        }
      }
    },
    {
      "id": "virtual-85e22fc0-1854-5ebd-b764-2891fd61dfa8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
          }
        }
      }
    },
    {
      "id": "virtual-46bc6d05-6391-5ff9-b83b-379a779b725a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
          }
        }
      }
    },
    {
      "id": "virtual-9c04e4c3-ca11-5e49-9f03-10a4e7d1c098",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
          }
        }
      }
    },
    {
      "id": "virtual-1755ae18-e10a-5d96-921c-e50adee1070a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
          }
        }
      }
    },
    {
      "id": "virtual-2f6d157b-7ca7-541e-8fa6-82afdc214ad7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
          }
        }
      }
    },
    {
      "id": "virtual-89110f00-667e-5c7c-9fc0-85a8358e4bf8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
          }
        }
      }
    },
    {
      "id": "virtual-c6012ebb-2a83-5e1c-8b09-e35547eebcce",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3814022-e2bf-41b2-b110-8a1eb4a8b2d4"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T08:41:11Z`
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







