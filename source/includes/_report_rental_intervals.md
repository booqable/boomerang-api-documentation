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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=838df01f-077c-4c60-9ca4-ceca21b5befa&filter%5Btill%5D=2023-03-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-9633b2e5-5a74-5ab2-b17c-cc6562e914c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
          }
        }
      }
    },
    {
      "id": "virtual-0b6ebe10-c7ec-5c9a-845d-96d5c0ddd389",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
          }
        }
      }
    },
    {
      "id": "virtual-40c9e1ed-b6a3-578c-8b34-dfff660e07d8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
          }
        }
      }
    },
    {
      "id": "virtual-e0e77402-abfd-5930-9f18-ff312b27a163",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
          }
        }
      }
    },
    {
      "id": "virtual-745c9949-1b52-5372-8f92-4ff0668196f5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
          }
        }
      }
    },
    {
      "id": "virtual-db14ba03-abd5-5a35-a894-92cfa1447cae",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
          }
        }
      }
    },
    {
      "id": "virtual-b991b741-b7dc-58a1-b7f4-91c2fdc1a19d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
          }
        }
      }
    },
    {
      "id": "virtual-0c2a34d2-d636-58ed-bc6f-047c6af0f2a2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
          }
        }
      }
    },
    {
      "id": "virtual-49fbfac5-855f-579e-97bd-66dc7a8b8573",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
          }
        }
      }
    },
    {
      "id": "virtual-581eecf7-6120-5b14-b96b-f3a283f974ea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "838df01f-077c-4c60-9ca4-ceca21b5befa"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/838df01f-077c-4c60-9ca4-ceca21b5befa"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T08:56:25Z`
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







