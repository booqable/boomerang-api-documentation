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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4b450a5c-d055-4206-b4f9-085a877bee5d&filter%5Btill%5D=2023-03-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-56c61f85-4f8a-514c-a6f5-01a31348683e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
          }
        }
      }
    },
    {
      "id": "virtual-e77f2a51-1f30-503e-886b-60e53b745750",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
          }
        }
      }
    },
    {
      "id": "virtual-b087b33a-3d37-5a7a-8809-c6404ca35832",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
          }
        }
      }
    },
    {
      "id": "virtual-95aa6674-4564-52d6-af1d-ba5d198bf2ef",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
          }
        }
      }
    },
    {
      "id": "virtual-a7a04e01-bc97-5098-b6fd-7c620ca2dc4e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
          }
        }
      }
    },
    {
      "id": "virtual-fe74c13b-5364-58dc-bfc8-31b8a31f4112",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
          }
        }
      }
    },
    {
      "id": "virtual-914846dc-9ae8-59bf-abed-d1448a69fb23",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
          }
        }
      }
    },
    {
      "id": "virtual-e8a5a718-356a-555d-8c09-96e3fdb5c384",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
          }
        }
      }
    },
    {
      "id": "virtual-6c38d856-9a9e-5eda-b1c4-02655eb5f348",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
          }
        }
      }
    },
    {
      "id": "virtual-4a7d8441-3dff-5ab4-9571-d9d3039d1d15",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b450a5c-d055-4206-b4f9-085a877bee5d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b450a5c-d055-4206-b4f9-085a877bee5d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T07:51:48Z`
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







