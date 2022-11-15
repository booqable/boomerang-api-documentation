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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-05+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=dc88ea78-1061-4223-a4ef-20e198a8d82c&filter%5Btill%5D=2022-11-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-4bb62b01-334c-5204-8e38-09f08fccea45",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
          }
        }
      }
    },
    {
      "id": "virtual-30ce9711-f2ae-5ce3-9b35-b8615f8892bf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
          }
        }
      }
    },
    {
      "id": "virtual-aa2eed05-2a09-57c4-9364-614948227863",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
          }
        }
      }
    },
    {
      "id": "virtual-33137f49-c31e-5cb7-98ce-e1ebd25e92eb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
          }
        }
      }
    },
    {
      "id": "virtual-6ea5d08b-c45d-5052-bd88-910a6a8b6fab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
          }
        }
      }
    },
    {
      "id": "virtual-b759b8f2-3166-58e4-8913-c49cdc1da859",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
          }
        }
      }
    },
    {
      "id": "virtual-1ed209e9-9d77-5c27-8484-b54ec6b3f553",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
          }
        }
      }
    },
    {
      "id": "virtual-c910f2a7-9d7a-5fdf-895a-29eaa66741a9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
          }
        }
      }
    },
    {
      "id": "virtual-c49112ac-d31b-5665-b829-4f919e845928",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
          }
        }
      }
    },
    {
      "id": "virtual-0c8bbd6d-d48f-5a09-bd3c-301c16352153",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc88ea78-1061-4223-a4ef-20e198a8d82c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc88ea78-1061-4223-a4ef-20e198a8d82c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-15T08:04:20Z`
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







