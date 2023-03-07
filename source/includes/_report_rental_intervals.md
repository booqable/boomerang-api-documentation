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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2f1f33a5-4266-4bc0-aaf6-7235ce80285e&filter%5Btill%5D=2023-03-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ec95dfee-16db-5de6-ae2b-670a11782537",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
          }
        }
      }
    },
    {
      "id": "virtual-932cfb84-bfc0-512b-a281-3f44d4d88288",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
          }
        }
      }
    },
    {
      "id": "virtual-7463ca58-59a4-5ef0-9c2a-fb27c96c58a5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
          }
        }
      }
    },
    {
      "id": "virtual-f15976b3-d64d-5565-ab93-af04268561e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
          }
        }
      }
    },
    {
      "id": "virtual-ca775316-7a11-5ef6-839e-c47f16991f4d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
          }
        }
      }
    },
    {
      "id": "virtual-4ca39bea-3da5-5ca6-b192-73f3b789899e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
          }
        }
      }
    },
    {
      "id": "virtual-c1bb0d31-083c-5f13-b29d-e12d36be9850",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
          }
        }
      }
    },
    {
      "id": "virtual-f5a4b2c2-0857-512c-8021-55937d0bef01",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
          }
        }
      }
    },
    {
      "id": "virtual-2da38684-dc64-58a0-b10a-71a3d4507ebb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
          }
        }
      }
    },
    {
      "id": "virtual-0bda3c21-b8b3-540e-8cb3-1fe4f1822672",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2f1f33a5-4266-4bc0-aaf6-7235ce80285e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T11:34:32Z`
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







