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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-01-19+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=df395b0f-e3fb-485e-813b-b29b133b1cba&filter%5Btill%5D=2024-01-28+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ba53860e-ea92-441d-9a96-ec9fa83c33e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
          }
        }
      }
    },
    {
      "id": "3583f802-cbc5-4c24-bc4b-76140cf302ff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
          }
        }
      }
    },
    {
      "id": "e39bbc0b-3640-4593-95e0-9f6622a2c8f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
          }
        }
      }
    },
    {
      "id": "0ca8e252-b9b4-486a-8951-88b574a9e83b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
          }
        }
      }
    },
    {
      "id": "57045acc-df51-4cd5-922e-dc3a212c49d5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
          }
        }
      }
    },
    {
      "id": "e465f9c7-0389-401a-9def-deb37d7e1d4b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
          }
        }
      }
    },
    {
      "id": "90ee75f0-8449-44da-b847-e8ffaedb0974",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
          }
        }
      }
    },
    {
      "id": "7c4824eb-f58a-48d0-a6fa-0335a55ff50b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
          }
        }
      }
    },
    {
      "id": "838f285a-8031-42a2-891d-772dc0e71cb6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
          }
        }
      }
    },
    {
      "id": "14306c81-e9d8-405b-8b67-088fdeed8b45",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "df395b0f-e3fb-485e-813b-b29b133b1cba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/df395b0f-e3fb-485e-813b-b29b133b1cba"
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







