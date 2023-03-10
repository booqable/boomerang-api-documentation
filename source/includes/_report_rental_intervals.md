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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=f0e5bf67-4d4a-4de5-82fd-3d8304137c51&filter%5Btill%5D=2023-03-09+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-402a505c-3601-5a4b-bfb4-0df028c57ece",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
          }
        }
      }
    },
    {
      "id": "virtual-6a066cde-899e-56cf-812c-756098900801",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
          }
        }
      }
    },
    {
      "id": "virtual-7c873c6e-3057-5bcb-98ee-7d66a4fa8ea3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
          }
        }
      }
    },
    {
      "id": "virtual-e97d38a1-c68a-588d-bb8c-dc69eb31a45e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
          }
        }
      }
    },
    {
      "id": "virtual-38540bf6-7828-585b-8437-f1fa9da64392",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
          }
        }
      }
    },
    {
      "id": "virtual-2f0ca84e-4490-598a-9e75-22894429b94a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
          }
        }
      }
    },
    {
      "id": "virtual-395568d8-1e73-5841-be61-b580e1cb91e6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
          }
        }
      }
    },
    {
      "id": "virtual-fc09d82b-715b-549c-b19e-e17ec83c4684",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
          }
        }
      }
    },
    {
      "id": "virtual-0533c298-eed6-5f3b-bb82-6dbc06a279f4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
          }
        }
      }
    },
    {
      "id": "virtual-f745401a-5154-5a73-8897-54b4c88680ca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0e5bf67-4d4a-4de5-82fd-3d8304137c51"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-10T08:36:23Z`
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







