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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b63f7dba-c622-46e5-9c84-025e04610ce0&filter%5Btill%5D=2023-02-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8cefcc49-3a73-50f9-b176-e980280d51c5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
          }
        }
      }
    },
    {
      "id": "virtual-635e9ad3-c320-5267-9300-797768975950",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
          }
        }
      }
    },
    {
      "id": "virtual-6b43b3c5-b09b-575b-b706-9d9e58dd4d2e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
          }
        }
      }
    },
    {
      "id": "virtual-d6749cc0-b691-5d8e-9d15-bfc5a2afe4ae",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
          }
        }
      }
    },
    {
      "id": "virtual-fe68e810-7a3a-50d9-b707-dd4752650af1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
          }
        }
      }
    },
    {
      "id": "virtual-cd4e56e6-8795-555f-a10c-a4778b7ef763",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
          }
        }
      }
    },
    {
      "id": "virtual-bb97718b-1599-597d-bfc6-3cc1a54a3de8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
          }
        }
      }
    },
    {
      "id": "virtual-9c760893-04df-5220-9e05-ec52387123f9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
          }
        }
      }
    },
    {
      "id": "virtual-57b5edee-0038-5386-9d0b-49a67bb74607",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
          }
        }
      }
    },
    {
      "id": "virtual-672ce3b7-67e8-5d9c-9c81-9727852f3732",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b63f7dba-c622-46e5-9c84-025e04610ce0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b63f7dba-c622-46e5-9c84-025e04610ce0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T11:51:19Z`
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







