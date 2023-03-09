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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=12945804-940b-4d8f-9100-fdc9109d5bc6&filter%5Btill%5D=2023-03-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f3dbda9d-e7f8-592f-b805-e9715d761960",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
          }
        }
      }
    },
    {
      "id": "virtual-63b18c9f-e55c-57c5-9071-f4fd0d5696c3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
          }
        }
      }
    },
    {
      "id": "virtual-25f889b4-7f33-586c-9bbc-2e8790f83e7d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
          }
        }
      }
    },
    {
      "id": "virtual-abda338d-54bd-5dda-ab70-fb526293dc1d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
          }
        }
      }
    },
    {
      "id": "virtual-e98ca0c1-1d6b-5506-b904-343130e9ff3d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
          }
        }
      }
    },
    {
      "id": "virtual-cf675e4d-b19b-59af-a19f-3f313d6bd91d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
          }
        }
      }
    },
    {
      "id": "virtual-93bc50b6-2039-51ed-b818-24553abcf59e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
          }
        }
      }
    },
    {
      "id": "virtual-7306c45a-5ddb-5516-bc7a-6679b31a9011",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
          }
        }
      }
    },
    {
      "id": "virtual-cac9fb00-8639-5b7a-861f-d41b1535a747",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
          }
        }
      }
    },
    {
      "id": "virtual-f787bcb5-614d-5ad0-bd80-bb8e34b12264",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12945804-940b-4d8f-9100-fdc9109d5bc6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12945804-940b-4d8f-9100-fdc9109d5bc6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T08:56:36Z`
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







