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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b39c0af2-8809-471b-9165-19f7ee7b74b0&filter%5Btill%5D=2023-01-04+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-82199e9e-af78-5e20-9dd5-77db9b931320",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
          }
        }
      }
    },
    {
      "id": "virtual-5ebebd18-d5a9-5dc6-8896-79b5e60087de",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
          }
        }
      }
    },
    {
      "id": "virtual-5bc73184-73b0-5bf4-83d9-6580adb719a6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
          }
        }
      }
    },
    {
      "id": "virtual-157bb0af-113f-5456-a3c2-62b827fe9d2f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
          }
        }
      }
    },
    {
      "id": "virtual-55cb21e9-388d-5669-82e5-d518e7220ddb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
          }
        }
      }
    },
    {
      "id": "virtual-cb3d98c2-62f4-5649-965a-bb59a60da25c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
          }
        }
      }
    },
    {
      "id": "virtual-319c19a1-c66a-59ea-b72c-b542d75c7809",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
          }
        }
      }
    },
    {
      "id": "virtual-13800db7-477b-5186-bfdb-37461a2c811d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
          }
        }
      }
    },
    {
      "id": "virtual-e8ebdbe2-3e80-50f9-8b0a-4b97ece11815",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
          }
        }
      }
    },
    {
      "id": "virtual-36d677e6-29cb-5635-abab-cd73db528fe0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b39c0af2-8809-471b-9165-19f7ee7b74b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b39c0af2-8809-471b-9165-19f7ee7b74b0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T11:02:34Z`
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







