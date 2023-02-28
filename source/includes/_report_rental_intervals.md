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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-18+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d&filter%5Btill%5D=2023-02-27+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-171e31ea-e01a-5d34-859a-cab048de9b1c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
          }
        }
      }
    },
    {
      "id": "virtual-d7f18a00-4251-53c2-be78-2d3fb84a049c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
          }
        }
      }
    },
    {
      "id": "virtual-7ebe477c-6a63-5bfe-9bfc-ffe4e63a3647",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
          }
        }
      }
    },
    {
      "id": "virtual-a39bbb51-180d-5e81-a45f-53cc5df13509",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
          }
        }
      }
    },
    {
      "id": "virtual-92898611-f6ba-5296-a11a-5eccfc53aa30",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
          }
        }
      }
    },
    {
      "id": "virtual-4c332fb3-ef2d-51a9-933e-55dc26771dc5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
          }
        }
      }
    },
    {
      "id": "virtual-aa8bec17-d7df-5cbd-bdb2-d1e7046629c6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
          }
        }
      }
    },
    {
      "id": "virtual-ba5775a8-cc01-5be3-9ed3-baf0285af32a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
          }
        }
      }
    },
    {
      "id": "virtual-1a3a46e4-ddd9-5631-84e8-54bc01a7542a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
          }
        }
      }
    },
    {
      "id": "virtual-283d0c89-7d22-57c6-9d22-de86616ab36e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cf3ff53f-d3e1-4891-bb5a-1ee9e084fe8d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T11:25:30Z`
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







