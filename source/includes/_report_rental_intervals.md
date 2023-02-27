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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-17+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4445878b-48d8-48d5-ae82-5c4e236f11db&filter%5Btill%5D=2023-02-26+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e102dbce-d8aa-546a-b4ae-552a7c94edf3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
          }
        }
      }
    },
    {
      "id": "virtual-d1b01a41-cc7f-57ed-a472-d9bd686ec6a5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
          }
        }
      }
    },
    {
      "id": "virtual-4ba625a6-3729-50ac-b41f-6db1224f0424",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
          }
        }
      }
    },
    {
      "id": "virtual-efabd2e7-147f-504c-b1a9-0e8f631934d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
          }
        }
      }
    },
    {
      "id": "virtual-a8a79de8-6349-5eec-a8ef-b82fea40d3fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
          }
        }
      }
    },
    {
      "id": "virtual-1c778ebe-6f06-56d9-977a-0f84529052f6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
          }
        }
      }
    },
    {
      "id": "virtual-2ec81ad9-ead9-5938-a4f4-2a63a2c22956",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
          }
        }
      }
    },
    {
      "id": "virtual-675e89f3-cbf7-5642-9cbc-9e491da0cdb2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
          }
        }
      }
    },
    {
      "id": "virtual-fbd4c025-db74-5415-ad9a-cb2303965310",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
          }
        }
      }
    },
    {
      "id": "virtual-b5c63c26-dbb1-5e7c-a417-167b0e3078f4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4445878b-48d8-48d5-ae82-5c4e236f11db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4445878b-48d8-48d5-ae82-5c4e236f11db"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-27T10:14:35Z`
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







