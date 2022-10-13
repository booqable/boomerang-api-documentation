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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5&filter%5Btill%5D=2022-10-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-54a41465-565b-59d7-9ab3-09545385509a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
          }
        }
      }
    },
    {
      "id": "virtual-1ab5f5dd-4318-5873-b04a-d6f100f8e998",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
          }
        }
      }
    },
    {
      "id": "virtual-667bdc11-ca26-5305-a53c-1d6d9986105b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
          }
        }
      }
    },
    {
      "id": "virtual-222b2081-2764-5750-b74c-2cffeae11fc2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
          }
        }
      }
    },
    {
      "id": "virtual-852a1a2b-7b8a-5529-af49-6ea7f538b419",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
          }
        }
      }
    },
    {
      "id": "virtual-4e82b0a3-8a00-56dd-a6f6-e45a484a06b4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
          }
        }
      }
    },
    {
      "id": "virtual-acccc9f9-b2ff-522c-a294-0ac97337b869",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
          }
        }
      }
    },
    {
      "id": "virtual-162814b2-ebb8-5d0f-895e-b782af993826",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
          }
        }
      }
    },
    {
      "id": "virtual-f1f8ef6c-0397-51db-9c76-b371e961d0a6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
          }
        }
      }
    },
    {
      "id": "virtual-2fc4da22-5a09-5dec-8dbd-6fd775ffd80b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a3f10fc4-3f73-45c0-bad6-7c75a3ebc5c5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T08:55:37Z`
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







