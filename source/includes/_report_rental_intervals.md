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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-13+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=178a1548-af2e-4872-afe3-c44e22c29499&filter%5Btill%5D=2023-02-22+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0c59edd1-57b0-5359-a734-e66b65e81ffe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
          }
        }
      }
    },
    {
      "id": "virtual-0dd3ec24-a171-510f-8e13-ad2b86d2ab7e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
          }
        }
      }
    },
    {
      "id": "virtual-f7997760-ac71-5193-8145-100bbdd3b1a6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
          }
        }
      }
    },
    {
      "id": "virtual-38f85f62-e419-50e4-acb1-963bf0ae7afe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
          }
        }
      }
    },
    {
      "id": "virtual-e50471fa-b6b5-5348-9539-3ff46ac2a08c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
          }
        }
      }
    },
    {
      "id": "virtual-af00b74c-55de-5118-b7e3-4a641b363bfe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
          }
        }
      }
    },
    {
      "id": "virtual-cdc6cce5-cdce-5574-8de6-3696065f366a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
          }
        }
      }
    },
    {
      "id": "virtual-f0be1cc7-8486-5f55-acbf-22294fb2a6a3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
          }
        }
      }
    },
    {
      "id": "virtual-7b65ba21-0b40-516a-854c-bb62b0a25d27",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
          }
        }
      }
    },
    {
      "id": "virtual-a5720b32-7323-5e9b-b309-7fdba6367221",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "178a1548-af2e-4872-afe3-c44e22c29499"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/178a1548-af2e-4872-afe3-c44e22c29499"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T08:18:42Z`
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







