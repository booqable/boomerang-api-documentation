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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-1bc647ca-a441-5949-9cb2-f4443fca84d4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
          }
        }
      }
    },
    {
      "id": "virtual-c5d0c123-d973-52d7-9ac3-a9ba3445b78c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
          }
        }
      }
    },
    {
      "id": "virtual-c3a7884f-759e-501c-a532-8658e5a8b772",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
          }
        }
      }
    },
    {
      "id": "virtual-b6905ef5-73cf-5e2d-b31b-c3c2f8c8ef48",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
          }
        }
      }
    },
    {
      "id": "virtual-ca502290-6f2b-5380-966a-d83d32528fe1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
          }
        }
      }
    },
    {
      "id": "virtual-c9cb0187-1e08-5290-bae4-5113957e58f7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
          }
        }
      }
    },
    {
      "id": "virtual-838c2471-89f6-5401-a5e5-d910c2b7eb40",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
          }
        }
      }
    },
    {
      "id": "virtual-826d1219-fcf5-55e4-9820-262bda2607c6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
          }
        }
      }
    },
    {
      "id": "virtual-742cd3e4-67b0-5c21-acbe-8f9ce2551f78",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
          }
        }
      }
    },
    {
      "id": "virtual-4388e3e6-5ea0-583a-ba8c-679bc100f4f0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5d6aa3df-0d26-4ab6-b2db-af1ab0b66e82"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T07:55:22Z`
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







