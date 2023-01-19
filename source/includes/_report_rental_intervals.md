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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-09+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=9d446a54-41e7-4e31-9db8-9f8090ae24d3&filter%5Btill%5D=2023-01-18+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-2c18f0d8-f2fb-5399-bea7-ba642bfc1ecc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
          }
        }
      }
    },
    {
      "id": "virtual-de1b522d-effe-5f25-af95-934b36dc7ae3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
          }
        }
      }
    },
    {
      "id": "virtual-c470e583-6f34-5880-987a-9c0d5a069e6a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
          }
        }
      }
    },
    {
      "id": "virtual-58068615-8da0-5440-adaf-98c2e3766296",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
          }
        }
      }
    },
    {
      "id": "virtual-6c631464-d373-55d6-9878-f8d6e164d3cd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
          }
        }
      }
    },
    {
      "id": "virtual-d351970f-7fbe-58ea-8d18-87232cf36883",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
          }
        }
      }
    },
    {
      "id": "virtual-74bdff70-7a50-52e9-b5af-5c0b67d9b9ca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
          }
        }
      }
    },
    {
      "id": "virtual-d5d172e2-64b3-53bd-865a-4d0374d709be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
          }
        }
      }
    },
    {
      "id": "virtual-a5ff8f6b-7e64-5988-8b13-0e8f18ad8b26",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
          }
        }
      }
    },
    {
      "id": "virtual-0e22ada6-2390-5749-b02e-5071e4efdbc9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9d446a54-41e7-4e31-9db8-9f8090ae24d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9d446a54-41e7-4e31-9db8-9f8090ae24d3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-19T10:45:10Z`
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







