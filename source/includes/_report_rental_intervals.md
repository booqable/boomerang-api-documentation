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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-19+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=ae235fa5-567b-403f-85eb-642a141dd2f2&filter%5Btill%5D=2023-02-28+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e1a5b49d-a6db-5f8d-81af-c6e85dc2da33",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
          }
        }
      }
    },
    {
      "id": "virtual-51425961-e95f-5523-87cb-9f14590a47ed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
          }
        }
      }
    },
    {
      "id": "virtual-858b116f-be4c-5f3c-9938-7390b0463c62",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
          }
        }
      }
    },
    {
      "id": "virtual-397644bb-dafa-50f4-b820-918238fc1b6f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
          }
        }
      }
    },
    {
      "id": "virtual-5ee1262e-3334-5f73-a08e-47d953753941",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
          }
        }
      }
    },
    {
      "id": "virtual-6d200b78-cd9a-5efc-a434-e71e2b70c7c3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
          }
        }
      }
    },
    {
      "id": "virtual-592497a0-abc3-51ce-999d-a27e545f095f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
          }
        }
      }
    },
    {
      "id": "virtual-6418953e-2cf5-5326-a2fa-e3ab0c46faff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
          }
        }
      }
    },
    {
      "id": "virtual-4bd111c8-cb5d-52ca-ba8e-802051d2582e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
          }
        }
      }
    },
    {
      "id": "virtual-a7f3f6ea-c413-5ad6-82c5-cd4bc1268670",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ae235fa5-567b-403f-85eb-642a141dd2f2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ae235fa5-567b-403f-85eb-642a141dd2f2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:47:53Z`
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







