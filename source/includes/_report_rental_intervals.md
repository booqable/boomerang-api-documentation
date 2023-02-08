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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=1814e142-26a3-4e52-9781-6dc03c9aea78&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-01611c17-479e-541b-a4a6-cb6dac28eb16",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
          }
        }
      }
    },
    {
      "id": "virtual-dfb8a3db-4eb1-54bb-9e61-3a1c508cdc16",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
          }
        }
      }
    },
    {
      "id": "virtual-16223e0e-135e-53a9-aa3b-47c0e4d6dd1f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
          }
        }
      }
    },
    {
      "id": "virtual-a4697dfe-9ffc-5288-9059-d88243573297",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
          }
        }
      }
    },
    {
      "id": "virtual-2e01861b-ddde-5cd6-a2ae-d0ce4126b9b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
          }
        }
      }
    },
    {
      "id": "virtual-9cb6fffa-6361-5dc2-8306-4eb25ab48f43",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
          }
        }
      }
    },
    {
      "id": "virtual-771f5de1-1e25-5fc2-9721-a00f4dbbc3c9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
          }
        }
      }
    },
    {
      "id": "virtual-b88b84e2-3517-57df-9eee-f429e50975bd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
          }
        }
      }
    },
    {
      "id": "virtual-ba1546d2-3d6f-5ad9-946b-89d94c08e4b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
          }
        }
      }
    },
    {
      "id": "virtual-0a5b005e-165c-5930-8d2b-55b74cd99a31",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1814e142-26a3-4e52-9781-6dc03c9aea78"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1814e142-26a3-4e52-9781-6dc03c9aea78"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:57:58Z`
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







