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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=674e3626-9556-4f88-a0fd-9e4657d570a0&filter%5Btill%5D=2023-02-02+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-dd9b54c0-4ae7-599a-abb2-9c21c0738b70",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
          }
        }
      }
    },
    {
      "id": "virtual-cdfeb28b-8079-5e3d-8175-8bc134102987",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
          }
        }
      }
    },
    {
      "id": "virtual-2b37f931-44b8-5dd6-8cbb-22d46375755c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
          }
        }
      }
    },
    {
      "id": "virtual-c9f65ec4-3863-5d75-aa42-8e2349601d96",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
          }
        }
      }
    },
    {
      "id": "virtual-e7fdf310-e2ef-54cb-bcb7-24db06885aea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
          }
        }
      }
    },
    {
      "id": "virtual-db4095f9-8bb7-5837-878b-cb0284891456",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
          }
        }
      }
    },
    {
      "id": "virtual-8a201799-d094-50cb-89ec-276f4ec724bf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
          }
        }
      }
    },
    {
      "id": "virtual-df388d8b-44dd-5fd6-9636-935aa68825e6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
          }
        }
      }
    },
    {
      "id": "virtual-00559b18-44d5-562c-829e-bbbca3dca782",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
          }
        }
      }
    },
    {
      "id": "virtual-14c229e8-b73e-5529-a524-0f833f1f74c9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "674e3626-9556-4f88-a0fd-9e4657d570a0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/674e3626-9556-4f88-a0fd-9e4657d570a0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T09:50:47Z`
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







