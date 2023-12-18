# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-12-08+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=04b030a3-b626-4345-b407-a1e8662780a4&filter%5Btill%5D=2023-12-17+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "404c6409-b578-4809-bd76-1cd53e6330fe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
          }
        }
      }
    },
    {
      "id": "1a7f8398-1634-456c-bd70-22c11335a80a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
          }
        }
      }
    },
    {
      "id": "4e17d563-779e-4c98-8536-eda8d124d3c1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
          }
        }
      }
    },
    {
      "id": "088528fe-b8a5-443e-8683-c3d91128586c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
          }
        }
      }
    },
    {
      "id": "2088e2a9-b668-4640-90bf-99c1fd126be5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
          }
        }
      }
    },
    {
      "id": "a7c406f2-c11a-42b6-a212-ca929935842b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
          }
        }
      }
    },
    {
      "id": "fc5785b0-f6f0-4286-94fe-951bf54599ff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
          }
        }
      }
    },
    {
      "id": "5fd88fd6-3b0c-4aab-b590-11b43d3a72be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
          }
        }
      }
    },
    {
      "id": "a5db24d5-aafb-4406-8b0b-1c4a62d3a9d8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
          }
        }
      }
    },
    {
      "id": "f9409e19-ef6d-4e00-b2f6-9843ee4cca8e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "04b030a3-b626-4345-b407-a1e8662780a4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/04b030a3-b626-4345-b407-a1e8662780a4"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







