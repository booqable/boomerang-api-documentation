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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-13+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=5a10f288-c409-4ba9-a3c4-be5ace3903e0&filter%5Btill%5D=2023-02-22+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ad1e8427-55a1-50c1-94dc-2d97e541d2ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
          }
        }
      }
    },
    {
      "id": "virtual-8e47f006-b902-5b65-a37f-7298157462e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
          }
        }
      }
    },
    {
      "id": "virtual-e56a8171-3771-5cf6-92ac-ab5cfcd38306",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
          }
        }
      }
    },
    {
      "id": "virtual-7dd45ec6-3f0c-56f5-8044-ff52f737715f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
          }
        }
      }
    },
    {
      "id": "virtual-ddd32af3-05b3-5c6e-bab7-aa5b71bfc55b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
          }
        }
      }
    },
    {
      "id": "virtual-db724e12-b253-5be6-b047-d205593eee9b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
          }
        }
      }
    },
    {
      "id": "virtual-4cf893ab-1910-54ae-8be1-9f2f13c375ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
          }
        }
      }
    },
    {
      "id": "virtual-81458a40-1b47-51ae-bbca-5ed750a9dbe3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
          }
        }
      }
    },
    {
      "id": "virtual-8211820b-2af9-5d02-8ce0-87879a920e7b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
          }
        }
      }
    },
    {
      "id": "virtual-5ecd8716-a13f-527a-b63a-e4e32ef3c1f1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a10f288-c409-4ba9-a3c4-be5ace3903e0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a10f288-c409-4ba9-a3c4-be5ace3903e0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T13:35:38Z`
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







