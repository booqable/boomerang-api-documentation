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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=074c21b7-eb8e-4518-baff-0a28a3c05112&filter%5Btill%5D=2023-03-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f47bebe8-94ea-5a8e-88c6-923305cd5c90",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
          }
        }
      }
    },
    {
      "id": "virtual-542b9d8b-9df5-5ada-be34-4d46d1ef6a0d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
          }
        }
      }
    },
    {
      "id": "virtual-56dd7050-98e1-56ae-a59d-e21e30d167a5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
          }
        }
      }
    },
    {
      "id": "virtual-2d1cc265-f5b5-5981-8f38-27a14ad3dc74",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
          }
        }
      }
    },
    {
      "id": "virtual-fbf40e07-d575-5c00-8795-305376f38272",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
          }
        }
      }
    },
    {
      "id": "virtual-2fb8fd4e-64be-5aee-926b-a54d11d61656",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
          }
        }
      }
    },
    {
      "id": "virtual-8343e5db-22ae-5ce7-ac51-bd7ad4adc054",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
          }
        }
      }
    },
    {
      "id": "virtual-c8eb109e-cf2b-5e28-8492-a79c1ca4ebc0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
          }
        }
      }
    },
    {
      "id": "virtual-f52f3ff3-6623-59fa-b6d4-b06276f8d4bf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
          }
        }
      }
    },
    {
      "id": "virtual-087e0b86-da5f-5204-9d0b-a91c05041414",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "074c21b7-eb8e-4518-baff-0a28a3c05112"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/074c21b7-eb8e-4518-baff-0a28a3c05112"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T10:26:12Z`
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







