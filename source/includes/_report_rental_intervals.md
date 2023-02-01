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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-22+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c52f12ad-fcb6-4532-9689-be203b989762&filter%5Btill%5D=2023-01-31+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a5b37871-b289-5bc2-aaec-60e8d2ae0cab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
          }
        }
      }
    },
    {
      "id": "virtual-6e0a39fa-ac8e-5ff1-bba3-26bc199ca369",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
          }
        }
      }
    },
    {
      "id": "virtual-a9a12e97-c9de-57ed-beef-29b699f3a7fa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
          }
        }
      }
    },
    {
      "id": "virtual-5950f79e-0756-52cb-ba78-313d0f4382aa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
          }
        }
      }
    },
    {
      "id": "virtual-111a0e16-6495-513d-a5fa-0559a636b240",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
          }
        }
      }
    },
    {
      "id": "virtual-35cea854-1f40-53a3-b2e6-8f0e23d39105",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
          }
        }
      }
    },
    {
      "id": "virtual-61268890-011a-561d-81c6-ac72a0a1cff6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
          }
        }
      }
    },
    {
      "id": "virtual-ac465922-4df0-5207-b89b-f3dace29cf9f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
          }
        }
      }
    },
    {
      "id": "virtual-7e44543d-c2cf-5b27-bfcf-c140b004056b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
          }
        }
      }
    },
    {
      "id": "virtual-3d0cd5d6-0e40-592f-937a-a0191058741c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c52f12ad-fcb6-4532-9689-be203b989762"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c52f12ad-fcb6-4532-9689-be203b989762"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:13:38Z`
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







