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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-13+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15&filter%5Btill%5D=2023-02-22+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8bcb784c-0233-5ede-9411-b5625be26af5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
          }
        }
      }
    },
    {
      "id": "virtual-56031d56-e913-507e-9ec9-befc5ce09b13",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
          }
        }
      }
    },
    {
      "id": "virtual-56f9db7f-9398-515f-8729-29c2f0028c66",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
          }
        }
      }
    },
    {
      "id": "virtual-162e5f09-2780-564f-847d-a57dffe1b08f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
          }
        }
      }
    },
    {
      "id": "virtual-c014dc01-9bd0-5ab5-975e-20a195833b7d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
          }
        }
      }
    },
    {
      "id": "virtual-b2f7e80d-f1e7-575c-94a6-09748450d6d1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
          }
        }
      }
    },
    {
      "id": "virtual-d734598a-5e2e-5a46-8bcf-091c40eac49f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
          }
        }
      }
    },
    {
      "id": "virtual-5cede3ab-1fff-5d1a-a132-6fdd850a9d4b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
          }
        }
      }
    },
    {
      "id": "virtual-1ee2335b-a7b7-5f12-a446-b7ccb83ccac3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
          }
        }
      }
    },
    {
      "id": "virtual-d043b9a2-3008-5b82-9fc6-c968b3016702",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/71e0bd9d-9e29-4409-bc1b-cd8bdc7e3c15"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T00:22:21Z`
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







