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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-15+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=3a8f20db-31c2-40c0-85ed-79b3d1da4644&filter%5Btill%5D=2022-10-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-adc2ff59-178d-5f83-8d62-83200e2e423a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
          }
        }
      }
    },
    {
      "id": "virtual-0d93b622-3bee-5432-a12a-f8021ff901af",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
          }
        }
      }
    },
    {
      "id": "virtual-8baac62b-2a96-5008-b955-55a38d3731dc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
          }
        }
      }
    },
    {
      "id": "virtual-b143863a-d3d0-5a78-ba3f-2ad64b560efa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
          }
        }
      }
    },
    {
      "id": "virtual-6a002fea-bc29-5691-87c5-dc7c438984dd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
          }
        }
      }
    },
    {
      "id": "virtual-cc603fb9-da88-530a-b6d4-7be73e983f47",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
          }
        }
      }
    },
    {
      "id": "virtual-da281c9c-33f8-5a8d-9ff5-406fb8a4a01e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
          }
        }
      }
    },
    {
      "id": "virtual-5b969a9f-40d9-593d-a00a-b45018d6d54f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
          }
        }
      }
    },
    {
      "id": "virtual-ba793ffd-417b-54bb-8b04-11d17fdad629",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
          }
        }
      }
    },
    {
      "id": "virtual-5f45cefa-ab05-58a7-8a21-c5442594441c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a8f20db-31c2-40c0-85ed-79b3d1da4644"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a8f20db-31c2-40c0-85ed-79b3d1da4644"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T14:57:41Z`
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







