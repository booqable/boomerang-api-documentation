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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=f423c050-6aea-46c4-b81c-0b46abfc18d3&filter%5Btill%5D=2023-02-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-cc11f430-a406-581e-8f71-a529893988d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
          }
        }
      }
    },
    {
      "id": "virtual-23984324-97b7-516b-9fde-e5b16e83713f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
          }
        }
      }
    },
    {
      "id": "virtual-3d9d04b0-b751-5740-9c3e-ffbece2d8dba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
          }
        }
      }
    },
    {
      "id": "virtual-6dfd142b-1879-51b0-8c57-d18c93aee55e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
          }
        }
      }
    },
    {
      "id": "virtual-971e60eb-e1f4-5e75-9efe-2a1cc8adb8b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
          }
        }
      }
    },
    {
      "id": "virtual-b20ac9a7-1a06-5a0b-9754-ea3bee2da28a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
          }
        }
      }
    },
    {
      "id": "virtual-f2b820be-cc3b-5ec8-97e3-98854ee5ead4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
          }
        }
      }
    },
    {
      "id": "virtual-1ff9f76b-60cc-54f2-b4ab-fe2ad689298f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
          }
        }
      }
    },
    {
      "id": "virtual-aee6327e-1da3-5aa3-ab34-3ae37b75b760",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
          }
        }
      }
    },
    {
      "id": "virtual-d960a04d-8ab2-578f-95e5-5db0c407c886",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f423c050-6aea-46c4-b81c-0b46abfc18d3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f423c050-6aea-46c4-b81c-0b46abfc18d3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:10:33Z`
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







