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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0d25f371-82b7-483d-9487-2fc691f16d88&filter%5Btill%5D=2023-03-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-38913866-721e-5b5a-90a5-02940bb3af45",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
          }
        }
      }
    },
    {
      "id": "virtual-35959dc0-c408-5dda-8187-baf147d36589",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
          }
        }
      }
    },
    {
      "id": "virtual-7daacd50-af66-5588-88ba-454b45e3c795",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
          }
        }
      }
    },
    {
      "id": "virtual-4eb8e66e-adf8-5530-a7d7-7da8937bff0d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
          }
        }
      }
    },
    {
      "id": "virtual-ce6d0eb1-4bf1-57f6-b61b-55cf838dee1a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
          }
        }
      }
    },
    {
      "id": "virtual-239906dd-03ba-5436-a8a9-187ec41b3c4e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
          }
        }
      }
    },
    {
      "id": "virtual-2785a173-1b88-5bbe-b731-9d7ce5554567",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
          }
        }
      }
    },
    {
      "id": "virtual-84ab3919-13fc-5b2c-b3e8-938d1f712b50",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
          }
        }
      }
    },
    {
      "id": "virtual-985dbf1e-fbb5-516b-b7a7-90f8b541947b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
          }
        }
      }
    },
    {
      "id": "virtual-6de8d237-9160-58bb-b893-5f0922585dac",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0d25f371-82b7-483d-9487-2fc691f16d88"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0d25f371-82b7-483d-9487-2fc691f16d88"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T08:26:43Z`
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







