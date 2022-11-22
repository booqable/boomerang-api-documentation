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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=fd271758-97b6-49ac-a2a8-5c490b4bfda9&filter%5Btill%5D=2022-11-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-d2c93bd2-c945-5c78-9772-be1569a9bf22",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
          }
        }
      }
    },
    {
      "id": "virtual-7986edcf-2034-5721-bc8a-e5b5be6044c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
          }
        }
      }
    },
    {
      "id": "virtual-9ea168f5-e37a-5368-a8c2-8d45f9e8ca2c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
          }
        }
      }
    },
    {
      "id": "virtual-72081489-7b6b-5d8c-9baf-9ca4b8d26ded",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
          }
        }
      }
    },
    {
      "id": "virtual-ae9c4808-b3f3-5da3-95e5-d829e98691da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
          }
        }
      }
    },
    {
      "id": "virtual-75b25be4-6823-5ae7-b360-52d6673f7dda",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
          }
        }
      }
    },
    {
      "id": "virtual-07a7f5b4-82f2-586f-93f3-4c9df331d891",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
          }
        }
      }
    },
    {
      "id": "virtual-50c09e6b-9e7b-58c1-b807-39e24c9ce08b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
          }
        }
      }
    },
    {
      "id": "virtual-50559663-85f6-5181-b595-bf5e4bbcb395",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
          }
        }
      }
    },
    {
      "id": "virtual-f3bc8c9f-3be2-5cbf-96b4-6d1a7457efa3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fd271758-97b6-49ac-a2a8-5c490b4bfda9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fd271758-97b6-49ac-a2a8-5c490b4bfda9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:45:19Z`
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







