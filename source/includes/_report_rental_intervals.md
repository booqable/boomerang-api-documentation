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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-20+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e411287e-5a88-4e71-b160-550c841115c6&filter%5Btill%5D=2023-03-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-01eb345b-b4fe-5f58-a9c6-36cb12859629",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
          }
        }
      }
    },
    {
      "id": "virtual-bcb6e8c0-cfbd-5657-802b-32bd2d3ff640",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
          }
        }
      }
    },
    {
      "id": "virtual-493b625f-d5f3-564d-91ca-5c5c725d73e7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
          }
        }
      }
    },
    {
      "id": "virtual-a4658762-5015-59f7-abcb-6dabb908a4f0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
          }
        }
      }
    },
    {
      "id": "virtual-30b25204-97c6-5e75-b2bb-835ced2f6413",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
          }
        }
      }
    },
    {
      "id": "virtual-c98bda38-3a50-5eb2-9513-e5ba3214cec1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
          }
        }
      }
    },
    {
      "id": "virtual-f357c7cd-d773-5735-ba1e-7655fa81bc8e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
          }
        }
      }
    },
    {
      "id": "virtual-724af7a0-470a-59c4-b4d2-c52fb4a35997",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
          }
        }
      }
    },
    {
      "id": "virtual-d57014af-7df2-5747-a8eb-b11e4601275b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
          }
        }
      }
    },
    {
      "id": "virtual-efcb0a95-635f-5b9c-a98f-6823b60be69b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e411287e-5a88-4e71-b160-550c841115c6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e411287e-5a88-4e71-b160-550c841115c6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T13:53:57Z`
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







