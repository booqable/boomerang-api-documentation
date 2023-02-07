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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2d5889b7-c962-42b8-8b6c-7c4b386f6ffc&filter%5Btill%5D=2023-02-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-4951458d-9683-53ba-8f2c-a1c68bedd7e8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
          }
        }
      }
    },
    {
      "id": "virtual-f93f54c1-accb-5b38-a3fd-88425771573e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
          }
        }
      }
    },
    {
      "id": "virtual-7e6a49f2-acc8-53e2-a803-4195ff95064b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
          }
        }
      }
    },
    {
      "id": "virtual-61f5bb4b-eedb-5073-b080-707fd08fac94",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
          }
        }
      }
    },
    {
      "id": "virtual-3db22857-8f87-5a24-a47e-3875a6a72c62",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
          }
        }
      }
    },
    {
      "id": "virtual-89627f8d-6308-5ea0-87cf-4967ee3f0889",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
          }
        }
      }
    },
    {
      "id": "virtual-e64d0d7b-2e3b-555f-ae50-006040d1ec11",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
          }
        }
      }
    },
    {
      "id": "virtual-9337f0d2-a9ed-5326-ab8d-b1cc9fb6090c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
          }
        }
      }
    },
    {
      "id": "virtual-cf2b655d-72ad-5298-b9f3-a43bbb9ff58e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
          }
        }
      }
    },
    {
      "id": "virtual-c9330e6c-0400-5a49-bb07-0176287d1b81",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2d5889b7-c962-42b8-8b6c-7c4b386f6ffc"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T15:17:17Z`
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







