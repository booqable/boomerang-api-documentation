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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-07+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=68aeaafa-878d-4610-938f-ed3d79ae103c&filter%5Btill%5D=2023-02-16+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f9caafc4-488f-559e-865d-a657de42cb1f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
          }
        }
      }
    },
    {
      "id": "virtual-71d4c62e-486d-56c7-971d-2c9660c80a91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
          }
        }
      }
    },
    {
      "id": "virtual-322520f6-6be5-5dc5-99f6-7858e84cf14a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
          }
        }
      }
    },
    {
      "id": "virtual-4452cd35-2282-54f9-b0f1-31919a5a0f6a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
          }
        }
      }
    },
    {
      "id": "virtual-c01ab132-7027-5ad9-84fa-37a2f8dca17e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
          }
        }
      }
    },
    {
      "id": "virtual-a21eb0e1-dd82-5415-92c3-565333554dee",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
          }
        }
      }
    },
    {
      "id": "virtual-93299aca-63e1-50e8-8623-21b4874d696c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
          }
        }
      }
    },
    {
      "id": "virtual-aeee6bb8-a627-5234-8d37-b5a98e6eae4f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
          }
        }
      }
    },
    {
      "id": "virtual-0fb7cd99-f5c9-53fc-8a4f-d278f3c50f5c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
          }
        }
      }
    },
    {
      "id": "virtual-2732e96a-9b75-5cb1-bd5b-1a2445acb5aa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "68aeaafa-878d-4610-938f-ed3d79ae103c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/68aeaafa-878d-4610-938f-ed3d79ae103c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-17T13:25:08Z`
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







