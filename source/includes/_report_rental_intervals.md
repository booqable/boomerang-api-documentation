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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=207f13a6-8830-4698-adf4-f9d82fd8c97e&filter%5Btill%5D=2022-11-03+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-857dfc87-06e3-5bcc-8c65-7f6579c285b5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
          }
        }
      }
    },
    {
      "id": "virtual-c5517cb5-ebed-503d-8d4c-31dce8131f1b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
          }
        }
      }
    },
    {
      "id": "virtual-ab895f1f-0429-5113-8bd5-632992615e52",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
          }
        }
      }
    },
    {
      "id": "virtual-aa476275-a915-5fa9-93ae-c48ec2d19c18",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
          }
        }
      }
    },
    {
      "id": "virtual-4f4ae3e6-c099-529c-8e7c-81a822b26a07",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
          }
        }
      }
    },
    {
      "id": "virtual-b1e13d72-42f5-57ff-97e2-e66be184e2b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
          }
        }
      }
    },
    {
      "id": "virtual-8dbd4cdd-ccd8-5390-a430-400a1fa76128",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
          }
        }
      }
    },
    {
      "id": "virtual-8adfb0b4-702f-5c2c-af7c-99a4fc6d992f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
          }
        }
      }
    },
    {
      "id": "virtual-a4b562e8-aa01-511d-890a-010c11ffbc38",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
          }
        }
      }
    },
    {
      "id": "virtual-afd1c155-ec5d-5f6e-be7e-c124a760640e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "207f13a6-8830-4698-adf4-f9d82fd8c97e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/207f13a6-8830-4698-adf4-f9d82fd8c97e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:37:25Z`
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







