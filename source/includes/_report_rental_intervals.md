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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=1e564737-b927-48d7-a4c1-9018bcb40920&filter%5Btill%5D=2022-11-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-638e284a-4f6c-5149-b95c-9bf63a2eaf92",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
          }
        }
      }
    },
    {
      "id": "virtual-b9bf3cbe-c0e6-55af-8303-2ed5e2b94eb6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
          }
        }
      }
    },
    {
      "id": "virtual-94d15b58-fa5a-532b-9f0a-7975d24c30b5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
          }
        }
      }
    },
    {
      "id": "virtual-8be8f85c-bbb5-5a64-a2a0-71570cf23273",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
          }
        }
      }
    },
    {
      "id": "virtual-2e0fce69-5ba1-50ec-9544-937c02c5768c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
          }
        }
      }
    },
    {
      "id": "virtual-4aa4347c-45c1-5420-9785-b2b1397d94c4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
          }
        }
      }
    },
    {
      "id": "virtual-ea47eb54-e8cb-5e3d-b91f-2117dc38b18d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
          }
        }
      }
    },
    {
      "id": "virtual-82ee10a6-31c3-5e79-8bdf-e2f739ad2462",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
          }
        }
      }
    },
    {
      "id": "virtual-72d4b42d-eea0-5fa8-8f03-189c25dd3e2b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
          }
        }
      }
    },
    {
      "id": "virtual-63ef2fe1-3fe3-5903-9baf-c94b39996258",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1e564737-b927-48d7-a4c1-9018bcb40920"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1e564737-b927-48d7-a4c1-9018bcb40920"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T15:49:26Z`
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







