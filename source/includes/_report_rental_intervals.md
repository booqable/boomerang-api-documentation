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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-02+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2ba04190-41ee-493b-af3c-3773db418e9b&filter%5Btill%5D=2022-10-11+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0f56e248-6365-5e09-983f-175433b11f5a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
          }
        }
      }
    },
    {
      "id": "virtual-ce804019-b56d-57c3-b7eb-3c6084a38fab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
          }
        }
      }
    },
    {
      "id": "virtual-e2b57fed-76b1-5ab7-b467-bad2bd3613a8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
          }
        }
      }
    },
    {
      "id": "virtual-6a72e40b-4a7e-54fa-a8a6-2921773d01e9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
          }
        }
      }
    },
    {
      "id": "virtual-14e85617-4d89-5b3d-8363-618b4ccf040d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
          }
        }
      }
    },
    {
      "id": "virtual-55c09d56-06bf-5af0-b93e-4a740f16ca62",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
          }
        }
      }
    },
    {
      "id": "virtual-70b471cd-f8fd-5f36-b5eb-ce4f7ddb5d89",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
          }
        }
      }
    },
    {
      "id": "virtual-d0c24619-4f73-5ad7-b2b1-2b1e45a3027d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
          }
        }
      }
    },
    {
      "id": "virtual-3d58d9c5-45cf-5c6b-a824-85d265e63c7f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
          }
        }
      }
    },
    {
      "id": "virtual-66996b0a-942b-5662-b33a-b12c3cdcbf56",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2ba04190-41ee-493b-af3c-3773db418e9b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2ba04190-41ee-493b-af3c-3773db418e9b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-12T12:56:09Z`
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







