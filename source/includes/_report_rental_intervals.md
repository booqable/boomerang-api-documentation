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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e924038d-149c-44b2-9bd3-76b54c709a73&filter%5Btill%5D=2023-02-05+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-21cb5f60-bf04-5bae-bf99-8dfb9bde0337",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
          }
        }
      }
    },
    {
      "id": "virtual-5530009b-0034-5a4b-a6d5-a9b125c971d8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
          }
        }
      }
    },
    {
      "id": "virtual-b97a766f-fc7a-5691-96e2-425eb91b6c26",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
          }
        }
      }
    },
    {
      "id": "virtual-d1381098-453c-5cb2-8853-6be1a82a5b8f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
          }
        }
      }
    },
    {
      "id": "virtual-f69cbf34-d464-5a9a-8634-1edc9d5bc8d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
          }
        }
      }
    },
    {
      "id": "virtual-295d15ad-0dcc-505e-a01d-509298d435c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
          }
        }
      }
    },
    {
      "id": "virtual-58ef6434-ad1e-55ae-b692-2570da01383b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
          }
        }
      }
    },
    {
      "id": "virtual-8a356baa-ed77-5c4e-bfaf-07994f3d639e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
          }
        }
      }
    },
    {
      "id": "virtual-9803c1d5-ec77-51a0-89a6-7250c239a735",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
          }
        }
      }
    },
    {
      "id": "virtual-cb467cfc-6aef-5c6b-a544-fc82d254b537",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e924038d-149c-44b2-9bd3-76b54c709a73"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e924038d-149c-44b2-9bd3-76b54c709a73"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T18:56:36Z`
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







