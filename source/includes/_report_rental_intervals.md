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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4fe77556-133b-4b8c-b864-5c4e40d7feea&filter%5Btill%5D=2022-10-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-77461208-a73d-5bf2-8b91-b6417fd960bf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
          }
        }
      }
    },
    {
      "id": "virtual-1d148436-3bb9-5477-8ad8-6d4b3fc97aa1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
          }
        }
      }
    },
    {
      "id": "virtual-24d832bd-4e67-50eb-a864-6d4326b38b5c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
          }
        }
      }
    },
    {
      "id": "virtual-425b3df5-9e35-5f3e-b181-a293970d8e40",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
          }
        }
      }
    },
    {
      "id": "virtual-af48001c-fd7d-5613-afa2-fe8e8de71ea1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
          }
        }
      }
    },
    {
      "id": "virtual-fb30a06c-78dd-54c7-8bb5-bf85941be740",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
          }
        }
      }
    },
    {
      "id": "virtual-869a04cb-83e8-5256-9f05-6076032a99dd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
          }
        }
      }
    },
    {
      "id": "virtual-d584c7d2-83ed-5896-9d62-cc8428e55b52",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
          }
        }
      }
    },
    {
      "id": "virtual-65d0e7b5-2e9b-5b0a-9457-46b367435aa6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
          }
        }
      }
    },
    {
      "id": "virtual-cd27e55d-e187-5087-88d6-ad37adb2461e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4fe77556-133b-4b8c-b864-5c4e40d7feea"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4fe77556-133b-4b8c-b864-5c4e40d7feea"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T15:41:57Z`
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







