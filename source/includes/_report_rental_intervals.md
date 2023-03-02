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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-20+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=83d0d031-1ebb-42cd-9869-aaa34e9a0575&filter%5Btill%5D=2023-03-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0afa51c6-36cc-5bbe-b18d-714d76d7a0bc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
          }
        }
      }
    },
    {
      "id": "virtual-2b5f73bb-20a0-57a6-ab49-9fbbb3efb3ab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
          }
        }
      }
    },
    {
      "id": "virtual-f57a73c5-8555-59e5-8598-6b29456a25cb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
          }
        }
      }
    },
    {
      "id": "virtual-409df585-fefb-5ed2-9411-51c6598c88eb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
          }
        }
      }
    },
    {
      "id": "virtual-b1be7855-7507-5376-9841-2f05a0a88407",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
          }
        }
      }
    },
    {
      "id": "virtual-c03581de-f123-5124-827c-fd2a7a02feb8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
          }
        }
      }
    },
    {
      "id": "virtual-c17ff9dc-566f-55f9-8954-f62ce37b4c31",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
          }
        }
      }
    },
    {
      "id": "virtual-cf4b4611-1782-5319-a194-a45214843ea2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
          }
        }
      }
    },
    {
      "id": "virtual-0da391de-7f78-5faf-8fac-59d3ffb5f4d0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
          }
        }
      }
    },
    {
      "id": "virtual-775fed8a-d4bc-5fcb-a53d-0dcc52d4a1d6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "83d0d031-1ebb-42cd-9869-aaa34e9a0575"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/83d0d031-1ebb-42cd-9869-aaa34e9a0575"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T11:06:51Z`
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







