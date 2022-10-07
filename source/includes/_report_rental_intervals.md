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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0545abca-7229-4734-b02d-126235b4c444&filter%5Btill%5D=2022-10-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-25a8cf87-0d39-55de-9d97-b7ac3a78b16f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
          }
        }
      }
    },
    {
      "id": "virtual-41d6cd43-3377-531f-8913-a63e7eb2e735",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
          }
        }
      }
    },
    {
      "id": "virtual-e094f2e6-379e-5014-aca0-4d573b0c3628",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
          }
        }
      }
    },
    {
      "id": "virtual-56f1685f-40ec-5321-9c83-e927d6b7705c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
          }
        }
      }
    },
    {
      "id": "virtual-ee475d72-20c7-5cfa-aa0f-0eb7b82690f0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
          }
        }
      }
    },
    {
      "id": "virtual-3a0e1cbc-a446-5bc0-912d-7b6b0444472f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
          }
        }
      }
    },
    {
      "id": "virtual-f7d224ba-4abe-53b8-9275-6904bee2f3e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
          }
        }
      }
    },
    {
      "id": "virtual-8fe4a826-aa83-5386-80fe-b01fc06a34e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
          }
        }
      }
    },
    {
      "id": "virtual-8bd8c510-bc27-5cff-9b2f-e900732d15c5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
          }
        }
      }
    },
    {
      "id": "virtual-69901346-e619-5d3a-ab1a-f0ede9d613a6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0545abca-7229-4734-b02d-126235b4c444"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0545abca-7229-4734-b02d-126235b4c444"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T12:07:11Z`
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







