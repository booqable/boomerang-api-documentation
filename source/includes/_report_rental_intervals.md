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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=bd0f58f1-44b8-45f1-94f1-efb2b3f1008b&filter%5Btill%5D=2023-02-02+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-7858b1f5-75b3-5950-b1a9-3247a3b4d270",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
          }
        }
      }
    },
    {
      "id": "virtual-3569f0f0-6c48-5601-9a18-5d3b3782b0a4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
          }
        }
      }
    },
    {
      "id": "virtual-d61e0715-9b1d-5687-b0e1-ecf10d1fa6aa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
          }
        }
      }
    },
    {
      "id": "virtual-f558f888-5326-54ff-bc9f-91823596b205",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
          }
        }
      }
    },
    {
      "id": "virtual-843d3305-1db2-5097-9dd2-8af7c8181d00",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
          }
        }
      }
    },
    {
      "id": "virtual-4f31a93c-6313-50de-ac9d-04d26f77bd14",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
          }
        }
      }
    },
    {
      "id": "virtual-744d0b88-7294-5587-b5d0-455913a9ff54",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
          }
        }
      }
    },
    {
      "id": "virtual-d7df7847-487e-5793-9828-f12d4f24b0db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
          }
        }
      }
    },
    {
      "id": "virtual-e437fc55-5e71-563b-a551-808f4690103e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
          }
        }
      }
    },
    {
      "id": "virtual-a92b4620-1db9-583a-8e42-6f8d240c3d3a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bd0f58f1-44b8-45f1-94f1-efb2b3f1008b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T11:09:11Z`
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







