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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed&filter%5Btill%5D=2023-02-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c55f1491-997f-5852-8017-997b3e09d0ba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
          }
        }
      }
    },
    {
      "id": "virtual-035cdd7a-2437-5311-8ba6-69e8732fba91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
          }
        }
      }
    },
    {
      "id": "virtual-ce9f65b5-cf02-57d2-925f-4b43f100ee6f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
          }
        }
      }
    },
    {
      "id": "virtual-69cc1586-b7be-5c0c-9bb2-b6e943a15711",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
          }
        }
      }
    },
    {
      "id": "virtual-445321bb-d506-5131-a7ea-cfc611e4bcef",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
          }
        }
      }
    },
    {
      "id": "virtual-88655658-50ae-570a-979c-e187002dda6e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
          }
        }
      }
    },
    {
      "id": "virtual-5b78ce76-c776-5a0b-b997-68def134ca86",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
          }
        }
      }
    },
    {
      "id": "virtual-814732a9-f082-5612-82b1-ea33ba7688e7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
          }
        }
      }
    },
    {
      "id": "virtual-6a41c0de-f62b-53da-b447-aea873f2ae5c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
          }
        }
      }
    },
    {
      "id": "virtual-2e90d590-f9f4-5d15-8c29-90b9ff457f25",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa5ca0f7-2add-4cbe-8a7b-4eae2d2828ed"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T08:18:43Z`
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







