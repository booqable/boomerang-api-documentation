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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=3debe7e7-5bd3-4e84-9eec-70b9f3402582&filter%5Btill%5D=2023-02-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b20f3a7d-e688-5689-a948-b70ad14e84f0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
          }
        }
      }
    },
    {
      "id": "virtual-30d8f182-6e5b-550e-b145-98de56123a0f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
          }
        }
      }
    },
    {
      "id": "virtual-9103559c-e1a8-52b7-bf32-aa3e165afbca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
          }
        }
      }
    },
    {
      "id": "virtual-de8449ff-6e1e-5385-8140-a06fa6dc9cec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
          }
        }
      }
    },
    {
      "id": "virtual-f956d7e5-b420-5e79-8a30-e807c764ae08",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
          }
        }
      }
    },
    {
      "id": "virtual-1ca05c42-a642-5500-8345-069181cdcfdb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
          }
        }
      }
    },
    {
      "id": "virtual-ba461985-3d1f-5307-97d0-eeca75a89c41",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
          }
        }
      }
    },
    {
      "id": "virtual-2c020ac2-f5e5-53d9-a549-4c9d31200544",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
          }
        }
      }
    },
    {
      "id": "virtual-7e3ff5b1-ad0a-5cf5-980b-1721c2e9494b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
          }
        }
      }
    },
    {
      "id": "virtual-1d1ff4de-288a-54e4-9372-b0ada0208b66",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3debe7e7-5bd3-4e84-9eec-70b9f3402582"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3debe7e7-5bd3-4e84-9eec-70b9f3402582"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T14:55:46Z`
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







