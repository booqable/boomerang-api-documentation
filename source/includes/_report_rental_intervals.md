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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=179e5489-3cae-4253-8ed4-d5d42f10e378&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-42f36730-76a1-5cf2-8c34-7e7f4a5f858b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
          }
        }
      }
    },
    {
      "id": "virtual-40ec919f-9dce-52ae-905d-0d7cfbc4a585",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
          }
        }
      }
    },
    {
      "id": "virtual-f247502e-7be1-5539-b5f3-31a94e2f6175",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
          }
        }
      }
    },
    {
      "id": "virtual-24d8e4ef-82d0-5090-b22e-934a8c22ebb3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
          }
        }
      }
    },
    {
      "id": "virtual-eb2ee35e-23b2-53ee-b255-6c4baa63b28c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
          }
        }
      }
    },
    {
      "id": "virtual-0f738767-648e-50cf-bfc2-d83b51c96376",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
          }
        }
      }
    },
    {
      "id": "virtual-e14c6113-6a97-5739-ba92-7218712469fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
          }
        }
      }
    },
    {
      "id": "virtual-7c671bc4-c2b9-5530-b890-22ff194b9b84",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
          }
        }
      }
    },
    {
      "id": "virtual-7e330524-9407-5016-a377-0b053da0a3e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
          }
        }
      }
    },
    {
      "id": "virtual-a8eea3af-632f-503c-bf9b-9f6012a58a77",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "179e5489-3cae-4253-8ed4-d5d42f10e378"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/179e5489-3cae-4253-8ed4-d5d42f10e378"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:27:50Z`
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







