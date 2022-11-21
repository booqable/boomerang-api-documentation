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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=1634e790-cc3c-4f77-a509-6d157f54823f&filter%5Btill%5D=2022-11-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-1bd09294-ee0f-51a9-8717-d2c0be0ecdd2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
          }
        }
      }
    },
    {
      "id": "virtual-f16567c3-9eee-539f-8465-c7f4126a9dba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
          }
        }
      }
    },
    {
      "id": "virtual-264f5113-3c08-5819-8b96-8ecf49fa2dab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
          }
        }
      }
    },
    {
      "id": "virtual-73857cb4-99ee-5c28-8e30-488ea19a236f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
          }
        }
      }
    },
    {
      "id": "virtual-d9dc7a01-7c81-5d02-ac10-be0c83b57b77",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
          }
        }
      }
    },
    {
      "id": "virtual-b79326fd-f126-55f5-bf46-1ebfe30d1d0c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
          }
        }
      }
    },
    {
      "id": "virtual-0efa0067-8e88-5d3c-a3c7-04660a683959",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
          }
        }
      }
    },
    {
      "id": "virtual-751870b0-7049-5e00-868b-d887d7bc6ad2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
          }
        }
      }
    },
    {
      "id": "virtual-99eda61d-82a7-51fe-8bee-801d9063ddf2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
          }
        }
      }
    },
    {
      "id": "virtual-93ff4a6b-3786-5acc-aa8b-56f5bd12c3f5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1634e790-cc3c-4f77-a509-6d157f54823f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1634e790-cc3c-4f77-a509-6d157f54823f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-21T10:28:05Z`
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







