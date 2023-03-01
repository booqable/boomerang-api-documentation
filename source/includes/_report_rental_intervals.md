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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-19+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=aad39eec-e247-41b9-ba1b-dba4000cc5af&filter%5Btill%5D=2023-02-28+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-37d7bb81-6737-586d-9292-75854424afd5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
          }
        }
      }
    },
    {
      "id": "virtual-151ebf85-e5e9-5f1d-ac76-358a1de09e1c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
          }
        }
      }
    },
    {
      "id": "virtual-29804377-d448-5772-9da6-f1f83d2d9bb5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
          }
        }
      }
    },
    {
      "id": "virtual-0e0d5cfe-63da-5952-a3e5-50a69e3b05da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
          }
        }
      }
    },
    {
      "id": "virtual-b9e19261-29d3-5a5a-a940-333672ee0baf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
          }
        }
      }
    },
    {
      "id": "virtual-40e81faa-d586-5cb6-98cc-2fd9217283bf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
          }
        }
      }
    },
    {
      "id": "virtual-339f05c1-b5b4-5f50-a3fb-4cb4b56941b1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
          }
        }
      }
    },
    {
      "id": "virtual-5e85c2c5-220a-56c3-a20e-7ba76accc9ce",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
          }
        }
      }
    },
    {
      "id": "virtual-ad8f572f-8c0f-536a-911c-0b333904c349",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
          }
        }
      }
    },
    {
      "id": "virtual-58f822bc-f40f-5b77-a5a9-e8ab6e756a37",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aad39eec-e247-41b9-ba1b-dba4000cc5af"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aad39eec-e247-41b9-ba1b-dba4000cc5af"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T10:30:12Z`
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







