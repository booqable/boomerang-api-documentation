# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-09+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c&filter%5Btill%5D=2022-07-18+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b9faa902-ab7e-5138-bbba-d44e0cc23e22",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
          }
        }
      }
    },
    {
      "id": "virtual-2a4fbee1-78ea-5be2-94da-8be14c0ff7ee",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
          }
        }
      }
    },
    {
      "id": "virtual-1e9a1426-5bb1-537c-920e-018ea8c3898b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
          }
        }
      }
    },
    {
      "id": "virtual-83418b40-3ebe-5e5c-9947-c9d91b6ffedd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
          }
        }
      }
    },
    {
      "id": "virtual-40d3da04-4668-5a70-a188-d3d3edefb310",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
          }
        }
      }
    },
    {
      "id": "virtual-62df5e3f-c68f-5d43-ab11-c5241fd713ef",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
          }
        }
      }
    },
    {
      "id": "virtual-5bd1c946-1b07-5d46-b371-a04ba38e1a12",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
          }
        }
      }
    },
    {
      "id": "virtual-39df54e7-b65d-5945-a2bd-9486e48f86bc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
          }
        }
      }
    },
    {
      "id": "virtual-7f78322a-56c7-5716-8f3a-0642d526b957",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
          }
        }
      }
    },
    {
      "id": "virtual-dfe17e5f-f01e-5231-8923-592d98504a7e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b4748246-1fc5-4ea8-b9e1-d0d7fc8ed99c"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-19T12:34:47Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







