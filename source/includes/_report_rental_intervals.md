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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-22+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=563cbfef-1210-492e-9899-39693384e46f&filter%5Btill%5D=2023-01-31+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-2ba8534a-806e-511d-981b-15bbbcf069e9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
          }
        }
      }
    },
    {
      "id": "virtual-3c0309e1-50c2-5d54-8676-bfc05d5ffe0f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
          }
        }
      }
    },
    {
      "id": "virtual-0e80f355-e75f-5f98-8dcb-0c799e2ac253",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
          }
        }
      }
    },
    {
      "id": "virtual-a5106e70-e669-5885-95ed-49c5e635106d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
          }
        }
      }
    },
    {
      "id": "virtual-80a1ab8b-cacd-5be4-9d5f-67e6eb08bdd9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
          }
        }
      }
    },
    {
      "id": "virtual-93a401e5-b9ad-5c5e-bbb2-39e77be550b2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
          }
        }
      }
    },
    {
      "id": "virtual-1dc2af03-ef2e-59c0-ac9e-c29913e9c78c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
          }
        }
      }
    },
    {
      "id": "virtual-51d129f8-5250-5a32-b80c-47810c98f57f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
          }
        }
      }
    },
    {
      "id": "virtual-1745180a-6348-59aa-9433-ebfadaabcfcf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
          }
        }
      }
    },
    {
      "id": "virtual-55bc9327-4a04-5dbd-bf3c-3e481bb7ed43",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "563cbfef-1210-492e-9899-39693384e46f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/563cbfef-1210-492e-9899-39693384e46f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:17:11Z`
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







