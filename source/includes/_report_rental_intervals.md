# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=99fd9749-0e44-499e-af22-eed3d53ebeb4&filter%5Btill%5D=2022-07-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-9cceda40-3651-5dc3-9341-c61639c9d4b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
          }
        }
      }
    },
    {
      "id": "virtual-115d5afb-2bf2-5b51-901e-19f35198ef3c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
          }
        }
      }
    },
    {
      "id": "virtual-ff99fc2c-6306-5dee-9225-430b12f56de3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
          }
        }
      }
    },
    {
      "id": "virtual-44b5ede3-7b1c-5ccf-ac08-29978ecf931e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
          }
        }
      }
    },
    {
      "id": "virtual-9a1b3f24-527e-5e1a-a1c1-c21cd6072b6f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
          }
        }
      }
    },
    {
      "id": "virtual-41af3908-58ba-5d11-9565-c047d7fc68b6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
          }
        }
      }
    },
    {
      "id": "virtual-eb7a41b9-eb96-50e0-bddc-b5af4600000f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
          }
        }
      }
    },
    {
      "id": "virtual-715eb167-168f-5ce9-854e-1bd781a82cf8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
          }
        }
      }
    },
    {
      "id": "virtual-c4003381-3ff4-59d5-a739-1e3ab22ffbbf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
          }
        }
      }
    },
    {
      "id": "virtual-dbc4e340-bc4d-509a-9f96-1f82b31323d8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "99fd9749-0e44-499e-af22-eed3d53ebeb4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/99fd9749-0e44-499e-af22-eed3d53ebeb4"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T14:26:12Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







