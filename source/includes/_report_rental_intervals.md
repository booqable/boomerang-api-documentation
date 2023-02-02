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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e7efa6ab-2249-4886-b5d4-3e384c7fcc0c&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-986ef99a-0045-57d7-9c9b-3926a6c3309f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
          }
        }
      }
    },
    {
      "id": "virtual-46ddd5ae-e4ce-56b3-9737-d85743be7e1d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
          }
        }
      }
    },
    {
      "id": "virtual-f3e99b2d-7b2e-51bb-bbf7-1fc385c49eb1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
          }
        }
      }
    },
    {
      "id": "virtual-8489661e-fa54-5e83-9560-463e276c61b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
          }
        }
      }
    },
    {
      "id": "virtual-3589d5b8-990e-546f-87ce-f81cdb788b58",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
          }
        }
      }
    },
    {
      "id": "virtual-8140ffae-dc21-5e23-b884-c6764d30e51d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
          }
        }
      }
    },
    {
      "id": "virtual-99355dc7-ebe5-57f7-9069-3ea87de7f8f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
          }
        }
      }
    },
    {
      "id": "virtual-e19655f3-c829-533a-a211-6826fe4ad5f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
          }
        }
      }
    },
    {
      "id": "virtual-7062592e-8c7f-5b80-81f5-ecaf62f9141f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
          }
        }
      }
    },
    {
      "id": "virtual-86d06250-183d-54ce-89d0-0e1d73d0eec2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e7efa6ab-2249-4886-b5d4-3e384c7fcc0c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T08:00:36Z`
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







