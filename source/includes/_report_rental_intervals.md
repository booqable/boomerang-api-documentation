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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=03e5b4e5-65eb-4040-9125-2c5a807d024c&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-654da9e2-f486-54d1-a1bd-0db6be9110b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
          }
        }
      }
    },
    {
      "id": "virtual-86fd1664-3127-57ed-8139-1f66229a93fa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
          }
        }
      }
    },
    {
      "id": "virtual-3bd8601b-e42d-5273-87d5-5f6018938675",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
          }
        }
      }
    },
    {
      "id": "virtual-86646a2d-f7ec-5557-aeca-15f26f6dd713",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
          }
        }
      }
    },
    {
      "id": "virtual-3cae1b6d-cc86-5d29-9541-d0794a73c80c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
          }
        }
      }
    },
    {
      "id": "virtual-45cb5332-3539-5c1d-a865-d0ba58e360fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
          }
        }
      }
    },
    {
      "id": "virtual-ad62a448-a582-5963-ad69-f48d086efb6c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
          }
        }
      }
    },
    {
      "id": "virtual-c593854e-19c8-5b45-a04a-f7ad68b49933",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
          }
        }
      }
    },
    {
      "id": "virtual-60a18d0e-92f8-5774-b4e8-3f9f28c87a84",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
          }
        }
      }
    },
    {
      "id": "virtual-b0b27357-cc39-51d6-b33c-d567f344d79d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "03e5b4e5-65eb-4040-9125-2c5a807d024c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/03e5b4e5-65eb-4040-9125-2c5a807d024c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T08:34:22Z`
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







