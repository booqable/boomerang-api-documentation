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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=f3868627-915f-4d13-b08c-62252e2d8152&filter%5Btill%5D=2023-03-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-9597b935-d94f-55a1-a28b-c900f5097204",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
          }
        }
      }
    },
    {
      "id": "virtual-a7e9d1b3-dd9f-5600-b441-31701dfa29c4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
          }
        }
      }
    },
    {
      "id": "virtual-9c037887-d9c9-5042-b1dc-1a93e3cc3235",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
          }
        }
      }
    },
    {
      "id": "virtual-091bd9fd-6d1f-5d59-885f-3e5e6ddf8e0e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
          }
        }
      }
    },
    {
      "id": "virtual-ca651293-151f-567f-98e1-5a6d8c57a78c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
          }
        }
      }
    },
    {
      "id": "virtual-e655f339-0ccf-5e56-91e9-4886de7ef242",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
          }
        }
      }
    },
    {
      "id": "virtual-6dfa9ff8-cb02-5a21-9fb9-183c1c983d0e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
          }
        }
      }
    },
    {
      "id": "virtual-07ea2ac7-c47f-5053-bea3-97716be96f34",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
          }
        }
      }
    },
    {
      "id": "virtual-af10c7a0-fd5f-5882-9420-d281f322a307",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
          }
        }
      }
    },
    {
      "id": "virtual-33be219b-cd5f-5563-a2c1-5d945e67c7eb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f3868627-915f-4d13-b08c-62252e2d8152"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f3868627-915f-4d13-b08c-62252e2d8152"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T09:33:05Z`
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







