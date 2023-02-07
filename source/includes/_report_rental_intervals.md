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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e2edfd2a-f798-42b4-862c-a37826e2104f&filter%5Btill%5D=2023-02-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8f90bc22-b5fb-524f-8e00-9fe8c72c40fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
          }
        }
      }
    },
    {
      "id": "virtual-e0b05353-ee26-5fc3-b94d-f5924f96d49e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
          }
        }
      }
    },
    {
      "id": "virtual-36b1d575-69e7-54e9-abce-45544399253f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
          }
        }
      }
    },
    {
      "id": "virtual-4b3d53bf-89a9-57a9-b24b-f55fe7dd7337",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
          }
        }
      }
    },
    {
      "id": "virtual-006de59f-0c12-5cde-84ba-16ad15998c29",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
          }
        }
      }
    },
    {
      "id": "virtual-91efb52e-de89-5063-b20c-0807ad61d9cf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
          }
        }
      }
    },
    {
      "id": "virtual-4dbfbc8f-3e23-5113-8bf4-97ad76ba68da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
          }
        }
      }
    },
    {
      "id": "virtual-097691e3-3cd3-598f-85b7-3aca9da5d50d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
          }
        }
      }
    },
    {
      "id": "virtual-ca331181-4a89-523f-b444-784469d18893",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
          }
        }
      }
    },
    {
      "id": "virtual-182b862c-0ae7-5194-b0d8-a2d18ab1e8fa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e2edfd2a-f798-42b4-862c-a37826e2104f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e2edfd2a-f798-42b4-862c-a37826e2104f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T10:26:13Z`
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







