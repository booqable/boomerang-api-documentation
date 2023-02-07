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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=6c96825f-63cc-482a-b989-87c9d26f9eea&filter%5Btill%5D=2023-02-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-6df9fb7f-bfa5-5669-a510-038cb9db750d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
          }
        }
      }
    },
    {
      "id": "virtual-9f35d9e1-c513-51aa-a1ea-c29d952a16e4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
          }
        }
      }
    },
    {
      "id": "virtual-a378e9c0-dfcc-5784-804f-a5a34f5686ba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
          }
        }
      }
    },
    {
      "id": "virtual-5cda8a9d-5d2f-51cf-acc9-25436fd62a40",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
          }
        }
      }
    },
    {
      "id": "virtual-fba477e9-b828-535d-b526-699ff70af611",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
          }
        }
      }
    },
    {
      "id": "virtual-7f9ccf6c-23b1-5920-9360-52953a9a23a0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
          }
        }
      }
    },
    {
      "id": "virtual-a896fb18-f875-55dc-9673-b3e49183987c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
          }
        }
      }
    },
    {
      "id": "virtual-c8ad4e91-5c7f-518e-b455-935abd1d965a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
          }
        }
      }
    },
    {
      "id": "virtual-29d220db-0b65-5a16-b646-19b0169362d3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
          }
        }
      }
    },
    {
      "id": "virtual-81af8adf-f1b7-5f80-bb2e-6fceabf80970",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6c96825f-63cc-482a-b989-87c9d26f9eea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6c96825f-63cc-482a-b989-87c9d26f9eea"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:31:45Z`
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







