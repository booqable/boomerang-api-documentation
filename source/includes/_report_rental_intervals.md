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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-15+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2352b82d-7612-4680-a694-d5a92f4c9898&filter%5Btill%5D=2022-10-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a12e3cdc-b801-5d90-b002-558803147d68",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
          }
        }
      }
    },
    {
      "id": "virtual-db1d4afa-5869-5385-853a-5cda2f728346",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
          }
        }
      }
    },
    {
      "id": "virtual-c32a1a41-caed-5211-86e2-e86f36c5763c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
          }
        }
      }
    },
    {
      "id": "virtual-a03adce7-80a6-5e97-b8a9-676d99809e4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
          }
        }
      }
    },
    {
      "id": "virtual-fb3264f4-08f8-5aff-b98f-dd048e261449",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
          }
        }
      }
    },
    {
      "id": "virtual-c3620839-707e-5074-93ac-7dc0a9a9fa54",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
          }
        }
      }
    },
    {
      "id": "virtual-8b569cd4-3fde-5572-98ea-324f3735e0e7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
          }
        }
      }
    },
    {
      "id": "virtual-c35fb5e0-05db-57a4-9d38-c3728aebf0ed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
          }
        }
      }
    },
    {
      "id": "virtual-33b0c0a7-403c-5330-949d-f9105d6a0934",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
          }
        }
      }
    },
    {
      "id": "virtual-bfe55497-c4b8-52fa-af92-9a1b4d94d597",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2352b82d-7612-4680-a694-d5a92f4c9898"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2352b82d-7612-4680-a694-d5a92f4c9898"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T19:08:43Z`
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







