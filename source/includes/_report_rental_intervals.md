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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-19+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=9b03545c-27e9-424a-8f8a-9dd17206529d&filter%5Btill%5D=2023-02-28+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-fbee217f-10ab-5056-9878-f6aaf538bce7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
          }
        }
      }
    },
    {
      "id": "virtual-4d26bedc-94ae-5da9-ad70-448c0189086d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
          }
        }
      }
    },
    {
      "id": "virtual-259ba626-1b01-5b5e-b53d-0ddb0034b63f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
          }
        }
      }
    },
    {
      "id": "virtual-8d7f72b2-5209-58aa-9a19-7200aa7dcddc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
          }
        }
      }
    },
    {
      "id": "virtual-8e53c944-b174-5079-89b5-033dd88ad9b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
          }
        }
      }
    },
    {
      "id": "virtual-b0d2b274-3f32-5ec7-9b8e-44c81d088b31",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
          }
        }
      }
    },
    {
      "id": "virtual-5c82bd9f-073b-5bbd-9893-25defa552629",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
          }
        }
      }
    },
    {
      "id": "virtual-4c4cef5d-96ba-5aea-8966-13f21b58b586",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
          }
        }
      }
    },
    {
      "id": "virtual-4d6aca28-1d59-5895-8225-e0032a1b5b53",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
          }
        }
      }
    },
    {
      "id": "virtual-a8c5258c-2890-537a-9fcf-4333597839e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "9b03545c-27e9-424a-8f8a-9dd17206529d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/9b03545c-27e9-424a-8f8a-9dd17206529d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T17:36:22Z`
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







