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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e3d8afa5-47ba-4d37-a1b1-9da754b9e38c&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b2af991e-fd65-5eef-81a6-05d8637d7ba6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
          }
        }
      }
    },
    {
      "id": "virtual-c8f73d2b-5f76-5064-b09c-39dbed667409",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
          }
        }
      }
    },
    {
      "id": "virtual-7b2d0278-5e22-5211-bf0d-89b828f880d1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
          }
        }
      }
    },
    {
      "id": "virtual-850fc9ae-c8df-545c-8a97-5e8df2381dbc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
          }
        }
      }
    },
    {
      "id": "virtual-d7c49e18-b276-5bc7-a5d9-89deda5975b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
          }
        }
      }
    },
    {
      "id": "virtual-571d7be9-c373-504d-a9aa-b9c7600d6196",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
          }
        }
      }
    },
    {
      "id": "virtual-d59c4a4a-09c4-50c8-9bea-338abdba0612",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
          }
        }
      }
    },
    {
      "id": "virtual-57610b45-34cc-59d8-853e-8e546885fbfe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
          }
        }
      }
    },
    {
      "id": "virtual-91380316-b313-5249-ab4f-948cf2c41537",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
          }
        }
      }
    },
    {
      "id": "virtual-f4247838-3a76-59da-ae4d-a5b709dc1fed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8afa5-47ba-4d37-a1b1-9da754b9e38c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T08:11:38Z`
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







