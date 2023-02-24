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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=5a8a4a71-b540-4127-a161-cd2e8e49fd6a&filter%5Btill%5D=2023-02-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-3621c6a0-adde-5b24-9df7-d5b16b515dff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
          }
        }
      }
    },
    {
      "id": "virtual-7b37f165-98ed-5e0f-8b66-44709226ca97",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
          }
        }
      }
    },
    {
      "id": "virtual-d2498e09-8d0e-5085-b378-70df5fa981cb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
          }
        }
      }
    },
    {
      "id": "virtual-695118f4-aa3a-5432-9c5b-2f2c57bf8d69",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
          }
        }
      }
    },
    {
      "id": "virtual-381ee416-becd-52f3-9af7-6a100476bb23",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
          }
        }
      }
    },
    {
      "id": "virtual-acede01e-2dd6-5c32-b0a5-30a2b72dc809",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
          }
        }
      }
    },
    {
      "id": "virtual-fa70eec4-d7d4-5a16-9343-ac7172edfc2c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
          }
        }
      }
    },
    {
      "id": "virtual-a3e8186f-f864-5593-ac3c-c43d729c6817",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
          }
        }
      }
    },
    {
      "id": "virtual-27b3ac19-f4b8-5c3c-8c48-0a404a38d43c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
          }
        }
      }
    },
    {
      "id": "virtual-4b811d9a-0b79-5fee-aea1-9a818919ff89",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5a8a4a71-b540-4127-a161-cd2e8e49fd6a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:21Z`
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







