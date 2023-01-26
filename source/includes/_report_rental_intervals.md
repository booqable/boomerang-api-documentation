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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-16+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e7f383e0-a996-4dbc-a6be-fbc3371b8e3a&filter%5Btill%5D=2023-01-25+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-436c4d44-32f2-5d0f-97d2-87e240d493ca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
          }
        }
      }
    },
    {
      "id": "virtual-414791ea-3ad7-505e-af08-ed8faf17cd5b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
          }
        }
      }
    },
    {
      "id": "virtual-be527592-705d-5d80-88f0-2304f620d2c6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
          }
        }
      }
    },
    {
      "id": "virtual-a072662a-90ad-5662-9915-a853a880c7b1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
          }
        }
      }
    },
    {
      "id": "virtual-bb72b781-9a95-5214-be6c-a9f446027a69",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
          }
        }
      }
    },
    {
      "id": "virtual-aadcca85-8c33-5f63-a4dd-9b0fc69296b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
          }
        }
      }
    },
    {
      "id": "virtual-01ef27c7-dba5-5bac-8a70-b60ccee14cc6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
          }
        }
      }
    },
    {
      "id": "virtual-09dcd7e2-dab1-54c8-b2c0-d40ce8a7d355",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
          }
        }
      }
    },
    {
      "id": "virtual-948d4dcf-527c-540c-a348-80271a6ff165",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
          }
        }
      }
    },
    {
      "id": "virtual-d9ea293d-8778-5eb8-bc66-f1dcd15dc272",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7f383e0-a996-4dbc-a6be-fbc3371b8e3a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T12:15:33Z`
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







