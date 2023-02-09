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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=8cb71018-f647-4544-aff1-d962984abe66&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-aa8f6444-b61f-5cfd-92a0-3e18bef029c2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
          }
        }
      }
    },
    {
      "id": "virtual-822e6151-6ee8-58ca-8e0b-6c2f1823cba2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
          }
        }
      }
    },
    {
      "id": "virtual-2572f0c2-4050-5561-a54a-bc1c506ac79e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
          }
        }
      }
    },
    {
      "id": "virtual-66a46796-27c6-55f8-8d63-fbdf67a5f376",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
          }
        }
      }
    },
    {
      "id": "virtual-e40248b0-2651-5e1c-98b6-0116ad7b41e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
          }
        }
      }
    },
    {
      "id": "virtual-ad86f8ba-2736-51ff-9291-9e35424c351b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
          }
        }
      }
    },
    {
      "id": "virtual-a099a073-0563-57a4-a8bd-ee443e0ca61f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
          }
        }
      }
    },
    {
      "id": "virtual-5a4ea26c-6aa2-51de-858b-40d38ccf502f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
          }
        }
      }
    },
    {
      "id": "virtual-4b46cd9d-b7eb-5801-a851-f69bd5d13ef8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
          }
        }
      }
    },
    {
      "id": "virtual-28c2cb89-7d8e-5b9b-ad20-cf448b2357e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8cb71018-f647-4544-aff1-d962984abe66"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8cb71018-f647-4544-aff1-d962984abe66"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T13:05:03Z`
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







