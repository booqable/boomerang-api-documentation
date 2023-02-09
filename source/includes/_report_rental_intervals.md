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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=73fbfcf2-90cc-4d47-bfa5-15970c21f10d&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c62dc3ce-13d3-5a8b-ac88-468205de3bc1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
          }
        }
      }
    },
    {
      "id": "virtual-20cd0b82-fb83-5ba6-8ca2-dd6ee35b9515",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
          }
        }
      }
    },
    {
      "id": "virtual-f6b78f21-b414-5bc7-8600-b7c7f80d2a2d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
          }
        }
      }
    },
    {
      "id": "virtual-ae814250-b18b-5efa-967b-9af1ec02ade7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
          }
        }
      }
    },
    {
      "id": "virtual-3a309f7e-8c7a-5a08-9ad2-bc33796c9f3e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
          }
        }
      }
    },
    {
      "id": "virtual-7fec454c-4ef4-54f3-a5a0-edc3b63cd800",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
          }
        }
      }
    },
    {
      "id": "virtual-53662fdb-f374-573e-896c-a347141cf120",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
          }
        }
      }
    },
    {
      "id": "virtual-6b32751c-fcc3-5bb9-81b5-1d1484d1f6d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
          }
        }
      }
    },
    {
      "id": "virtual-1ddb7991-8de3-5ff6-bb52-116284fae25b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
          }
        }
      }
    },
    {
      "id": "virtual-8918a814-46ec-5377-8c54-c87a2fd2ef90",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/73fbfcf2-90cc-4d47-bfa5-15970c21f10d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T09:38:31Z`
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







