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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-15+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b9585d2e-6d5c-4a24-a731-6eb78ff45e28&filter%5Btill%5D=2022-10-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a73f6a8b-56c3-5d11-83dd-5d8bc69920a7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
          }
        }
      }
    },
    {
      "id": "virtual-77f17393-2ced-54ba-8602-24b16b52f721",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
          }
        }
      }
    },
    {
      "id": "virtual-9f708962-8318-5d7c-abed-4a69ee6d680d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
          }
        }
      }
    },
    {
      "id": "virtual-169d7ab3-9b32-5cf5-ba38-3e2c7f2f794e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
          }
        }
      }
    },
    {
      "id": "virtual-73f5bdad-b42a-53a1-89e5-590e3a94df3d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
          }
        }
      }
    },
    {
      "id": "virtual-1a6e8cb2-bd34-5dcd-aa8f-09bc6d2f2ac4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
          }
        }
      }
    },
    {
      "id": "virtual-676b4e8c-7e23-582f-9561-99637f8819fc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
          }
        }
      }
    },
    {
      "id": "virtual-e068215f-e199-554e-b8bc-6c688d06db81",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
          }
        }
      }
    },
    {
      "id": "virtual-44650ef8-d138-555b-87b6-6dfa364a033b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
          }
        }
      }
    },
    {
      "id": "virtual-935a1bb1-66a6-5035-95f0-f819d5950a4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b9585d2e-6d5c-4a24-a731-6eb78ff45e28"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T15:51:29Z`
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







