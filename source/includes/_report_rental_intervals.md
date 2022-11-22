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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b8687ff0-8a81-4646-a784-7d092d742d13&filter%5Btill%5D=2022-11-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-fdf8ff64-7d43-54ce-976a-5e6995767507",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
          }
        }
      }
    },
    {
      "id": "virtual-63be1629-8ce4-521d-872e-97460a747018",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
          }
        }
      }
    },
    {
      "id": "virtual-7739be39-baef-5707-9fc7-09a4f8833384",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
          }
        }
      }
    },
    {
      "id": "virtual-0951e997-7632-5a62-b3b0-6348c0ca2267",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
          }
        }
      }
    },
    {
      "id": "virtual-bab6ba31-9beb-5f58-b91a-2f252ce49db5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
          }
        }
      }
    },
    {
      "id": "virtual-2def5369-1f38-525e-9ae4-1448df3250d4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
          }
        }
      }
    },
    {
      "id": "virtual-190b2c95-a7d2-55d7-8b81-a6080b21a736",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
          }
        }
      }
    },
    {
      "id": "virtual-e92e5a0f-4668-5576-ab17-bc45870df622",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
          }
        }
      }
    },
    {
      "id": "virtual-f054394c-6db6-57e8-beaa-52f7193a942a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
          }
        }
      }
    },
    {
      "id": "virtual-1aa2f632-12f7-5563-98f6-589bbfbff44e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b8687ff0-8a81-4646-a784-7d092d742d13"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b8687ff0-8a81-4646-a784-7d092d742d13"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:34:25Z`
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







