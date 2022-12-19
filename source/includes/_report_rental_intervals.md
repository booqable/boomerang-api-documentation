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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-09+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=11b693dd-e8ad-4e81-84e4-84c3a4ee5568&filter%5Btill%5D=2022-12-18+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-81e51244-c63c-5d78-934b-0be124eb2283",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
          }
        }
      }
    },
    {
      "id": "virtual-e6bffbb4-978d-51f8-8d4a-859675c2f934",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
          }
        }
      }
    },
    {
      "id": "virtual-f29d762a-06c2-59f4-89db-9ab21b9b9360",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
          }
        }
      }
    },
    {
      "id": "virtual-08eeb998-c58a-5a09-b214-70bd5b4d5f47",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
          }
        }
      }
    },
    {
      "id": "virtual-64962365-2a50-517b-b5e5-b62013102257",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
          }
        }
      }
    },
    {
      "id": "virtual-5fb179ef-e093-5504-8115-1e8230efbb09",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
          }
        }
      }
    },
    {
      "id": "virtual-27d70fb5-f791-5056-8729-f87a4c617e15",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
          }
        }
      }
    },
    {
      "id": "virtual-bfcd9072-449d-58bd-8eb2-ecdedb73eab8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
          }
        }
      }
    },
    {
      "id": "virtual-6ed5dd30-9747-598e-b013-ba9a28b7808f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
          }
        }
      }
    },
    {
      "id": "virtual-a8761a2c-15bc-5c09-aac4-4a78d56f6b1e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11b693dd-e8ad-4e81-84e4-84c3a4ee5568"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-19T08:45:39Z`
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







