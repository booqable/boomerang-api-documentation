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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-20+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2eb650f9-4f65-409a-a21d-dbf27426cd0e&filter%5Btill%5D=2023-03-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-31c30823-4ac8-5b49-8a39-c87cca427a12",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
          }
        }
      }
    },
    {
      "id": "virtual-c271ab4b-44d4-5ec7-9e89-418b0b720515",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
          }
        }
      }
    },
    {
      "id": "virtual-4748c3ad-4150-5c47-870d-abeee90cc40e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
          }
        }
      }
    },
    {
      "id": "virtual-2ff2c615-e869-56a6-8f72-576f89f6b57e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
          }
        }
      }
    },
    {
      "id": "virtual-b7bbd475-547e-5864-a596-b486b71125e8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
          }
        }
      }
    },
    {
      "id": "virtual-74dce7c3-bf5b-53ac-a6c1-8e0fd524431d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
          }
        }
      }
    },
    {
      "id": "virtual-46122b7e-f16a-50cb-a254-b81f95f672ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
          }
        }
      }
    },
    {
      "id": "virtual-531ea9a4-097f-531a-8c43-1becc15fdf97",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
          }
        }
      }
    },
    {
      "id": "virtual-798d41dc-9da4-5b3e-8958-a28026489052",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
          }
        }
      }
    },
    {
      "id": "virtual-80aee0b7-c0a2-5093-8099-859f2994594e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2eb650f9-4f65-409a-a21d-dbf27426cd0e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2eb650f9-4f65-409a-a21d-dbf27426cd0e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T12:39:03Z`
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







