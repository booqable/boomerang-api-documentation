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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=32628c4d-5bd4-4104-a784-15fe165406e8&filter%5Btill%5D=2023-02-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-868f09e5-1e23-5844-9f0d-06ac3b08c693",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
          }
        }
      }
    },
    {
      "id": "virtual-b5c2b483-55fa-52dc-9963-4ffc6f5df04c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
          }
        }
      }
    },
    {
      "id": "virtual-cb6d039c-4cfc-597d-bf53-071c96dc7f77",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
          }
        }
      }
    },
    {
      "id": "virtual-50df8343-598b-58d6-915c-bf6b8ff3854b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
          }
        }
      }
    },
    {
      "id": "virtual-8e5f69fd-3989-5044-b4c9-b24c66d962ff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
          }
        }
      }
    },
    {
      "id": "virtual-8b7261f1-f6f0-5c90-8619-3dd9b399d43f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
          }
        }
      }
    },
    {
      "id": "virtual-94fae7c2-983d-5811-bc6f-ed912e1a09a3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
          }
        }
      }
    },
    {
      "id": "virtual-060815bd-db82-5bca-8393-c3d20ed97b32",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
          }
        }
      }
    },
    {
      "id": "virtual-ce934c3f-2b9d-5531-9174-835c3092ce50",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
          }
        }
      }
    },
    {
      "id": "virtual-62b4a3ee-c633-5c1f-9935-a65911e39485",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "32628c4d-5bd4-4104-a784-15fe165406e8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/32628c4d-5bd4-4104-a784-15fe165406e8"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T09:26:33Z`
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







