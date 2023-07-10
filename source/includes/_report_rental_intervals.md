# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-06-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a6a77bd4-aa76-4b66-b76a-c7185f57316f&filter%5Btill%5D=2023-07-09+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-53a2bd99-f73a-52f0-8952-1dfb4cc183db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-06-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
          }
        }
      }
    },
    {
      "id": "virtual-a13d2cd9-fcec-57c7-93a1-6a510bc37711",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-07-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
          }
        }
      }
    },
    {
      "id": "virtual-b4c0fb55-5c37-5f6d-94dd-9ec2ad1c7bbb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-07-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
          }
        }
      }
    },
    {
      "id": "virtual-f334405c-b01a-594a-9c15-5f055c76513b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-07-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
          }
        }
      }
    },
    {
      "id": "virtual-7978382d-2319-50f1-be98-1c7fd7b76c2f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-07-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
          }
        }
      }
    },
    {
      "id": "virtual-6fc9bc2e-dc42-59f3-91fc-f4aa4790fa59",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
          }
        }
      }
    },
    {
      "id": "virtual-c2a5e82a-9a97-510c-b794-ac135b5df321",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-07-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
          }
        }
      }
    },
    {
      "id": "virtual-8c3cf212-dc87-56cf-86f5-b4a1a91a2d90",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
          }
        }
      }
    },
    {
      "id": "virtual-35882b2a-e103-5f9e-9598-51ce202c3514",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-07-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
          }
        }
      }
    },
    {
      "id": "virtual-d6135d98-ec41-52de-ba4d-46fd3d1a5a84",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a6a77bd4-aa76-4b66-b76a-c7185f57316f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a6a77bd4-aa76-4b66-b76a-c7185f57316f"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







