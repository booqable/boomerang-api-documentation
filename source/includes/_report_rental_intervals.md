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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c7dbcea4-9b73-438f-a603-158685c48e2c&filter%5Btill%5D=2022-11-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b9bb0bd3-015b-5c6b-85f7-6b7fda49813e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
          }
        }
      }
    },
    {
      "id": "virtual-3b2060a1-1f98-5508-86ae-05fd315c2073",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
          }
        }
      }
    },
    {
      "id": "virtual-6dc42e0f-f85e-5b42-b5cd-fef899875813",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
          }
        }
      }
    },
    {
      "id": "virtual-74911bd2-8ab8-5e1b-b168-6b4488ce02e5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
          }
        }
      }
    },
    {
      "id": "virtual-8789a83c-6fd8-59b7-bd52-223f6f08c1db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
          }
        }
      }
    },
    {
      "id": "virtual-8efe7039-af75-5090-9b3b-d1f2a1620006",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
          }
        }
      }
    },
    {
      "id": "virtual-168f14d7-5fa7-512a-b9de-dc751d2fd872",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
          }
        }
      }
    },
    {
      "id": "virtual-073fb470-a436-50ee-8405-0af9c549a6f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
          }
        }
      }
    },
    {
      "id": "virtual-8710d027-d7cb-5ba0-8efd-b348cb26c823",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
          }
        }
      }
    },
    {
      "id": "virtual-a3c26906-5c08-57f2-9b46-78d97f17b1f3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c7dbcea4-9b73-438f-a603-158685c48e2c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c7dbcea4-9b73-438f-a603-158685c48e2c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-16T14:30:09Z`
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







