# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=adce73a1-9432-4278-bfd1-6994d3612271&filter%5Btill%5D=2022-07-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-6d222daf-144c-5fc0-bdb0-4a1a6aff180e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
          }
        }
      }
    },
    {
      "id": "virtual-f95dd461-0312-5f67-8675-47fc2ecfc18a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
          }
        }
      }
    },
    {
      "id": "virtual-2802421b-1a2d-5edb-b9ff-dc16dab8bccd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
          }
        }
      }
    },
    {
      "id": "virtual-ebbf50aa-a489-5b81-81f6-82714adb343b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
          }
        }
      }
    },
    {
      "id": "virtual-451e28ae-d45c-574a-922a-fe5bafb29e8c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
          }
        }
      }
    },
    {
      "id": "virtual-4c843a92-d96b-59c8-959e-6cccb0a093a0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
          }
        }
      }
    },
    {
      "id": "virtual-62f9e28d-ed92-5799-9655-9d601ed64f21",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
          }
        }
      }
    },
    {
      "id": "virtual-0bdfa3b5-fece-58df-b6b6-d891a0ed2d1f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
          }
        }
      }
    },
    {
      "id": "virtual-0d1f6ef6-973b-52a6-903d-d94ea7f7adea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
          }
        }
      }
    },
    {
      "id": "virtual-e9c9e26d-364b-5ca3-9be1-13e9c1fb2a50",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "adce73a1-9432-4278-bfd1-6994d3612271"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/adce73a1-9432-4278-bfd1-6994d3612271"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:15:47Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







