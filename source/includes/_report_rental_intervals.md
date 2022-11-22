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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=5de3d9d2-e6cc-46a5-9334-1662409aeb89&filter%5Btill%5D=2022-11-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-7931d0ba-390b-537d-8fab-7d17327a8e5e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
          }
        }
      }
    },
    {
      "id": "virtual-a270d0fb-de0f-58bb-8411-8fbdac43316c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
          }
        }
      }
    },
    {
      "id": "virtual-f7177b9c-c89a-508d-a882-f47f45d8a773",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
          }
        }
      }
    },
    {
      "id": "virtual-04573239-75a5-55e3-a4e5-d0701d28f848",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
          }
        }
      }
    },
    {
      "id": "virtual-6bc3941e-2368-55b1-8030-a92a0859a0e4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
          }
        }
      }
    },
    {
      "id": "virtual-3e7a3612-0bab-5b06-850d-8a6fd5d90c43",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
          }
        }
      }
    },
    {
      "id": "virtual-12ddd029-8019-5e63-b93c-1410a363ba73",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
          }
        }
      }
    },
    {
      "id": "virtual-0932f5a8-d5d3-5a5b-bb0e-c937aaaf9fba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
          }
        }
      }
    },
    {
      "id": "virtual-d7e528b5-d5cc-50f4-bdc0-a75e0ef8c74a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
          }
        }
      }
    },
    {
      "id": "virtual-a358b6b0-ad3f-5eb5-a637-84f065c56d14",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5de3d9d2-e6cc-46a5-9334-1662409aeb89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5de3d9d2-e6cc-46a5-9334-1662409aeb89"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T14:40:43Z`
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







