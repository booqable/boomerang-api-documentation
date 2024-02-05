# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-01-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=537c9b1e-6f3f-40bb-bff3-ad63daae78ed&filter%5Btill%5D=2024-02-04+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a6f059bf-06d6-4541-8336-9e1079d51c44",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
          }
        }
      }
    },
    {
      "id": "6e171c95-fd71-432b-8aaa-93642f4353a7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
          }
        }
      }
    },
    {
      "id": "cb943a41-ca20-4fc6-b530-09dc26f2b3b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
          }
        }
      }
    },
    {
      "id": "945a1c78-4939-4d3e-b731-b85239329c11",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
          }
        }
      }
    },
    {
      "id": "424c9d89-4f97-4982-8903-bfd04b00de71",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
          }
        }
      }
    },
    {
      "id": "412912bd-068e-4a24-a70f-19c070873f37",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
          }
        }
      }
    },
    {
      "id": "2a4db77d-7a71-4648-98a6-28889c1b7465",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
          }
        }
      }
    },
    {
      "id": "b63cc933-f50e-47d5-92a0-42675820131a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
          }
        }
      }
    },
    {
      "id": "21d94587-a75f-46f6-8446-e0f4e2d9de9f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
          }
        }
      }
    },
    {
      "id": "9e4f750b-49dc-43ee-bc51-b81612895aa4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/537c9b1e-6f3f-40bb-bff3-ad63daae78ed"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







