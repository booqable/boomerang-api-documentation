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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=97468c95-5f5f-4526-9ee4-896208d219f1&filter%5Btill%5D=2022-11-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8681b438-d543-54a0-9f9c-de82323dee3d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
          }
        }
      }
    },
    {
      "id": "virtual-4fadaeaf-e9ab-5910-acdd-8e69330f20a6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
          }
        }
      }
    },
    {
      "id": "virtual-25925c25-4dc7-59e6-9066-c533001196cd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
          }
        }
      }
    },
    {
      "id": "virtual-e2fd1157-384a-585c-958b-155d234096db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
          }
        }
      }
    },
    {
      "id": "virtual-a0f2cb3b-40d0-5ff1-94c6-e68236cff8d1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
          }
        }
      }
    },
    {
      "id": "virtual-837c0230-c52b-5a29-a012-28fac6f5277f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
          }
        }
      }
    },
    {
      "id": "virtual-31002087-f5b2-5d1b-8966-78734e0807dd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
          }
        }
      }
    },
    {
      "id": "virtual-36efe007-00b0-5a15-a7ae-d346620cdba0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
          }
        }
      }
    },
    {
      "id": "virtual-c1840a7c-653a-5c84-96c7-1f8fd25d62b9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
          }
        }
      }
    },
    {
      "id": "virtual-acf1f694-056e-5187-908a-a6e1fc9435c8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "97468c95-5f5f-4526-9ee4-896208d219f1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/97468c95-5f5f-4526-9ee4-896208d219f1"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T17:42:25Z`
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







