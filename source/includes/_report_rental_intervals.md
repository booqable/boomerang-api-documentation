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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=124088a9-5a40-42ce-bfa0-4a97b8edc0c3&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-5ecb4f4b-c512-5d2a-ba9d-97013fac8a63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
          }
        }
      }
    },
    {
      "id": "virtual-85bcba92-2d07-578e-911d-7133c3ced303",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
          }
        }
      }
    },
    {
      "id": "virtual-89dd75df-cff1-5b27-814e-ce7c506fb554",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
          }
        }
      }
    },
    {
      "id": "virtual-72906e71-6d77-5964-bca4-44ce0943bcb1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
          }
        }
      }
    },
    {
      "id": "virtual-438d4a11-525c-511a-a8b9-5afa45cdb16d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
          }
        }
      }
    },
    {
      "id": "virtual-3e799501-e92e-5524-9696-f423c0d62539",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
          }
        }
      }
    },
    {
      "id": "virtual-3367b597-c0c5-5b03-8eae-cc9d5ab3437d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
          }
        }
      }
    },
    {
      "id": "virtual-5a5f0c4f-de3e-5d54-9ca9-2ff740269d4c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
          }
        }
      }
    },
    {
      "id": "virtual-263fa747-710b-5be6-9826-afd410c11448",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
          }
        }
      }
    },
    {
      "id": "virtual-89a27c5b-3fde-566d-b838-0829d3f8b783",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/124088a9-5a40-42ce-bfa0-4a97b8edc0c3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T19:24:49Z`
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







