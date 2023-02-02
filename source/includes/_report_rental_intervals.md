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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=255e5eff-2b04-4aa0-9705-3341bb3b7d0b&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-6616eb5c-ec00-51d8-b38a-38e4b4ba510c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
          }
        }
      }
    },
    {
      "id": "virtual-19f2dcd3-fa60-5192-a787-b9a9b94543e9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
          }
        }
      }
    },
    {
      "id": "virtual-cd15b092-901e-571d-bf0d-8971a8809695",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
          }
        }
      }
    },
    {
      "id": "virtual-976e91f5-8485-5515-8c7b-411d2564c66c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
          }
        }
      }
    },
    {
      "id": "virtual-2acc3c82-bef1-5744-80eb-fbb60fee28a2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
          }
        }
      }
    },
    {
      "id": "virtual-f88561c3-4285-5a39-9205-f57e455e8aef",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
          }
        }
      }
    },
    {
      "id": "virtual-34fb7815-c882-5246-a1fb-64c9147c1176",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
          }
        }
      }
    },
    {
      "id": "virtual-c0932412-33e1-561f-adb1-9cba4c035c39",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
          }
        }
      }
    },
    {
      "id": "virtual-1bb5fd98-4e85-5c74-9be6-608676143f87",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
          }
        }
      }
    },
    {
      "id": "virtual-cd6b6bea-5775-5eac-8c7d-781ccf6631e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/255e5eff-2b04-4aa0-9705-3341bb3b7d0b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T11:14:17Z`
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







