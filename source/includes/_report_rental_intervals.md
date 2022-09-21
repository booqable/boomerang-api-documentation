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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4b4b8a7f-c073-41ed-b274-7cb38235f4ff&filter%5Btill%5D=2022-09-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f8f26fef-3889-5cc3-b9ef-a91bb6fe4fc3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
          }
        }
      }
    },
    {
      "id": "virtual-1c8af9e9-230f-50c5-89cf-f2d09e5e0751",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
          }
        }
      }
    },
    {
      "id": "virtual-4feb1428-b964-513f-82ee-6ac5955d5721",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
          }
        }
      }
    },
    {
      "id": "virtual-941915a2-8000-5bf7-b19c-8cc74bc56917",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
          }
        }
      }
    },
    {
      "id": "virtual-e54e7770-bb4a-56a3-87e6-b92af75fcb1f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
          }
        }
      }
    },
    {
      "id": "virtual-f272395c-c8fb-5d3a-973c-5f1f651b3dba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
          }
        }
      }
    },
    {
      "id": "virtual-8bb10321-ade5-5f4c-b8ce-b0eb1b963e78",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
          }
        }
      }
    },
    {
      "id": "virtual-b73d0b50-e0e3-53ee-9a01-5a69adbe1f15",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
          }
        }
      }
    },
    {
      "id": "virtual-c14e48fd-2174-5a67-a21a-f65a3af2e3ab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
          }
        }
      }
    },
    {
      "id": "virtual-81f4b181-6c2e-5b22-be0f-26d51315964a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b4b8a7f-c073-41ed-b274-7cb38235f4ff"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-21T09:04:21Z`
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







