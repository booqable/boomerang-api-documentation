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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4b07ee70-6d34-42fe-b239-2f3226081fb3&filter%5Btill%5D=2022-09-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-75d333e5-3d93-582c-b250-a06a6d1f5041",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
          }
        }
      }
    },
    {
      "id": "virtual-1e5a6bfd-f29c-56ca-8ff3-a8b1b2545063",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
          }
        }
      }
    },
    {
      "id": "virtual-7803adc5-5f6b-512e-9f24-ce7bb2f381e4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
          }
        }
      }
    },
    {
      "id": "virtual-186811b8-65cb-5305-a267-ae4533bc44f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
          }
        }
      }
    },
    {
      "id": "virtual-ff7ca9a5-f258-585a-87f9-ed5add96ab2e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
          }
        }
      }
    },
    {
      "id": "virtual-0006808d-73c7-5dad-aa30-be39293ec03f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
          }
        }
      }
    },
    {
      "id": "virtual-c7aa73e6-a85d-5c7d-8e06-646c1fa8a7fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
          }
        }
      }
    },
    {
      "id": "virtual-22285dbb-f7cc-581b-aa23-917de6f37645",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
          }
        }
      }
    },
    {
      "id": "virtual-0b5d5645-829c-5512-973c-63699d4fbe53",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
          }
        }
      }
    },
    {
      "id": "virtual-85a6b270-8846-541c-9683-6a0d4a95fb33",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4b07ee70-6d34-42fe-b239-2f3226081fb3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4b07ee70-6d34-42fe-b239-2f3226081fb3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T12:11:21Z`
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







