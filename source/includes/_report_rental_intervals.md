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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-13+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=f88e764e-c275-406d-a510-7217642cb667&filter%5Btill%5D=2023-02-22+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-2281ba62-17bc-5700-bc12-14324c0c17e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
          }
        }
      }
    },
    {
      "id": "virtual-1a602126-ebcc-5e74-bd87-4ba751fa0d92",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
          }
        }
      }
    },
    {
      "id": "virtual-c1bcceae-eafb-521d-b534-ab661ba08b2a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
          }
        }
      }
    },
    {
      "id": "virtual-e561a1a3-23dc-561b-ab6c-c69f6cb3bb5e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
          }
        }
      }
    },
    {
      "id": "virtual-c6b317e1-1d18-5d72-9d7a-bba6cff75cfd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
          }
        }
      }
    },
    {
      "id": "virtual-d802e383-f16d-582f-a87a-7292b526b706",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
          }
        }
      }
    },
    {
      "id": "virtual-6a10941e-e8da-5a3c-b4a5-0b96070716a0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
          }
        }
      }
    },
    {
      "id": "virtual-0c1d78a4-569a-5124-a354-b755a8dc7dc7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
          }
        }
      }
    },
    {
      "id": "virtual-d3a9afb7-2508-5591-932c-62078d6b46d4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
          }
        }
      }
    },
    {
      "id": "virtual-116a07f9-7da0-5d76-8d61-71c6f87d613d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f88e764e-c275-406d-a510-7217642cb667"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f88e764e-c275-406d-a510-7217642cb667"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T08:54:00Z`
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







