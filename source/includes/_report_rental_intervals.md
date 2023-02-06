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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=bb700605-9d0c-4c81-9c19-8c62332cb437&filter%5Btill%5D=2023-02-05+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0d0ea8e0-218d-509c-8bcb-df1ef4d33a42",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
          }
        }
      }
    },
    {
      "id": "virtual-a5a8a16c-2990-5975-a305-15a50fd43c29",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
          }
        }
      }
    },
    {
      "id": "virtual-158727ff-e591-560c-8dee-67ed336d8b85",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
          }
        }
      }
    },
    {
      "id": "virtual-64caf68d-ba1d-55e5-8288-6bc4e0b7a00e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
          }
        }
      }
    },
    {
      "id": "virtual-2b16d706-73e0-5565-8a6f-1797255c4ff2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
          }
        }
      }
    },
    {
      "id": "virtual-41c88fdc-9695-538e-93a1-77fea889a30c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
          }
        }
      }
    },
    {
      "id": "virtual-8a75532b-aaa7-52ff-9e60-bc3cfc17fbc1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
          }
        }
      }
    },
    {
      "id": "virtual-c90c704c-0fba-50db-86f7-e093ee784916",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
          }
        }
      }
    },
    {
      "id": "virtual-481f577f-84cf-5953-b794-0b376e2d7e3d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
          }
        }
      }
    },
    {
      "id": "virtual-1a9ed039-38c2-5a21-a155-a677437e1a8e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bb700605-9d0c-4c81-9c19-8c62332cb437"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bb700605-9d0c-4c81-9c19-8c62332cb437"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T08:46:51Z`
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







