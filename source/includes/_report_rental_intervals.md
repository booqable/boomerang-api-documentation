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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=7acb064c-9ccb-44cf-900c-002aa912f553&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-3373e763-295d-55f9-83e9-765682dfb0e1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
          }
        }
      }
    },
    {
      "id": "virtual-69c63fdf-5d9e-5346-934b-7c499583a117",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
          }
        }
      }
    },
    {
      "id": "virtual-e42152e1-76f7-5ac6-aed0-f1a247dea5d0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
          }
        }
      }
    },
    {
      "id": "virtual-4cc83940-3200-5690-b082-80afe017090d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
          }
        }
      }
    },
    {
      "id": "virtual-0642eec3-a680-570a-a963-e13a5916a531",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
          }
        }
      }
    },
    {
      "id": "virtual-4ea62192-be76-5863-a7c7-9c711d6ea943",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
          }
        }
      }
    },
    {
      "id": "virtual-f659a20d-ea1d-585b-bbaa-c57c5454c958",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
          }
        }
      }
    },
    {
      "id": "virtual-300aee12-b839-547a-81d3-245111845f50",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
          }
        }
      }
    },
    {
      "id": "virtual-26f41abc-5698-53dc-9c44-c68267078b8c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
          }
        }
      }
    },
    {
      "id": "virtual-47c0677b-c141-57a2-a9e8-cca99134d61a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7acb064c-9ccb-44cf-900c-002aa912f553"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7acb064c-9ccb-44cf-900c-002aa912f553"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T15:47:30Z`
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







