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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-10+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d&filter%5Btill%5D=2023-02-19+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-fdf9e775-91a4-5ab0-bd3b-7f1d9fa05267",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
          }
        }
      }
    },
    {
      "id": "virtual-db164bbd-f1e9-5ca7-a1b3-5c84b500f026",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
          }
        }
      }
    },
    {
      "id": "virtual-1096148a-2ac1-5740-b7dc-f81273fa1c50",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
          }
        }
      }
    },
    {
      "id": "virtual-06317ef3-2f1c-5aad-bad8-b9760f05d74a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
          }
        }
      }
    },
    {
      "id": "virtual-c28fdca7-e342-5342-8669-c03b9fa7a5c8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
          }
        }
      }
    },
    {
      "id": "virtual-67486deb-0a6b-5937-a9bb-392e0902db11",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
          }
        }
      }
    },
    {
      "id": "virtual-e6c29417-cfb8-5a89-8a5f-610c28891135",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
          }
        }
      }
    },
    {
      "id": "virtual-58ff0c01-511d-5025-a24d-155c694a0232",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
          }
        }
      }
    },
    {
      "id": "virtual-6d174406-680d-5d51-a509-34bd5998e4e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
          }
        }
      }
    },
    {
      "id": "virtual-54ac2b9b-16b2-5956-9ea2-5899cdba4478",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8f1e93e-dc72-4ea3-bee5-9e2bbdb1546d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T10:22:25Z`
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







