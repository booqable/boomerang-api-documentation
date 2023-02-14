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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=77b709cd-acfc-46de-92cb-2af72ed40162&filter%5Btill%5D=2023-02-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-db10c001-057d-585b-a1f0-52820c1b9de2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
          }
        }
      }
    },
    {
      "id": "virtual-fca3204b-a8bf-5343-99ba-e900cdeada76",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
          }
        }
      }
    },
    {
      "id": "virtual-afd01106-980f-5cfe-a43d-13b14ae10eed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
          }
        }
      }
    },
    {
      "id": "virtual-6d690685-eeb3-5e7b-a040-18caa8ba053f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
          }
        }
      }
    },
    {
      "id": "virtual-51e9cbf4-2c87-5809-9a45-61cde5878338",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
          }
        }
      }
    },
    {
      "id": "virtual-e9079412-4460-5100-be84-e0b7f5e145bc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
          }
        }
      }
    },
    {
      "id": "virtual-34568a73-0f34-5445-b142-6abcf22f4583",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
          }
        }
      }
    },
    {
      "id": "virtual-241bd135-bb01-5055-b96e-0fad53ca0931",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
          }
        }
      }
    },
    {
      "id": "virtual-43e9c1bd-4e53-5e1a-9112-b1980125d8dc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
          }
        }
      }
    },
    {
      "id": "virtual-ea6a9513-c965-5faa-b465-d7e36562ebb1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "77b709cd-acfc-46de-92cb-2af72ed40162"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/77b709cd-acfc-46de-92cb-2af72ed40162"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T13:00:16Z`
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







