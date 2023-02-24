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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b21f4095-7921-4c4e-93eb-8c1390395214&filter%5Btill%5D=2023-02-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0ffdd9ef-b7c7-5e02-8ce7-173ce1c47a4b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
          }
        }
      }
    },
    {
      "id": "virtual-28de1ecf-0aeb-5306-9de2-a150befca548",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
          }
        }
      }
    },
    {
      "id": "virtual-24360ce4-3fcd-5423-b15b-8bbe240a0d21",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
          }
        }
      }
    },
    {
      "id": "virtual-d34d2363-3dd9-5486-85d0-c620991347b4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
          }
        }
      }
    },
    {
      "id": "virtual-b2e4108b-3479-5d28-945b-958240675566",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
          }
        }
      }
    },
    {
      "id": "virtual-1bf5fe21-954d-576d-b41a-9672abcb520a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
          }
        }
      }
    },
    {
      "id": "virtual-f9643502-59f1-5a36-aaa3-c515b21df5f4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
          }
        }
      }
    },
    {
      "id": "virtual-a72c1169-148c-5e88-80d6-60472e8b676b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
          }
        }
      }
    },
    {
      "id": "virtual-c2f410ad-06b4-50fa-85da-13dbdb2088c6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
          }
        }
      }
    },
    {
      "id": "virtual-2c49a8d5-d35c-5c0c-808e-0e5ce6be11e6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b21f4095-7921-4c4e-93eb-8c1390395214"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b21f4095-7921-4c4e-93eb-8c1390395214"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T14:54:59Z`
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







