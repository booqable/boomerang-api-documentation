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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=18e8ef99-8e68-447d-a2c8-ba1cfe79976e&filter%5Btill%5D=2023-02-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ebd8059f-1438-57f0-a5b3-90fd591e77ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
          }
        }
      }
    },
    {
      "id": "virtual-c741f0de-6f57-559a-8de6-ffca4e0ead2a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
          }
        }
      }
    },
    {
      "id": "virtual-23e1219f-208e-5898-be42-1baa4f7f8d58",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
          }
        }
      }
    },
    {
      "id": "virtual-d496c816-5f09-503d-bd0d-b4536a854341",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
          }
        }
      }
    },
    {
      "id": "virtual-7533a026-18f9-55ec-9d49-9c2a77961df1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
          }
        }
      }
    },
    {
      "id": "virtual-c8202345-8622-5903-8105-5c2fd801a0f5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
          }
        }
      }
    },
    {
      "id": "virtual-8eec278c-6644-59ff-b270-0e39ae13558b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
          }
        }
      }
    },
    {
      "id": "virtual-c54d70f3-843f-5286-bb4c-40926f87eaef",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
          }
        }
      }
    },
    {
      "id": "virtual-d91ac53a-80f9-5df8-8ba9-1a00615c85ed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
          }
        }
      }
    },
    {
      "id": "virtual-5f0c6eb1-0a23-5a67-a6c5-d7aea40eea82",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/18e8ef99-8e68-447d-a2c8-ba1cfe79976e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T16:13:03Z`
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







