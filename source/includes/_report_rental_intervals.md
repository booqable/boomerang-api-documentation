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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=58c741db-430d-4a70-896e-f93778dc3619&filter%5Btill%5D=2023-01-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c6580abb-60c3-51a4-aa6b-8bb0e473bb2c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
          }
        }
      }
    },
    {
      "id": "virtual-6c8ddfac-93ac-50b1-872c-c4179f057e8f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
          }
        }
      }
    },
    {
      "id": "virtual-b5ce8378-e102-52b5-8cef-2dfe9010ea2d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
          }
        }
      }
    },
    {
      "id": "virtual-c45de3cf-92c7-5d40-be73-8b331998f05f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
          }
        }
      }
    },
    {
      "id": "virtual-3083c511-0d77-55dd-b0cd-4c79e232fd8c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
          }
        }
      }
    },
    {
      "id": "virtual-601cb6e6-a706-5698-9c28-8ebd71bbde9e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
          }
        }
      }
    },
    {
      "id": "virtual-0b70aae3-46f3-5e87-94f6-27ebca6b60b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
          }
        }
      }
    },
    {
      "id": "virtual-4aa0d469-410f-52c2-b24d-da46ec683f29",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
          }
        }
      }
    },
    {
      "id": "virtual-339e8651-80cf-5ac2-8057-d0ea5907027b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
          }
        }
      }
    },
    {
      "id": "virtual-d15111a5-afae-5b6b-a943-e53c730fd1bf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58c741db-430d-4a70-896e-f93778dc3619"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58c741db-430d-4a70-896e-f93778dc3619"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:20:21Z`
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







