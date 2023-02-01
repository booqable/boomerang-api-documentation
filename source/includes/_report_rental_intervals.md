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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-22+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=45d2e34e-91a2-4ab0-b845-1cef6701be5a&filter%5Btill%5D=2023-01-31+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-cab9a251-173f-5b8d-8c69-864c476a5cb4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
          }
        }
      }
    },
    {
      "id": "virtual-acf36880-a4bb-5574-b256-8614d54c30c6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
          }
        }
      }
    },
    {
      "id": "virtual-4ab03bd7-455a-54b8-b0d7-1a498a0c3a14",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
          }
        }
      }
    },
    {
      "id": "virtual-08a0c097-d02a-552d-ac78-07230b55e11b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
          }
        }
      }
    },
    {
      "id": "virtual-4838a84b-fc15-5d5f-8c50-58f686aa47c5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
          }
        }
      }
    },
    {
      "id": "virtual-6f4a5ae6-cf8e-5b39-b11d-d10f6d81b4ea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
          }
        }
      }
    },
    {
      "id": "virtual-635116c0-5f38-5dd6-b6c6-8dfc48c7d377",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
          }
        }
      }
    },
    {
      "id": "virtual-113be6be-31cd-58d7-a3d0-624152b91af1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
          }
        }
      }
    },
    {
      "id": "virtual-ef458d82-1b01-5066-9a7b-474711159308",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
          }
        }
      }
    },
    {
      "id": "virtual-bf4fdcff-4eba-5665-a803-a364827b1f58",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "45d2e34e-91a2-4ab0-b845-1cef6701be5a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/45d2e34e-91a2-4ab0-b845-1cef6701be5a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T13:31:18Z`
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







