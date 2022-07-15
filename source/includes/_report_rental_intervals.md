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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-05+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=48f86431-6cf1-431d-b6d9-b6ae059003a0&filter%5Btill%5D=2022-07-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-9611ea35-bf2e-5448-9111-66ac7b789a23",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
          }
        }
      }
    },
    {
      "id": "virtual-7fc34c6f-47a6-5a2c-875e-c97eadca9f17",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
          }
        }
      }
    },
    {
      "id": "virtual-78cfe004-8f7a-55f3-b139-83d638100880",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
          }
        }
      }
    },
    {
      "id": "virtual-14d2a70b-d05b-5ab7-a0b8-ac95a7f00e86",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
          }
        }
      }
    },
    {
      "id": "virtual-fc9f904a-8bdd-5b2d-94a4-a308d9f78212",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
          }
        }
      }
    },
    {
      "id": "virtual-6b7599a8-5c1f-5d8d-b0ba-7497e07ea287",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
          }
        }
      }
    },
    {
      "id": "virtual-5470a91d-35f8-5ecb-b406-7aee7170bfbf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
          }
        }
      }
    },
    {
      "id": "virtual-5d993e60-bf08-57a2-974a-c0ffe4b5c218",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
          }
        }
      }
    },
    {
      "id": "virtual-81233115-15a2-53f6-a7ef-1531f6418493",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
          }
        }
      }
    },
    {
      "id": "virtual-a854f85f-0004-535e-b6b2-15ee10c5f2ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "48f86431-6cf1-431d-b6d9-b6ae059003a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/48f86431-6cf1-431d-b6d9-b6ae059003a0"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T09:52:45Z`
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







