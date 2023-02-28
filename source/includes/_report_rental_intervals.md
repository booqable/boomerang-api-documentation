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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-18+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=367a30f3-f387-4c48-af30-df89b5793012&filter%5Btill%5D=2023-02-27+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-15d7ba95-a260-52b1-b628-3c57ace8513c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
          }
        }
      }
    },
    {
      "id": "virtual-eddcd450-ecad-581d-9216-429bf086c03e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
          }
        }
      }
    },
    {
      "id": "virtual-65729524-493c-5d0e-9975-8c70197f2d84",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
          }
        }
      }
    },
    {
      "id": "virtual-0acfabc2-9f55-5aa5-bbf3-cbb68eef1a08",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
          }
        }
      }
    },
    {
      "id": "virtual-6806c8b8-cd81-5da8-82fa-16ae736d980a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
          }
        }
      }
    },
    {
      "id": "virtual-3af2ab2f-57e4-56f5-a424-e100f88611cd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
          }
        }
      }
    },
    {
      "id": "virtual-7f40133a-2874-5fbb-b9d8-c8189c41683e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
          }
        }
      }
    },
    {
      "id": "virtual-b1ab8250-21c6-52c3-87d3-05b8d0c40574",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
          }
        }
      }
    },
    {
      "id": "virtual-9a22c8d8-db99-5023-8e47-8939375ad526",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
          }
        }
      }
    },
    {
      "id": "virtual-43886334-c2d1-5166-a037-fcdfccc8e5ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "367a30f3-f387-4c48-af30-df89b5793012"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/367a30f3-f387-4c48-af30-df89b5793012"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T07:29:01Z`
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







