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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50&filter%5Btill%5D=2023-02-05+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-d5f12018-32c0-5e77-af85-23a9faf029f0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
          }
        }
      }
    },
    {
      "id": "virtual-7ce7130c-7241-553d-a22a-a127f2d911ee",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
          }
        }
      }
    },
    {
      "id": "virtual-029a4ce8-580c-5cf7-a650-ecdb845b8e69",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
          }
        }
      }
    },
    {
      "id": "virtual-6f521a85-1516-5736-a313-714d76685153",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
          }
        }
      }
    },
    {
      "id": "virtual-e55928f1-076f-5944-bd9f-9a224b147b80",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
          }
        }
      }
    },
    {
      "id": "virtual-9b0c52ed-e0d9-5f83-a5bf-8161038dfffc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
          }
        }
      }
    },
    {
      "id": "virtual-e5e5835c-9c20-5983-90e6-c05c9ed5060f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
          }
        }
      }
    },
    {
      "id": "virtual-7fb23145-325c-5755-aec3-94bbf3535595",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
          }
        }
      }
    },
    {
      "id": "virtual-4c38585a-42ae-50bf-9d80-8e6326872499",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
          }
        }
      }
    },
    {
      "id": "virtual-c19ece53-e605-50ea-b2b6-cc718bf443d0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c38b7e56-2f0f-4b73-a1b6-57d0e31ceb50"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T19:28:10Z`
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







