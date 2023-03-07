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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=bf48e5fe-4176-45cb-a2ac-9ff2624410d6&filter%5Btill%5D=2023-03-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-9e374403-0b20-5c96-a9d9-71a2f3e486a9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
          }
        }
      }
    },
    {
      "id": "virtual-817d10d3-61d7-5f88-a308-581f345c5f54",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
          }
        }
      }
    },
    {
      "id": "virtual-973490bc-0cd7-5dab-afc6-8726827b20ea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
          }
        }
      }
    },
    {
      "id": "virtual-8e5fb96c-9433-560a-b854-ad57223dbcda",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
          }
        }
      }
    },
    {
      "id": "virtual-b61bd198-54ef-5ec0-9e5c-2d4cc385c5c9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
          }
        }
      }
    },
    {
      "id": "virtual-59a3f74f-3c27-5622-b4f6-3620315ee94c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
          }
        }
      }
    },
    {
      "id": "virtual-50534fa7-ed39-5ad4-8e0f-a5d956482299",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
          }
        }
      }
    },
    {
      "id": "virtual-fb38e5ec-f525-5cde-94a6-eeca0bfef4f9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
          }
        }
      }
    },
    {
      "id": "virtual-766e5e36-bb1c-5293-9298-211b68ce3935",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
          }
        }
      }
    },
    {
      "id": "virtual-79d79bff-527f-5a99-a5af-d61698e9cc29",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf48e5fe-4176-45cb-a2ac-9ff2624410d6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T08:07:14Z`
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







