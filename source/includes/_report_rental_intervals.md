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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b88d2115-15f2-4d3b-89e8-567dd4fbb5e8&filter%5Btill%5D=2023-02-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-9b35896c-4816-5ffd-8916-25173bb2c2e1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
          }
        }
      }
    },
    {
      "id": "virtual-5b75f3af-78ec-55e3-b966-0e12becfffff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
          }
        }
      }
    },
    {
      "id": "virtual-223091e0-1958-5f9e-b44b-808c859f20f1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
          }
        }
      }
    },
    {
      "id": "virtual-0303b49c-7055-5a16-994c-1e3306296f91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
          }
        }
      }
    },
    {
      "id": "virtual-63ebbab4-1264-5360-b62e-97b990f8eb91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
          }
        }
      }
    },
    {
      "id": "virtual-5f9fc974-c715-5f75-b070-32a06514822d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
          }
        }
      }
    },
    {
      "id": "virtual-94235548-e16d-5304-a192-cde7eab4bdab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
          }
        }
      }
    },
    {
      "id": "virtual-79476402-8fea-54b6-a5c6-f85d57495a19",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
          }
        }
      }
    },
    {
      "id": "virtual-28ac5dcd-0685-572b-a41d-7caab8660f44",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
          }
        }
      }
    },
    {
      "id": "virtual-5585b74e-6273-5b6e-ab9c-07b85f540023",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b88d2115-15f2-4d3b-89e8-567dd4fbb5e8"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T08:13:41Z`
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







