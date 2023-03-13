# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-03-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b38f072e-6451-48c0-b7f9-fb0e9727fce6&filter%5Btill%5D=2023-03-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-df3de498-09f4-50ec-8f24-30eb9cd99a23",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
          }
        }
      }
    },
    {
      "id": "virtual-a7dc26d5-cf02-5ae2-9481-b00bbd4e4b8c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
          }
        }
      }
    },
    {
      "id": "virtual-fe09e188-caa9-5b80-aad4-5f286ed5e87c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
          }
        }
      }
    },
    {
      "id": "virtual-132a6ec6-235b-5a9a-ba9c-37368ed213cb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
          }
        }
      }
    },
    {
      "id": "virtual-678bec4f-a5b5-54bd-842a-0cf69c0141a8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
          }
        }
      }
    },
    {
      "id": "virtual-0f6af257-3e44-5ccd-ba9b-1b2c30ad27d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
          }
        }
      }
    },
    {
      "id": "virtual-25abb1fd-75e4-51ef-8c93-9d8712299844",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
          }
        }
      }
    },
    {
      "id": "virtual-8e3b54c5-4ea5-5859-99ea-16ee1db9bca5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
          }
        }
      }
    },
    {
      "id": "virtual-af5cc403-18da-538f-9ab0-334493f6f3ae",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
          }
        }
      }
    },
    {
      "id": "virtual-49b29540-f337-5d8f-b7d6-4cc6aaab0e07",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38f072e-6451-48c0-b7f9-fb0e9727fce6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b38f072e-6451-48c0-b7f9-fb0e9727fce6"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-13T07:49:20Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







