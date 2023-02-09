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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=5ccf442e-4c04-4df8-b0d3-6a53fb19ee20&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-d96d3062-6b87-56c9-8e70-7fff295e3b8a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
          }
        }
      }
    },
    {
      "id": "virtual-87ad8917-0a8c-5ffb-b693-59a1b60f0f92",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
          }
        }
      }
    },
    {
      "id": "virtual-cc7cfbd7-c488-5a63-90d7-0019cf8026a6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
          }
        }
      }
    },
    {
      "id": "virtual-e4c0674c-162e-5ab2-99ab-290b90eedda3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
          }
        }
      }
    },
    {
      "id": "virtual-4d44f43a-cd52-54d3-a2c9-0469f7f8a8c5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
          }
        }
      }
    },
    {
      "id": "virtual-8968aec2-7127-50b0-af0c-c363c8fd96c8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
          }
        }
      }
    },
    {
      "id": "virtual-8c9c720e-5bd6-5c2d-8dab-6384994a3c37",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
          }
        }
      }
    },
    {
      "id": "virtual-c6c3a653-107c-58f4-92cf-d8b080825968",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
          }
        }
      }
    },
    {
      "id": "virtual-4888e62c-1c05-5806-a23c-d8f11e4be670",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
          }
        }
      }
    },
    {
      "id": "virtual-5cd42123-d2f5-5ace-98d5-641c3455b46d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5ccf442e-4c04-4df8-b0d3-6a53fb19ee20"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T13:18:37Z`
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







