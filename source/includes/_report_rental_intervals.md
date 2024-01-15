# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-01-05+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=09634040-3b01-42d8-98d4-d975616b008a&filter%5Btill%5D=2024-01-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6ced806c-566a-4811-9cdf-2f6fc30fa077",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
          }
        }
      }
    },
    {
      "id": "9fa81cb5-7457-4bb6-9b53-462099a3c0f1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
          }
        }
      }
    },
    {
      "id": "c4e594cb-cfa2-4428-a7b0-df75db099355",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
          }
        }
      }
    },
    {
      "id": "988bc82f-89f8-41c2-98f9-5d8ad391e9af",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
          }
        }
      }
    },
    {
      "id": "3436e036-84dd-4868-a8bf-4333f104184c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
          }
        }
      }
    },
    {
      "id": "e589fcc7-4333-49ac-9b19-f113a6d8071b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
          }
        }
      }
    },
    {
      "id": "ebbfde40-6807-471a-85a0-3f79cfe35793",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
          }
        }
      }
    },
    {
      "id": "e6640f3f-a230-4b2e-bc51-512734abd155",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
          }
        }
      }
    },
    {
      "id": "f4e4da4a-3e9d-42a9-9f9e-43f1eaa59941",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
          }
        }
      }
    },
    {
      "id": "36901e1b-6f92-4d77-91b6-8e70029c1b34",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "09634040-3b01-42d8-98d4-d975616b008a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/09634040-3b01-42d8-98d4-d975616b008a"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







