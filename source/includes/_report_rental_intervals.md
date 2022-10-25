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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-15+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0e56b1b9-0761-401a-bd99-1a5b902d8ccf&filter%5Btill%5D=2022-10-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-4d07736b-caf0-554b-a741-0967d883d1a9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
          }
        }
      }
    },
    {
      "id": "virtual-62330d50-99b8-5231-8ef8-c79038e562a9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
          }
        }
      }
    },
    {
      "id": "virtual-70c44c0e-3e1d-5cc1-9d6b-c4049f271e4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
          }
        }
      }
    },
    {
      "id": "virtual-b4be3b91-ae42-55c7-bdc1-58fc11f5968f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
          }
        }
      }
    },
    {
      "id": "virtual-f8c23ee9-a6ca-50c9-aad8-6b0c8951d014",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
          }
        }
      }
    },
    {
      "id": "virtual-02629e1f-16d5-5189-a041-aaed4026d89b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
          }
        }
      }
    },
    {
      "id": "virtual-c34a06dd-aa69-5f2c-a94a-d42a3a1dfd91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
          }
        }
      }
    },
    {
      "id": "virtual-cba6235b-9f35-58a1-9dde-1c2473c3644a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
          }
        }
      }
    },
    {
      "id": "virtual-d39e29c8-e01e-58d9-87f9-49ab585f790d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
          }
        }
      }
    },
    {
      "id": "virtual-5c313b67-e207-50dc-a3f2-155f032cb3e9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0e56b1b9-0761-401a-bd99-1a5b902d8ccf"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T16:29:21Z`
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







