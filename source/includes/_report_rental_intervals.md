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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-31+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0e95348c-9a8c-4a5d-ba1f-8574845e3f10&filter%5Btill%5D=2023-01-09+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-9965b07d-f6a8-587b-b1ff-fc2b6582e7c9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
          }
        }
      }
    },
    {
      "id": "virtual-1a5e7b08-3dbd-5e65-9ef8-6d54f8888844",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
          }
        }
      }
    },
    {
      "id": "virtual-53ff4e74-a205-515f-a112-df7ffba2dd4e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
          }
        }
      }
    },
    {
      "id": "virtual-db9deb01-5d62-5ecc-afd2-c9b3cf302d77",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
          }
        }
      }
    },
    {
      "id": "virtual-79795a79-f7b6-501a-9621-d5d758da728f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
          }
        }
      }
    },
    {
      "id": "virtual-d1ff8c72-6cbd-5611-8b89-38397b738836",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
          }
        }
      }
    },
    {
      "id": "virtual-54bc5f19-61af-501e-bacf-b2d0f9a838ea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
          }
        }
      }
    },
    {
      "id": "virtual-dfb18aef-a864-5112-8354-3917fe00ea99",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
          }
        }
      }
    },
    {
      "id": "virtual-16063721-509c-55b6-b30f-8f7d9c06a89f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
          }
        }
      }
    },
    {
      "id": "virtual-b3f2ce62-3beb-5012-9308-c2cbd841197f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e95348c-9a8c-4a5d-ba1f-8574845e3f10"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-10T14:04:56Z`
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







