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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=70f152b1-a0ae-49b2-a593-00c78e238410&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ecb1a97e-72b4-5f1e-999f-da50bcbdb8f6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
          }
        }
      }
    },
    {
      "id": "virtual-bd05633f-da98-5ed8-b0e0-5ba183867db1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
          }
        }
      }
    },
    {
      "id": "virtual-4d900d55-fdc3-5f22-a0ce-810896219ad2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
          }
        }
      }
    },
    {
      "id": "virtual-7845e49a-4f07-5fb1-a709-00d4392ded0f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
          }
        }
      }
    },
    {
      "id": "virtual-61f7980e-ad40-55d2-aed5-e0f463f1717d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
          }
        }
      }
    },
    {
      "id": "virtual-10e3e324-15aa-5a2e-9d29-631660a08bbc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
          }
        }
      }
    },
    {
      "id": "virtual-d25a1a4d-a4a3-51a2-aec4-8126b3d720e6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
          }
        }
      }
    },
    {
      "id": "virtual-2a5eb032-822a-5d9d-90ee-639c133723ed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
          }
        }
      }
    },
    {
      "id": "virtual-a4f41b6b-d7a1-5f99-84a9-bf631cf26819",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
          }
        }
      }
    },
    {
      "id": "virtual-9064597e-f253-5659-ad98-49fc657dfb49",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "70f152b1-a0ae-49b2-a593-00c78e238410"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/70f152b1-a0ae-49b2-a593-00c78e238410"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T11:19:08Z`
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







