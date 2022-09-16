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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=7ed3f34f-19f0-4b10-9af4-04e74f48f628&filter%5Btill%5D=2022-09-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-69a121b3-e787-568d-a516-0f9a8dd92133",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
          }
        }
      }
    },
    {
      "id": "virtual-4e1d57b3-45e0-521f-b526-8cc09345464c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
          }
        }
      }
    },
    {
      "id": "virtual-06fb91da-22b2-51b4-b995-b84b92d682bc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
          }
        }
      }
    },
    {
      "id": "virtual-97b516a4-6f4c-5984-8f5b-2fa80b6dd834",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
          }
        }
      }
    },
    {
      "id": "virtual-1e4a0768-bbde-54b9-bef9-db49b867cbfd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
          }
        }
      }
    },
    {
      "id": "virtual-dbab4938-eea7-5edd-a15a-d581f16966ea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
          }
        }
      }
    },
    {
      "id": "virtual-bca0f0ac-ecbb-54dc-9225-14eff51d7eae",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
          }
        }
      }
    },
    {
      "id": "virtual-37c77cb0-dd0f-5525-a7d7-9203faf6b9bc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
          }
        }
      }
    },
    {
      "id": "virtual-0d602eb6-5717-5aab-afcd-d207db036fb4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
          }
        }
      }
    },
    {
      "id": "virtual-2969538b-8c82-5b32-8ae2-08cb4c61825c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7ed3f34f-19f0-4b10-9af4-04e74f48f628"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7ed3f34f-19f0-4b10-9af4-04e74f48f628"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T09:00:39Z`
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







