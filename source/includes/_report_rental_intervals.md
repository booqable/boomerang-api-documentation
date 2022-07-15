# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-05+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=abafb52b-7ffc-41e9-9060-22bf97b5c3c7&filter%5Btill%5D=2022-07-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-2aba72db-e9f0-5ae9-afd5-a05e3cb24bc6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
          }
        }
      }
    },
    {
      "id": "virtual-038ec239-6529-5011-9a0d-3dacac509f67",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
          }
        }
      }
    },
    {
      "id": "virtual-68a952a3-2c88-53c3-9a46-e1cce0f9e887",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
          }
        }
      }
    },
    {
      "id": "virtual-8033c0f4-ff02-5de2-9d57-0083116fae2b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
          }
        }
      }
    },
    {
      "id": "virtual-50efb377-82af-51bf-80d9-6dbf1b0b2ed8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
          }
        }
      }
    },
    {
      "id": "virtual-6f61cec5-d11f-5e71-87f6-9b8580ca2a77",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
          }
        }
      }
    },
    {
      "id": "virtual-2db9379b-7d35-53ee-a32d-11422cb36305",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
          }
        }
      }
    },
    {
      "id": "virtual-640b25bf-da60-547a-803e-1b928e13043c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
          }
        }
      }
    },
    {
      "id": "virtual-bdfca7f2-6fae-52c1-a0fd-3091efeb809d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
          }
        }
      }
    },
    {
      "id": "virtual-64d49b3d-8900-55f8-a587-4e7c6b48d859",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/abafb52b-7ffc-41e9-9060-22bf97b5c3c7"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T09:22:34Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







