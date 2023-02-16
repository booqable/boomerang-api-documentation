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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e5c2d3b1-9344-4bb7-bed4-89acfc4df01c&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-3fdaba52-00de-57ec-b788-9769d535b80c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
          }
        }
      }
    },
    {
      "id": "virtual-8d1e8afa-16bc-53bc-a244-d0a9dd2af692",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
          }
        }
      }
    },
    {
      "id": "virtual-30277dd9-bea2-585f-8ed4-745eb4d5e6df",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
          }
        }
      }
    },
    {
      "id": "virtual-989002e0-a1e9-54ae-9cc4-291019831307",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
          }
        }
      }
    },
    {
      "id": "virtual-44167b0d-06f7-5e67-8a79-5257f0590e19",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
          }
        }
      }
    },
    {
      "id": "virtual-162ae574-03b4-5c19-8471-f8ba6f5be7a8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
          }
        }
      }
    },
    {
      "id": "virtual-ac62bab4-f33d-5cb4-bd6f-b76f9981100f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
          }
        }
      }
    },
    {
      "id": "virtual-4da3ca60-e140-5829-b90e-d8e2c8e41844",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
          }
        }
      }
    },
    {
      "id": "virtual-fc98fb85-f033-5662-b312-d51740220395",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
          }
        }
      }
    },
    {
      "id": "virtual-20061a76-fe05-5baa-9d3e-0cd1be8e5e7d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e5c2d3b1-9344-4bb7-bed4-89acfc4df01c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T22:54:52Z`
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







