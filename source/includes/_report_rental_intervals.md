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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b0da9c0d-1082-46e7-b03e-7ab9318e5316&filter%5Btill%5D=2022-11-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8992ae07-4a87-56b6-88d7-98735ac307d0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
          }
        }
      }
    },
    {
      "id": "virtual-051e91a5-e579-56f6-9eda-0454edd8aff3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
          }
        }
      }
    },
    {
      "id": "virtual-76961b3e-19fe-5d29-b7bf-1d0f43ecdd6d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
          }
        }
      }
    },
    {
      "id": "virtual-be472d3f-54eb-5aa3-a81f-2a366f991f7d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
          }
        }
      }
    },
    {
      "id": "virtual-ea23b15f-87b9-505a-b76d-2e099494fe4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
          }
        }
      }
    },
    {
      "id": "virtual-fbbda818-4d7f-53de-9799-ea28534cd35e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
          }
        }
      }
    },
    {
      "id": "virtual-45da54f8-f1b7-53da-a368-d4cad221ff16",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
          }
        }
      }
    },
    {
      "id": "virtual-6856f2db-5307-5b34-b2dd-0c8f1e9e8c4c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
          }
        }
      }
    },
    {
      "id": "virtual-40e30329-5da9-58af-818b-e5060b467893",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
          }
        }
      }
    },
    {
      "id": "virtual-51ce2974-ea21-534b-b2ea-299f27f67a3a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b0da9c0d-1082-46e7-b03e-7ab9318e5316"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b0da9c0d-1082-46e7-b03e-7ab9318e5316"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T14:32:09Z`
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







