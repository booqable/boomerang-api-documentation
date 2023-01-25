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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-15+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c7c90dcd-eb33-41a1-9ffe-ed271d3424fa&filter%5Btill%5D=2023-01-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a1bd747d-570a-5ef8-8fb8-0bd3b9aa0498",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
          }
        }
      }
    },
    {
      "id": "virtual-d77ad1dd-ba51-5d8c-bfc3-3e2e596249ee",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
          }
        }
      }
    },
    {
      "id": "virtual-9b1d499c-90b1-509c-9046-bc3275f17129",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
          }
        }
      }
    },
    {
      "id": "virtual-781ace6f-60de-5da2-bbcb-29acde4a0f7c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
          }
        }
      }
    },
    {
      "id": "virtual-e98622db-95ee-5c43-b743-7bfcec97b828",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
          }
        }
      }
    },
    {
      "id": "virtual-4d084b70-c06e-575c-9722-24224320b08a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
          }
        }
      }
    },
    {
      "id": "virtual-1287df79-cc64-54f9-84f0-4c73052d910c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
          }
        }
      }
    },
    {
      "id": "virtual-660615e5-92c4-5fb3-a1c3-dade29035926",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
          }
        }
      }
    },
    {
      "id": "virtual-96a93b5f-9c5a-5096-9b54-ad9ed21b4034",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
          }
        }
      }
    },
    {
      "id": "virtual-a2c7f3a2-4630-5037-aa91-ada74c3046ca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7c90dcd-eb33-41a1-9ffe-ed271d3424fa"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-25T12:33:37Z`
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







