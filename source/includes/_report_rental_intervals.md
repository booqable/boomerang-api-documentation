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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=d9ec0288-53bc-42b6-b54e-4b04915eaa9c&filter%5Btill%5D=2023-03-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-d123a496-7fa2-52ed-97b1-90a0aabf438d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
          }
        }
      }
    },
    {
      "id": "virtual-f5f2b50a-c50c-5147-9c93-7be36a3817b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
          }
        }
      }
    },
    {
      "id": "virtual-25dc3740-d858-5ec1-a09e-dcb7df7445f3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
          }
        }
      }
    },
    {
      "id": "virtual-dc00f2af-295d-56e1-a456-d45f0577a065",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
          }
        }
      }
    },
    {
      "id": "virtual-2aeb8108-8c7e-5a45-af3a-cf3a4f033bfc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
          }
        }
      }
    },
    {
      "id": "virtual-1f264330-8d28-5c8d-97cf-84fbf5e895b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
          }
        }
      }
    },
    {
      "id": "virtual-ce13c112-7506-5b5c-b7e7-1a486e1d575e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
          }
        }
      }
    },
    {
      "id": "virtual-03348928-db13-50a4-be15-494201a3821e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
          }
        }
      }
    },
    {
      "id": "virtual-3f7573ee-bcd8-5d3a-adaa-1433196d9ad6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
          }
        }
      }
    },
    {
      "id": "virtual-56bbddf5-9fec-5c6e-b9d2-704701839a57",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d9ec0288-53bc-42b6-b54e-4b04915eaa9c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T12:09:05Z`
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







