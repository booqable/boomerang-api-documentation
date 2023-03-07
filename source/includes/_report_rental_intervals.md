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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e27eb11f-e2fa-4f6e-9772-5847d8572d32&filter%5Btill%5D=2023-03-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-7d63e869-6686-58d1-abd5-a0b968bfdf91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
          }
        }
      }
    },
    {
      "id": "virtual-2459030e-420d-56ff-9077-36dd01453c92",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
          }
        }
      }
    },
    {
      "id": "virtual-cc982585-deae-5b4f-b5ae-e624e13cdbb7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
          }
        }
      }
    },
    {
      "id": "virtual-0798cdfb-73db-5084-9881-b6bff4d20dd1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
          }
        }
      }
    },
    {
      "id": "virtual-ba15c95a-e254-5a1c-ac9b-9f7f9b0462f1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
          }
        }
      }
    },
    {
      "id": "virtual-6b219e24-2be5-511d-ab6f-5ff8d50dc018",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
          }
        }
      }
    },
    {
      "id": "virtual-2f901bbb-d529-5f6c-b7c2-f953199311b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
          }
        }
      }
    },
    {
      "id": "virtual-185b303d-6191-5068-b2e5-4ec85489ea03",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
          }
        }
      }
    },
    {
      "id": "virtual-f0791b3f-db58-5fbb-ba08-1f35b0b188b2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
          }
        }
      }
    },
    {
      "id": "virtual-0753419f-c6a0-51a9-ac8c-3a7e16dbe70c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e27eb11f-e2fa-4f6e-9772-5847d8572d32"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e27eb11f-e2fa-4f6e-9772-5847d8572d32"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T07:55:09Z`
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







