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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=403df4a7-7462-414b-93ce-da36677e1816&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c58eb080-1b51-5049-8e0d-8b79c0f15cd7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
          }
        }
      }
    },
    {
      "id": "virtual-d1a47afb-2aad-5d57-aab6-616e9a26edb8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
          }
        }
      }
    },
    {
      "id": "virtual-1d428809-4d8c-522e-a11f-725dbb8931cd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
          }
        }
      }
    },
    {
      "id": "virtual-3c3497bb-6b31-5217-b27d-ae1948a25c21",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
          }
        }
      }
    },
    {
      "id": "virtual-292ea4c7-bb8a-509b-9f60-5f244ff9a371",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
          }
        }
      }
    },
    {
      "id": "virtual-d7337d17-16b8-5a0e-bbce-451c674ecd03",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
          }
        }
      }
    },
    {
      "id": "virtual-df4eba34-07b2-5fdb-a11a-9d96db6ffb13",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
          }
        }
      }
    },
    {
      "id": "virtual-19ec1509-ee63-5895-8e3e-f7fe3fa44513",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
          }
        }
      }
    },
    {
      "id": "virtual-f47ce222-130d-54a7-bc14-0a5febf910d7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
          }
        }
      }
    },
    {
      "id": "virtual-387d9b90-24ac-577f-9724-20e7e13f345d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "403df4a7-7462-414b-93ce-da36677e1816"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/403df4a7-7462-414b-93ce-da36677e1816"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T16:16:38Z`
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







