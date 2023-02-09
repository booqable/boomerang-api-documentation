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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=8678397b-9cb2-4ab9-bdf9-65d5c0c1a676&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e7409108-ff25-5c35-98ba-c4373c47c9ee",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
          }
        }
      }
    },
    {
      "id": "virtual-c9d28f74-3fbd-5ab2-814a-abc5a0d09062",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
          }
        }
      }
    },
    {
      "id": "virtual-ea1c2d01-336d-59b0-af0c-a603ff9575ab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
          }
        }
      }
    },
    {
      "id": "virtual-1ed2f45d-8554-5bc4-8b0b-a8692a181732",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
          }
        }
      }
    },
    {
      "id": "virtual-8367c669-abff-5667-b7a3-9dabb7167f8d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
          }
        }
      }
    },
    {
      "id": "virtual-10d2f8ec-95d7-5add-95d7-7ae82e44898e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
          }
        }
      }
    },
    {
      "id": "virtual-b47175dd-94b7-586d-a894-dfd024ed0547",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
          }
        }
      }
    },
    {
      "id": "virtual-3c4e0b0d-e83a-5669-aa37-01b0e4984aed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
          }
        }
      }
    },
    {
      "id": "virtual-eb8c68b0-8e98-5caf-bca1-0f77d31f46ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
          }
        }
      }
    },
    {
      "id": "virtual-1fac9de0-d817-5b67-8665-9c9f121668e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8678397b-9cb2-4ab9-bdf9-65d5c0c1a676"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T12:59:10Z`
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







