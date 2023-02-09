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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=14f53492-c60d-459d-add9-9b0cb7b8c7df&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-63686391-cc48-5194-ad20-0c3592e2cb0f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
          }
        }
      }
    },
    {
      "id": "virtual-e8b220d8-ea65-5623-bd94-49ff42403a86",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
          }
        }
      }
    },
    {
      "id": "virtual-f8d37e35-66c9-5848-b301-77f685c3149d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
          }
        }
      }
    },
    {
      "id": "virtual-8c0bd78e-a5dd-5576-92e4-f1f61b239df1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
          }
        }
      }
    },
    {
      "id": "virtual-584ef57e-faab-55e7-b39a-011216805c14",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
          }
        }
      }
    },
    {
      "id": "virtual-d82d71ce-5602-522e-9547-e1c319726365",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
          }
        }
      }
    },
    {
      "id": "virtual-60377581-7fb8-5cfa-9068-ae5f65c184e2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
          }
        }
      }
    },
    {
      "id": "virtual-ad2c9576-06fd-5ce0-a80e-bf6cbf8f0561",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
          }
        }
      }
    },
    {
      "id": "virtual-7304429b-4922-520e-8018-6d957d2f7be2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
          }
        }
      }
    },
    {
      "id": "virtual-d918e020-7cba-5503-bea0-083953f21a02",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14f53492-c60d-459d-add9-9b0cb7b8c7df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14f53492-c60d-459d-add9-9b0cb7b8c7df"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T11:05:49Z`
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







