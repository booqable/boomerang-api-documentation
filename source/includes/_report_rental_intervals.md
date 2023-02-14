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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=3d95f0c1-7112-4820-abfe-86c01f493a76&filter%5Btill%5D=2023-02-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-44348ef2-b25c-57b9-a8ce-3f984e616b72",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
          }
        }
      }
    },
    {
      "id": "virtual-30bae28a-0898-5aa3-87ac-5bea8ced3e32",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
          }
        }
      }
    },
    {
      "id": "virtual-38a78afc-84d5-5ecf-88e3-a2bb7ed5ca08",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
          }
        }
      }
    },
    {
      "id": "virtual-a5e601cb-2fb5-5f31-b871-aa5de44244bb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
          }
        }
      }
    },
    {
      "id": "virtual-540fee6c-f162-5210-9a5f-75e1cbaea889",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
          }
        }
      }
    },
    {
      "id": "virtual-165c1eb7-52d8-50bd-ad39-bb5c22298caa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
          }
        }
      }
    },
    {
      "id": "virtual-c65329be-dcc6-56f3-a566-9964adb61782",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
          }
        }
      }
    },
    {
      "id": "virtual-7bc84cbd-bac5-53c8-b9ef-5843621572e7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
          }
        }
      }
    },
    {
      "id": "virtual-b9624153-7398-5b54-9cb0-1141e2ce6c4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
          }
        }
      }
    },
    {
      "id": "virtual-051ff9c4-cd8d-5ee3-8aee-1f7368275128",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d95f0c1-7112-4820-abfe-86c01f493a76"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3d95f0c1-7112-4820-abfe-86c01f493a76"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:03:31Z`
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







