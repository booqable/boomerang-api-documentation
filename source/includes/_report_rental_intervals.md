# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-05+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=25910086-e38f-4a8b-9fea-4915352a3702&filter%5Btill%5D=2022-07-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-d6cabaf6-b480-5442-8fe7-c1cef068335c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
          }
        }
      }
    },
    {
      "id": "virtual-59571469-11f0-5fdf-bb66-d4efeaa95f2a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
          }
        }
      }
    },
    {
      "id": "virtual-4729223f-d37d-57ae-a45c-feee8f5ee767",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
          }
        }
      }
    },
    {
      "id": "virtual-bc4b9104-13df-5243-8269-8ad27609ef05",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
          }
        }
      }
    },
    {
      "id": "virtual-0e7548dd-1ae0-5508-8e10-19f44d169d38",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
          }
        }
      }
    },
    {
      "id": "virtual-36acf107-b577-55dd-865b-fca1a206a359",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
          }
        }
      }
    },
    {
      "id": "virtual-5a2997b8-c6bc-5799-bd88-106e0c2734b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
          }
        }
      }
    },
    {
      "id": "virtual-8d08f0df-155d-5900-ae00-2d06cef84fa0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
          }
        }
      }
    },
    {
      "id": "virtual-e1fe2926-d593-51e6-9daa-f42579b2bebd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
          }
        }
      }
    },
    {
      "id": "virtual-798ac174-022b-57f0-9ea6-65decc8b0d0e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25910086-e38f-4a8b-9fea-4915352a3702"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25910086-e38f-4a8b-9fea-4915352a3702"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T11:20:14Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







