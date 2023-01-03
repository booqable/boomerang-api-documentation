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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b50a5967-06a9-4c9d-9c47-89e391e44e86&filter%5Btill%5D=2023-01-02+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f8d10742-8312-5339-8b97-203ffd8c047a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
          }
        }
      }
    },
    {
      "id": "virtual-ee075a75-dc74-580d-adf6-9e02e234bc4f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
          }
        }
      }
    },
    {
      "id": "virtual-63946290-7845-55c0-91ae-d2091bb33df6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
          }
        }
      }
    },
    {
      "id": "virtual-06342692-131a-5c09-8d31-b5ed2ec753a3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
          }
        }
      }
    },
    {
      "id": "virtual-eba68ddf-7c52-5b4a-8264-be0b57ee642d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
          }
        }
      }
    },
    {
      "id": "virtual-6732136a-5390-5951-a03e-4f8bda675ba4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
          }
        }
      }
    },
    {
      "id": "virtual-5e7f6ee3-0f5b-5e89-a66c-26d473b3b852",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
          }
        }
      }
    },
    {
      "id": "virtual-a538e98c-8277-52b6-bf44-bcaef6d46f46",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
          }
        }
      }
    },
    {
      "id": "virtual-2c82da73-7ac8-5278-915c-dd0f8df48e8c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
          }
        }
      }
    },
    {
      "id": "virtual-a1be9042-884f-5c23-bcb6-e2df88e002a2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b50a5967-06a9-4c9d-9c47-89e391e44e86"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b50a5967-06a9-4c9d-9c47-89e391e44e86"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-03T12:11:08Z`
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







