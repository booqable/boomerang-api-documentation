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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=cf7342a4-e289-442c-921e-e6873cb7d07a&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-4b4b4222-634f-5bf2-a769-6df7b3c20396",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
          }
        }
      }
    },
    {
      "id": "virtual-46abfc47-c0d9-5b57-8c17-4ff1feedef27",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
          }
        }
      }
    },
    {
      "id": "virtual-336afe5e-7a73-5f24-95d9-4e524b40af09",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
          }
        }
      }
    },
    {
      "id": "virtual-4a4937af-3cfe-5e86-a41f-71193dbc7b68",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
          }
        }
      }
    },
    {
      "id": "virtual-7a8ba43b-6312-5f24-b26e-30865220bdb9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
          }
        }
      }
    },
    {
      "id": "virtual-fbfd3f05-9bca-5b44-862e-c9736a67afb0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
          }
        }
      }
    },
    {
      "id": "virtual-5b9520a2-8bb7-5c6a-b947-a89a1b5a0328",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
          }
        }
      }
    },
    {
      "id": "virtual-f34cd956-ce26-5f4a-8767-36c734dc9bdf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
          }
        }
      }
    },
    {
      "id": "virtual-a69037a4-7827-5c7e-9637-6adceb4fe9c8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
          }
        }
      }
    },
    {
      "id": "virtual-87bbeec2-9acf-5673-911e-299b4253717a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf7342a4-e289-442c-921e-e6873cb7d07a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf7342a4-e289-442c-921e-e6873cb7d07a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:20:01Z`
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







