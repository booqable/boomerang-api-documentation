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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-20+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=689804ac-a167-47eb-8784-b99d127dafcb&filter%5Btill%5D=2023-03-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c7cf79fc-3fe8-511d-8ce2-143612b1b56c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
          }
        }
      }
    },
    {
      "id": "virtual-c1216be8-a267-5a0a-9a8a-f0248b53beb6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
          }
        }
      }
    },
    {
      "id": "virtual-9a72c374-49f6-5fd6-ae65-b0fc6f035e7a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
          }
        }
      }
    },
    {
      "id": "virtual-75b7e5ba-0625-5c0a-899b-379e9625990d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
          }
        }
      }
    },
    {
      "id": "virtual-83bdff08-568e-5ed3-878f-b96c9365ea6d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
          }
        }
      }
    },
    {
      "id": "virtual-7b83318e-cea0-548b-a98b-751e90c02740",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
          }
        }
      }
    },
    {
      "id": "virtual-b09e1255-119b-57dd-90cd-f15258de3eba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
          }
        }
      }
    },
    {
      "id": "virtual-7c285ed2-c36a-5078-9241-4eb3975220e1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
          }
        }
      }
    },
    {
      "id": "virtual-ffc1f99b-d4b8-5a49-bd7d-2be30dd8b27e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
          }
        }
      }
    },
    {
      "id": "virtual-36af32f6-21d1-5666-8e5b-b6e4ef6d0a7f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "689804ac-a167-47eb-8784-b99d127dafcb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/689804ac-a167-47eb-8784-b99d127dafcb"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T12:18:44Z`
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







