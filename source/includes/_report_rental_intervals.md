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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-17+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=da7d08e8-00f8-46f2-9939-3cb5aea97ce2&filter%5Btill%5D=2023-02-26+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a6b9907a-b16c-5814-9eef-427bf362ae36",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
          }
        }
      }
    },
    {
      "id": "virtual-6b613443-9168-5b02-939e-ee736fb22950",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
          }
        }
      }
    },
    {
      "id": "virtual-fb7a2695-e984-55b4-997f-89c26374b5b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
          }
        }
      }
    },
    {
      "id": "virtual-3243dd43-dc7f-5c8b-9e50-489b71d00b17",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
          }
        }
      }
    },
    {
      "id": "virtual-7ff10096-3cf2-56d5-900e-f4fbaa0eb480",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
          }
        }
      }
    },
    {
      "id": "virtual-a013f39d-0edf-5e18-9dc2-8e53d453ce4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
          }
        }
      }
    },
    {
      "id": "virtual-d9094635-2b4c-5e8b-89b9-d8d36d00a455",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
          }
        }
      }
    },
    {
      "id": "virtual-a6ae38bf-60b8-5a58-a6d3-a77839cb51be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
          }
        }
      }
    },
    {
      "id": "virtual-bb796e25-1500-5d35-bfd1-27c59315019f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
          }
        }
      }
    },
    {
      "id": "virtual-dc20ba9b-71a7-5438-ab0d-705dff45777a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da7d08e8-00f8-46f2-9939-3cb5aea97ce2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-27T10:45:15Z`
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







