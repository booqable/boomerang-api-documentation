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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=de2d019e-ac49-4867-a7e0-3471f743b3b0&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8149c78b-ba5f-5097-9356-509fa52bde3c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
          }
        }
      }
    },
    {
      "id": "virtual-04afd823-5075-5df9-8a12-3f2c03e85077",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
          }
        }
      }
    },
    {
      "id": "virtual-0c50c19e-46f4-597a-962a-dc00f2fd045b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
          }
        }
      }
    },
    {
      "id": "virtual-5de5d55f-e2eb-5f62-a135-a6e5c5690e9b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
          }
        }
      }
    },
    {
      "id": "virtual-bdafa247-aea5-549a-b176-c9a2099b9df9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
          }
        }
      }
    },
    {
      "id": "virtual-32fb3e18-a6de-51de-9697-6c30da3b038e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
          }
        }
      }
    },
    {
      "id": "virtual-40e572cb-9741-5cc4-911f-19d19bca9d5a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
          }
        }
      }
    },
    {
      "id": "virtual-476b565d-f4d3-5d83-a502-63843d696708",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
          }
        }
      }
    },
    {
      "id": "virtual-0e72ec2b-f7dc-5280-a1fa-004bc5db0a31",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
          }
        }
      }
    },
    {
      "id": "virtual-194299d6-9d1f-51d3-b5e3-9ca1c3af93f1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de2d019e-ac49-4867-a7e0-3471f743b3b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/de2d019e-ac49-4867-a7e0-3471f743b3b0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:17:41Z`
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







