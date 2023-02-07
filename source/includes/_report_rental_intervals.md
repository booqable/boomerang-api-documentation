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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=d3e8733c-0339-44f9-9205-ecb5007ce98f&filter%5Btill%5D=2023-02-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e3f9d120-f4d4-55d8-aaf0-179293d49f02",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
          }
        }
      }
    },
    {
      "id": "virtual-38aa6787-951f-5221-b2c9-a24544331acc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
          }
        }
      }
    },
    {
      "id": "virtual-027e9e96-53f9-5da4-9738-b68e4c9b3525",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
          }
        }
      }
    },
    {
      "id": "virtual-8e8a5704-b868-5f87-9a69-e397e837c6ac",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
          }
        }
      }
    },
    {
      "id": "virtual-37d5039f-bbf8-5316-952a-18b107f6df2d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
          }
        }
      }
    },
    {
      "id": "virtual-9feadb20-de0a-519c-a8ff-5819e31e5366",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
          }
        }
      }
    },
    {
      "id": "virtual-6df0375c-ce35-57d9-b77e-bdb4912091e5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
          }
        }
      }
    },
    {
      "id": "virtual-7379112c-57de-527b-a812-a794cee1df11",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
          }
        }
      }
    },
    {
      "id": "virtual-29693b11-903b-57d4-9d80-2b980fdb74ea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
          }
        }
      }
    },
    {
      "id": "virtual-7b3ca2e3-e226-51a9-a4ab-02a88dd65f89",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d3e8733c-0339-44f9-9205-ecb5007ce98f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d3e8733c-0339-44f9-9205-ecb5007ce98f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:49:43Z`
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







