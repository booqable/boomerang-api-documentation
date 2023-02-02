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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=55bbc4f9-a409-4fc9-bdca-65a80e47c242&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-5bebf387-5ac3-5fd5-bd67-535f1cbac66d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
          }
        }
      }
    },
    {
      "id": "virtual-3c96049b-3643-5b75-926f-35c322562510",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
          }
        }
      }
    },
    {
      "id": "virtual-b2057d0a-4420-5a32-9302-cd470a35d16f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
          }
        }
      }
    },
    {
      "id": "virtual-52e423ba-96ad-5dba-819b-444bcba0bfe8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
          }
        }
      }
    },
    {
      "id": "virtual-3adb69f6-c595-58c7-a8c3-f402809bc19a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
          }
        }
      }
    },
    {
      "id": "virtual-48a53404-4616-5029-838d-becbe1f05387",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
          }
        }
      }
    },
    {
      "id": "virtual-e2fc8eb4-0c09-594a-a194-af5967ea36a5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
          }
        }
      }
    },
    {
      "id": "virtual-9b7e661b-4af6-53e4-8918-787d482ea1e8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
          }
        }
      }
    },
    {
      "id": "virtual-86b11661-8324-5928-bb3e-512918968832",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
          }
        }
      }
    },
    {
      "id": "virtual-e6f20c25-b76a-558c-9e30-55007a1d6348",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "55bbc4f9-a409-4fc9-bdca-65a80e47c242"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/55bbc4f9-a409-4fc9-bdca-65a80e47c242"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T14:13:30Z`
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







