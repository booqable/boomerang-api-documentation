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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=1ca3fc64-1c4b-411f-8b60-23c86c76962a&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-eeb05b75-5bcf-5826-95c8-70762ebc4369",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
          }
        }
      }
    },
    {
      "id": "virtual-4931cd61-76e2-5c68-a120-05c9bdd943fb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
          }
        }
      }
    },
    {
      "id": "virtual-99776aa6-9336-597c-96ff-97466a1e1c68",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
          }
        }
      }
    },
    {
      "id": "virtual-41e87e3f-8863-5ac1-a7fe-a74561c2c233",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
          }
        }
      }
    },
    {
      "id": "virtual-be972fde-b761-5b14-9bf1-a911db1da39d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
          }
        }
      }
    },
    {
      "id": "virtual-969db810-1d17-528d-bed3-6aeb14c7ac0f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
          }
        }
      }
    },
    {
      "id": "virtual-f824af5c-ffff-5194-bf0f-f7d3b14e6ecb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
          }
        }
      }
    },
    {
      "id": "virtual-b0b27ab2-c226-536d-8878-ed6e09107567",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
          }
        }
      }
    },
    {
      "id": "virtual-84c10e74-9458-57fb-98a4-819f3fade4ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
          }
        }
      }
    },
    {
      "id": "virtual-36d7b823-6645-5eed-b713-9a91246a0d67",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1ca3fc64-1c4b-411f-8b60-23c86c76962a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1ca3fc64-1c4b-411f-8b60-23c86c76962a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T15:24:28Z`
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







