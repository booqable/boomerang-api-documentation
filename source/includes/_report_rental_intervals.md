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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4c44047a-c7cf-47f1-ab85-1ac98fd08111&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-553aadd2-7082-5a01-9654-fbb6edfc683b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
          }
        }
      }
    },
    {
      "id": "virtual-773f84c6-9f80-5e60-85fe-52c7d8662baf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
          }
        }
      }
    },
    {
      "id": "virtual-50cc7048-c3a3-5fde-a75a-153d3248e6cd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
          }
        }
      }
    },
    {
      "id": "virtual-72ae9e45-cc66-581b-a57a-6e49d38ada16",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
          }
        }
      }
    },
    {
      "id": "virtual-1565ee19-7aee-5d49-b41b-1397b2143c12",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
          }
        }
      }
    },
    {
      "id": "virtual-ee8151b5-c29e-5bd7-897d-f6c2e5bf6ba8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
          }
        }
      }
    },
    {
      "id": "virtual-05b8afb3-03b4-5c14-9d4c-43a6dfe1d22b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
          }
        }
      }
    },
    {
      "id": "virtual-3c73e713-855b-5aeb-ad69-08d5fe75fe64",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
          }
        }
      }
    },
    {
      "id": "virtual-e3565552-4c66-5c19-93cf-7bf5058b4af9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
          }
        }
      }
    },
    {
      "id": "virtual-cc69bd69-8a7e-571c-a9d1-3893c98befee",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c44047a-c7cf-47f1-ab85-1ac98fd08111"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c44047a-c7cf-47f1-ab85-1ac98fd08111"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T09:43:44Z`
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







