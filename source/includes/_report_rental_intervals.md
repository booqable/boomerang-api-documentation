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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-08+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=99b55b43-916d-4972-926e-ff1f8103d1ad&filter%5Btill%5D=2023-01-17+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b1cb2093-e85e-53bf-8e77-c47cffb481c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
          }
        }
      }
    },
    {
      "id": "virtual-a235e4c2-3e43-5c03-a44b-b60c8a3492f8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
          }
        }
      }
    },
    {
      "id": "virtual-9afb92cc-e2ce-54fe-829e-5e5f8f1af6cf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
          }
        }
      }
    },
    {
      "id": "virtual-6108f941-53a6-5e3f-a5a7-843c4bae1895",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
          }
        }
      }
    },
    {
      "id": "virtual-9b1347d4-1336-5b71-9d2c-b3cfc7cbe69c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
          }
        }
      }
    },
    {
      "id": "virtual-bdc55df7-ac1d-5713-9265-71f2bd11c899",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
          }
        }
      }
    },
    {
      "id": "virtual-2b54d6f2-81ea-5fd5-8362-dd2644d1d90e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
          }
        }
      }
    },
    {
      "id": "virtual-cfb0fe62-6921-58c2-a412-f8421e6a82f8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
          }
        }
      }
    },
    {
      "id": "virtual-5f0efbcc-b6fe-5237-8d4b-fcac4070cfd4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
          }
        }
      }
    },
    {
      "id": "virtual-71ab2bef-4c13-573c-b323-88281e15735f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99b55b43-916d-4972-926e-ff1f8103d1ad"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99b55b43-916d-4972-926e-ff1f8103d1ad"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-18T13:34:28Z`
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







