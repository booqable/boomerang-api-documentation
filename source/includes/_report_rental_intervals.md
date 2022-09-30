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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-20+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb&filter%5Btill%5D=2022-09-29+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-3ce471a8-9bd6-57cf-9338-295c9b05ecb0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
          }
        }
      }
    },
    {
      "id": "virtual-d5e3c881-b862-5570-b1a7-47c8f3a0ff23",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
          }
        }
      }
    },
    {
      "id": "virtual-322578ad-85b9-5a9c-aaf2-8ded4d447f24",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
          }
        }
      }
    },
    {
      "id": "virtual-9eb7e68e-cad7-5132-a6dc-6dd5393d3c75",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
          }
        }
      }
    },
    {
      "id": "virtual-64cdc385-cde4-5042-9706-703a938731f8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
          }
        }
      }
    },
    {
      "id": "virtual-1f65960f-756d-51c6-9c1e-87c516729d73",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
          }
        }
      }
    },
    {
      "id": "virtual-2a41bcfd-f2cb-5be4-a514-c68ede0ab2a6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
          }
        }
      }
    },
    {
      "id": "virtual-f71eaa9c-af00-51c8-be0f-17204da30ccf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
          }
        }
      }
    },
    {
      "id": "virtual-1e1f43e5-6fff-5156-9b1b-5cf7bee23788",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
          }
        }
      }
    },
    {
      "id": "virtual-6bedc65a-435b-5c13-bc05-eafa2e01a4b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6f97bd6d-48bf-49bc-8ce2-5bb5dc25c7cb"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-30T11:57:11Z`
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







