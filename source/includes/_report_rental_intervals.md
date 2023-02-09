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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=3e630b0b-ac66-4304-bc84-0b6510da71f4&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f872a140-cec3-56e1-ab1f-b7096d90aad7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
          }
        }
      }
    },
    {
      "id": "virtual-70b0dfbf-0e3d-5818-ad80-07f464d42fed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
          }
        }
      }
    },
    {
      "id": "virtual-8da27ef1-c1ef-5e38-9441-95798f3c7e6f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
          }
        }
      }
    },
    {
      "id": "virtual-d1911496-104c-5e53-8b78-ad85d9551c4c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
          }
        }
      }
    },
    {
      "id": "virtual-985c3035-2a3e-5cde-b7a3-a512d8b04666",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
          }
        }
      }
    },
    {
      "id": "virtual-7d1eae98-88df-52a0-8245-a4c744bb4ba7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
          }
        }
      }
    },
    {
      "id": "virtual-eec8abb3-3d81-51fc-a649-b8e6e8452da8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
          }
        }
      }
    },
    {
      "id": "virtual-e31c834e-da50-5d59-ba81-9862b66d6188",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
          }
        }
      }
    },
    {
      "id": "virtual-7b812c35-0aba-544e-9792-53da52727929",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
          }
        }
      }
    },
    {
      "id": "virtual-fba14ba6-6fa3-56df-bae7-2be26171d980",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3e630b0b-ac66-4304-bc84-0b6510da71f4"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3e630b0b-ac66-4304-bc84-0b6510da71f4"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T14:20:39Z`
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







