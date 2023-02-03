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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=5de8b82a-3f3b-47e3-81de-e9e329fd3df9&filter%5Btill%5D=2023-02-02+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f3a18589-9fa4-5b5a-b9c9-cdbdac0506e6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
          }
        }
      }
    },
    {
      "id": "virtual-674bd5b0-35ae-5f22-b1d1-58b7cf587629",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
          }
        }
      }
    },
    {
      "id": "virtual-1e18ba4a-58cf-58ac-931f-3a759a1f6b1c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
          }
        }
      }
    },
    {
      "id": "virtual-fd0c6a96-f7bc-5425-adb4-dd665c849a39",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
          }
        }
      }
    },
    {
      "id": "virtual-5a7d5ce8-143f-529e-99aa-c17cef7db66f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
          }
        }
      }
    },
    {
      "id": "virtual-82bef2e8-c12c-5dae-a12b-e5ac92383c4f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
          }
        }
      }
    },
    {
      "id": "virtual-2c2ed83e-27ca-5bde-9acc-554b09c08ee3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
          }
        }
      }
    },
    {
      "id": "virtual-16c277b0-0b0a-5c03-82ef-6691af77cd85",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
          }
        }
      }
    },
    {
      "id": "virtual-faf382e4-ddbc-547b-8f4d-e26a535ad9c9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
          }
        }
      }
    },
    {
      "id": "virtual-f5941e02-797a-53b4-a559-32950b19fc63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de8b82a-3f3b-47e3-81de-e9e329fd3df9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T11:08:37Z`
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







