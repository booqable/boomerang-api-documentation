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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-17+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4b34609f-9921-4cf9-88a2-98fcd2961918&filter%5Btill%5D=2022-09-26+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-361de53c-6798-58da-a3dd-4f118d59c36d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
          }
        }
      }
    },
    {
      "id": "virtual-6f6fa9d8-07b2-5397-b7a5-2b28e9a5c817",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
          }
        }
      }
    },
    {
      "id": "virtual-78340088-4fa1-549b-a3e3-8d35618732f9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
          }
        }
      }
    },
    {
      "id": "virtual-ca9955d0-5c0b-5812-9a58-5a80b79141e9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
          }
        }
      }
    },
    {
      "id": "virtual-ef497a14-af07-5ec8-a66b-13ea20b1a26d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
          }
        }
      }
    },
    {
      "id": "virtual-38923c5d-a6bf-5524-976b-46395b14476b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
          }
        }
      }
    },
    {
      "id": "virtual-96fd38ca-8f30-545f-a340-7b4e53653f68",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
          }
        }
      }
    },
    {
      "id": "virtual-c4737ea0-b527-51dd-8e18-fc19a9562fd6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
          }
        }
      }
    },
    {
      "id": "virtual-cc44312d-8d3b-5bbc-b727-75a693e48052",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
          }
        }
      }
    },
    {
      "id": "virtual-8fd332ae-4483-55e7-9b75-ce293ebb063a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b34609f-9921-4cf9-88a2-98fcd2961918"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b34609f-9921-4cf9-88a2-98fcd2961918"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-27T06:41:48Z`
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







