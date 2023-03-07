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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=139726c7-fa8f-41cf-8703-1ff0120927e9&filter%5Btill%5D=2023-03-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-6325f01e-d1c3-580f-b581-bfc76b2bac8c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
          }
        }
      }
    },
    {
      "id": "virtual-57274ea5-07b2-52f8-b195-8f584d052f6c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
          }
        }
      }
    },
    {
      "id": "virtual-02f6bb63-01a7-5cbf-b02d-f15e47d3f7ce",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
          }
        }
      }
    },
    {
      "id": "virtual-07beb8a3-bb36-5e6e-a9cf-fc71a8c14ca9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
          }
        }
      }
    },
    {
      "id": "virtual-f80a1325-4af4-5c63-9bd5-1d8523fb494d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
          }
        }
      }
    },
    {
      "id": "virtual-77c48354-5371-5576-bff9-a053e137539b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
          }
        }
      }
    },
    {
      "id": "virtual-c71a4c7f-7841-5b56-8868-b9296d8fda28",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
          }
        }
      }
    },
    {
      "id": "virtual-a2dfaf22-c273-5467-be88-98ef267202c1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
          }
        }
      }
    },
    {
      "id": "virtual-5b4dbfcf-9ff7-5f33-8df6-68c20687f1fe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
          }
        }
      }
    },
    {
      "id": "virtual-358b16a3-2f3c-52eb-9aa9-de6e98126b9d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "139726c7-fa8f-41cf-8703-1ff0120927e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/139726c7-fa8f-41cf-8703-1ff0120927e9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T11:18:07Z`
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







