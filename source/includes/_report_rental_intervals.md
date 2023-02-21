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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=ed1f0983-df8c-45b1-8cd5-26472b402692&filter%5Btill%5D=2023-02-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-01b0691a-e31e-55bb-a321-c8c9d8dc2d40",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
          }
        }
      }
    },
    {
      "id": "virtual-af5e1f5d-772e-553b-97a3-1bbe2be68b13",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
          }
        }
      }
    },
    {
      "id": "virtual-a7c37ab3-0956-5a50-aabf-b38bf995f2cd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
          }
        }
      }
    },
    {
      "id": "virtual-09d2c3c4-d67e-5070-b170-a5c5a1c77c46",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
          }
        }
      }
    },
    {
      "id": "virtual-53f9d352-86ff-522f-adbe-140d206b9ca9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
          }
        }
      }
    },
    {
      "id": "virtual-659e1fc7-fb3f-5068-b284-a4deafa2bb0b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
          }
        }
      }
    },
    {
      "id": "virtual-66ad3745-cb11-5dfb-a355-9f94264f9579",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
          }
        }
      }
    },
    {
      "id": "virtual-31241412-9245-5516-9acb-035639e8bf75",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
          }
        }
      }
    },
    {
      "id": "virtual-4be707f2-ece1-523f-9ccc-4960f58b086c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
          }
        }
      }
    },
    {
      "id": "virtual-834bc312-eb9b-5415-ba1b-facb561855c0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ed1f0983-df8c-45b1-8cd5-26472b402692"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ed1f0983-df8c-45b1-8cd5-26472b402692"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T12:15:26Z`
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







