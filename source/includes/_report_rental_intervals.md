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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0a8b9b3d-5372-4b23-8d08-b61db5abc0b2&filter%5Btill%5D=2023-02-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-07823b86-8b90-518e-903f-48ad4a3bb5dc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
          }
        }
      }
    },
    {
      "id": "virtual-8cf7513d-23ca-5010-9fe9-957b18801fed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
          }
        }
      }
    },
    {
      "id": "virtual-1537bcf7-8163-5890-b3bf-587010c3f762",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
          }
        }
      }
    },
    {
      "id": "virtual-9b4e89f4-1817-5de6-82f6-48d60a32bb1d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
          }
        }
      }
    },
    {
      "id": "virtual-d0c68d0a-3ad9-5b04-be0d-d045ff727fa3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
          }
        }
      }
    },
    {
      "id": "virtual-46ea101b-6e3b-5141-a81c-fc4f8a840d5a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
          }
        }
      }
    },
    {
      "id": "virtual-95e74ecd-19dc-505f-9a9c-c4b5114e0ccb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
          }
        }
      }
    },
    {
      "id": "virtual-a1e1a789-9c2f-5a32-9ec6-1dedd81b6792",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
          }
        }
      }
    },
    {
      "id": "virtual-6fbbd7f6-a57a-57fc-8182-dd29dfa48328",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
          }
        }
      }
    },
    {
      "id": "virtual-2cfaf674-ba2f-5228-a991-a46b63b8a0b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0a8b9b3d-5372-4b23-8d08-b61db5abc0b2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T10:34:36Z`
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







