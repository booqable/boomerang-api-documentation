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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-16+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=1be397ad-e3ed-4431-874b-060ddd7dfa88&filter%5Btill%5D=2023-01-25+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-4b562f9e-7a03-5a25-bf3b-9963d7636f94",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
          }
        }
      }
    },
    {
      "id": "virtual-69fb8dbf-b2f0-5fbd-8bad-34df0222c7c4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
          }
        }
      }
    },
    {
      "id": "virtual-69d4e1ca-6871-53a4-ba00-d82fde8269ba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
          }
        }
      }
    },
    {
      "id": "virtual-2ca29a3e-6083-52c1-a793-2df6709db207",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
          }
        }
      }
    },
    {
      "id": "virtual-2e2a2b0e-a28d-5c9e-8b68-59364ffed20b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
          }
        }
      }
    },
    {
      "id": "virtual-2c05f50c-a4a6-53ba-8a19-f353bac05a62",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
          }
        }
      }
    },
    {
      "id": "virtual-44d6a911-4bae-568a-8f9c-ee61fa6616e8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
          }
        }
      }
    },
    {
      "id": "virtual-69199357-c313-56c9-993c-ef62156505e4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
          }
        }
      }
    },
    {
      "id": "virtual-23cbc83b-5506-5241-bb33-27bf9cd1c905",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
          }
        }
      }
    },
    {
      "id": "virtual-c1e75850-7a29-5a56-96eb-d80609a807f8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1be397ad-e3ed-4431-874b-060ddd7dfa88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1be397ad-e3ed-4431-874b-060ddd7dfa88"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T08:07:51Z`
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







