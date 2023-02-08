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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4a30681d-b432-4984-b456-7e82ba547d53&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-19bb6702-7ab1-57a9-b27d-62b99650faa8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
          }
        }
      }
    },
    {
      "id": "virtual-e12b842b-d11b-59f1-868b-e713fbbbb8db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
          }
        }
      }
    },
    {
      "id": "virtual-7de7a4c5-f5ec-5193-9220-27102bb68d58",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
          }
        }
      }
    },
    {
      "id": "virtual-ada330ed-0bb8-5492-9dfb-b71a60f8a68d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
          }
        }
      }
    },
    {
      "id": "virtual-055eed72-f33f-5c40-8b01-633ee95cebe0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
          }
        }
      }
    },
    {
      "id": "virtual-28ef56eb-3144-54b9-a25c-ef89727b67e2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
          }
        }
      }
    },
    {
      "id": "virtual-fee194c4-c75f-5dd0-a9fd-43d8c74754f6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
          }
        }
      }
    },
    {
      "id": "virtual-fe34016b-5495-5536-9acd-093c7f05cc8f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
          }
        }
      }
    },
    {
      "id": "virtual-b30c2598-8709-5b09-8a08-c0eeeb0b94f8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
          }
        }
      }
    },
    {
      "id": "virtual-2c692a4c-45d9-5169-aa35-b19689239838",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a30681d-b432-4984-b456-7e82ba547d53"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a30681d-b432-4984-b456-7e82ba547d53"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T08:33:59Z`
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







