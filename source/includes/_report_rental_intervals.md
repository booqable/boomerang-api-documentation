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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=523fbde9-d4a1-4067-bc9a-1786a0e27d48&filter%5Btill%5D=2023-02-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-3c9df710-ade9-5065-bdd7-1d8b842c19b2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
          }
        }
      }
    },
    {
      "id": "virtual-2a2af27a-4e59-588e-9c74-c716829df49f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
          }
        }
      }
    },
    {
      "id": "virtual-e48f0960-2042-5bc0-8cdc-69e8a8c09bec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
          }
        }
      }
    },
    {
      "id": "virtual-fda89e1e-d115-54ff-be07-f359226365de",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
          }
        }
      }
    },
    {
      "id": "virtual-2e62a284-7287-57c2-9c25-d474c91d6a7d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
          }
        }
      }
    },
    {
      "id": "virtual-91854832-7043-5293-95b4-b8685f671116",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
          }
        }
      }
    },
    {
      "id": "virtual-f928c944-facd-5e6d-9fe2-935212310e42",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
          }
        }
      }
    },
    {
      "id": "virtual-dacea829-fa1f-5975-a5ec-4b47e9dedae1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
          }
        }
      }
    },
    {
      "id": "virtual-d590aec1-704c-57ce-9c36-027c74070bdc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
          }
        }
      }
    },
    {
      "id": "virtual-234c5952-d72e-587f-80f0-05482e5ad961",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "523fbde9-d4a1-4067-bc9a-1786a0e27d48"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/523fbde9-d4a1-4067-bc9a-1786a0e27d48"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:51:57Z`
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







