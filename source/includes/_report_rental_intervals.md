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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b245a98f-1b13-44c3-afce-74c561cab38c&filter%5Btill%5D=2023-02-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-69e1e20e-3986-52f4-8ad7-272b35c2b2b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
          }
        }
      }
    },
    {
      "id": "virtual-4b8dc77e-ae5d-5847-9ff6-1b027945e973",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
          }
        }
      }
    },
    {
      "id": "virtual-1accbb92-49a6-5574-933b-3f97b977cc98",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
          }
        }
      }
    },
    {
      "id": "virtual-a729e547-8f33-50d1-af12-d1983c184632",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
          }
        }
      }
    },
    {
      "id": "virtual-75374407-e56a-59b8-8047-7e430f1b88f6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
          }
        }
      }
    },
    {
      "id": "virtual-5f4f0b3b-f97c-5b55-94ba-283b18cd0e85",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
          }
        }
      }
    },
    {
      "id": "virtual-e194fd97-2672-5b45-b55a-acfc8947f880",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
          }
        }
      }
    },
    {
      "id": "virtual-53f7b6b9-73f5-5e19-bebb-a1c34dd82d09",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
          }
        }
      }
    },
    {
      "id": "virtual-1f7a7ab5-3243-588c-979f-0c16eaac1b46",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
          }
        }
      }
    },
    {
      "id": "virtual-cbd75437-80a5-5d5e-817c-ae88e1def45a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b245a98f-1b13-44c3-afce-74c561cab38c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b245a98f-1b13-44c3-afce-74c561cab38c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T14:12:16Z`
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







