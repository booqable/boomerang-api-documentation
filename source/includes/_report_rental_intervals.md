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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e615cf51-7e87-4e40-8bf7-64264d424072&filter%5Btill%5D=2022-11-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-610a59ff-ed4e-53ff-9383-ed1f2ed1a0e1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
          }
        }
      }
    },
    {
      "id": "virtual-6a32bad1-25d7-5f21-a16a-1556cc0eb4fc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
          }
        }
      }
    },
    {
      "id": "virtual-66f3c4c6-0c18-543f-bbb8-f3ed183adec0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
          }
        }
      }
    },
    {
      "id": "virtual-f27e6364-792b-5ee2-9446-90559b9e629f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
          }
        }
      }
    },
    {
      "id": "virtual-1e44cf4c-609d-59d8-b1f7-e73f51c3fe3d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
          }
        }
      }
    },
    {
      "id": "virtual-1789b416-6b1d-5776-af75-eb09c690e896",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
          }
        }
      }
    },
    {
      "id": "virtual-466dcce6-8d7a-525d-ab4c-282d752c4d1f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
          }
        }
      }
    },
    {
      "id": "virtual-4261b599-c2db-5535-ab50-a2182b921c5e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
          }
        }
      }
    },
    {
      "id": "virtual-5d16168a-3ad2-5a74-8807-f5300a905b5b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
          }
        }
      }
    },
    {
      "id": "virtual-bd22636e-87c3-521e-9bd3-8f80dba4fedb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e615cf51-7e87-4e40-8bf7-64264d424072"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e615cf51-7e87-4e40-8bf7-64264d424072"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T15:31:34Z`
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







