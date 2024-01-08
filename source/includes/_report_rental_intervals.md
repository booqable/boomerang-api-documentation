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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-12-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0dadff1b-9c5b-4c6f-9f92-b076033a49d5&filter%5Btill%5D=2024-01-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "769ba7a0-ae71-4056-b401-77536b25cfe0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
          }
        }
      }
    },
    {
      "id": "33f3c6b6-6c28-4d04-b13c-f5b936dd76d5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
          }
        }
      }
    },
    {
      "id": "220b43ba-74db-4ca5-9bf2-4aa9eec05e85",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
          }
        }
      }
    },
    {
      "id": "2a9b96ab-f0af-451e-8b98-a8878e3a4b26",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
          }
        }
      }
    },
    {
      "id": "0b5eab5c-d79d-40e1-9ba4-e83601738951",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
          }
        }
      }
    },
    {
      "id": "f5dd367d-7bd5-4950-a8d7-65ef385e913b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
          }
        }
      }
    },
    {
      "id": "e7306404-e7b1-4fd3-8a95-391a8c05b14d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
          }
        }
      }
    },
    {
      "id": "5a3f746e-d9d4-4513-8683-dbff7186bf54",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
          }
        }
      }
    },
    {
      "id": "2c9a48b9-48eb-4b9b-b7d1-c5f8f817f492",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
          }
        }
      }
    },
    {
      "id": "d987f9a5-d336-4501-8575-47a050a2ca99",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0dadff1b-9c5b-4c6f-9f92-b076033a49d5"
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







