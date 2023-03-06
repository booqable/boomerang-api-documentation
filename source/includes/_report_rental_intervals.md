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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2fa4d79c-ade6-4435-b785-6687a03a4483&filter%5Btill%5D=2023-03-05+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8073b21e-e06c-5b6f-ae31-e25b52fd27be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
          }
        }
      }
    },
    {
      "id": "virtual-c2ba5381-d013-5935-b18d-9f0cf65e9cc1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
          }
        }
      }
    },
    {
      "id": "virtual-e3989cfb-ad36-51ae-8aed-b603a370dae2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
          }
        }
      }
    },
    {
      "id": "virtual-83181a30-8027-58d6-8f7d-969f220b7b20",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
          }
        }
      }
    },
    {
      "id": "virtual-32b37147-fda9-5a92-a336-69c811f5c966",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
          }
        }
      }
    },
    {
      "id": "virtual-1b6cab27-497c-5c13-a424-a00a7abd102c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
          }
        }
      }
    },
    {
      "id": "virtual-f124534c-fbb4-596a-b4e3-5fd792a592a5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
          }
        }
      }
    },
    {
      "id": "virtual-fd3e54da-ae1e-55cf-aab1-24ca90805dbb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
          }
        }
      }
    },
    {
      "id": "virtual-357d444d-4ce8-5b71-9bc2-8ba03ba5a035",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
          }
        }
      }
    },
    {
      "id": "virtual-17e48d8b-4382-5709-a937-75dc3daf4528",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2fa4d79c-ade6-4435-b785-6687a03a4483"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2fa4d79c-ade6-4435-b785-6687a03a4483"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-06T08:22:20Z`
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







