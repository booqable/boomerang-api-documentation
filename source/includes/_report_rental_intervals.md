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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c9c60ff2-f28f-4805-ac0b-a548ec3b1877&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ba2cb142-04fb-5c91-94f6-fa386c4d8032",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
          }
        }
      }
    },
    {
      "id": "virtual-1d520146-c9f7-5441-af9e-f4550d088d3e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
          }
        }
      }
    },
    {
      "id": "virtual-69bc7241-1442-514e-809f-17213f4eeccd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
          }
        }
      }
    },
    {
      "id": "virtual-7653cbce-2598-5a94-baa5-ff52ead5bb9f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
          }
        }
      }
    },
    {
      "id": "virtual-78eeb3ab-7302-5659-9f1b-522ed21135ff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
          }
        }
      }
    },
    {
      "id": "virtual-48e48d98-bac3-54ee-a88b-af7e812e72a3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
          }
        }
      }
    },
    {
      "id": "virtual-0c5b4002-532a-5fa7-8606-0a7e5f26134f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
          }
        }
      }
    },
    {
      "id": "virtual-d5934e4f-febe-5f28-9f1c-145d9a3644d3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
          }
        }
      }
    },
    {
      "id": "virtual-8f467be2-bb23-5ab6-8103-9a6956859390",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
          }
        }
      }
    },
    {
      "id": "virtual-622cca34-82b3-55c9-aca8-111c6abd419c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c9c60ff2-f28f-4805-ac0b-a548ec3b1877"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:13:58Z`
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







