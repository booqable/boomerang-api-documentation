# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0313a22e-9d40-416a-b810-8bf184e44143&filter%5Btill%5D=2022-07-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-d566db15-8594-5cc9-944b-b26e099fe16a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
          }
        }
      }
    },
    {
      "id": "virtual-f7cb248c-17b9-5bfb-89ba-1768ee5521b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
          }
        }
      }
    },
    {
      "id": "virtual-9aa67908-f41f-5bc8-82ad-5127a5ed0585",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
          }
        }
      }
    },
    {
      "id": "virtual-b4e3e6ea-860c-5541-a76a-eab94afdfb63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
          }
        }
      }
    },
    {
      "id": "virtual-4392aadd-9a9c-5a0e-b2a1-ea84ed25f36d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
          }
        }
      }
    },
    {
      "id": "virtual-82f4dc1d-5548-55c4-abd4-ace45cacbe03",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
          }
        }
      }
    },
    {
      "id": "virtual-bb49166c-33fa-57b1-b7cd-c22022f8e56f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
          }
        }
      }
    },
    {
      "id": "virtual-e3f1a763-f993-5351-9f86-2cd155c0dbc9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
          }
        }
      }
    },
    {
      "id": "virtual-e0c4f2de-c9d1-57d9-9b4a-4ef334fe027d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
          }
        }
      }
    },
    {
      "id": "virtual-473bad24-21c0-5fb2-9b8b-5b449cf80ccd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0313a22e-9d40-416a-b810-8bf184e44143"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0313a22e-9d40-416a-b810-8bf184e44143"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-21T10:55:43Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







