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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4&filter%5Btill%5D=2023-02-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c17ae530-617d-544f-8313-94f67278029c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
          }
        }
      }
    },
    {
      "id": "virtual-4bc53cb4-61b1-5cf2-87ca-2d8bba03e282",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
          }
        }
      }
    },
    {
      "id": "virtual-b872e3cc-988d-584b-bdda-cca0663de043",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
          }
        }
      }
    },
    {
      "id": "virtual-4dd6b140-a72e-52ed-a242-243d76b4f8eb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
          }
        }
      }
    },
    {
      "id": "virtual-0a31a3c6-3a86-5c5c-ba18-4c97d06f9494",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
          }
        }
      }
    },
    {
      "id": "virtual-50f3a380-0dac-5ca3-894d-6423a3c8f009",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
          }
        }
      }
    },
    {
      "id": "virtual-ce79510b-dd59-5a6f-aab4-ab9591fd9058",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
          }
        }
      }
    },
    {
      "id": "virtual-7f2b5f7c-a26b-5a4e-882e-ae8c5dae2179",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
          }
        }
      }
    },
    {
      "id": "virtual-87b249b5-7e04-5ef1-bf51-f69c0aa48e08",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
          }
        }
      }
    },
    {
      "id": "virtual-3596021b-f25a-5ae2-8252-4a5d45a8ef19",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4b7bfe8-b678-4be7-9e17-a7ce76ad5df4"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T08:05:40Z`
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







