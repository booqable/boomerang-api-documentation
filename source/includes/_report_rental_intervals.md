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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=d6e80165-f700-453a-8d19-542e49f37b2f&filter%5Btill%5D=2023-02-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-85c909d1-8981-5c56-8299-2a3520947bfc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
          }
        }
      }
    },
    {
      "id": "virtual-d3cf44c4-108c-5177-b127-6db5cc35683b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
          }
        }
      }
    },
    {
      "id": "virtual-babdb793-2746-5f1e-9c7c-aed623e8e168",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
          }
        }
      }
    },
    {
      "id": "virtual-2164b884-85f9-5f34-8449-1463b7437d96",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
          }
        }
      }
    },
    {
      "id": "virtual-885f76ec-ce6a-5d5e-8de8-bf4478f13978",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
          }
        }
      }
    },
    {
      "id": "virtual-1554de0e-5dd1-5210-ba9e-27c1e0dbd339",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
          }
        }
      }
    },
    {
      "id": "virtual-e1fab12e-567f-5343-bbae-61e0d6b07d77",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
          }
        }
      }
    },
    {
      "id": "virtual-38c58b66-11f4-5de3-8056-3be9975cc425",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
          }
        }
      }
    },
    {
      "id": "virtual-102a4f2d-f31a-5e56-ae76-01996f7c11d3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
          }
        }
      }
    },
    {
      "id": "virtual-6f56d72a-224a-57ea-813c-50cc9d4e259b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d6e80165-f700-453a-8d19-542e49f37b2f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d6e80165-f700-453a-8d19-542e49f37b2f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T16:04:24Z`
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







