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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=76f3ba4e-f058-4832-b8dc-7ba0daa4936f&filter%5Btill%5D=2023-02-02+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e0446383-212c-5fe7-a4c3-fcac8fb256b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
          }
        }
      }
    },
    {
      "id": "virtual-bceb69d5-e9f7-5bc9-9ad2-6fe2cb232bd6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
          }
        }
      }
    },
    {
      "id": "virtual-7ed64cad-d48a-50ab-9869-bf34203bcfde",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
          }
        }
      }
    },
    {
      "id": "virtual-8f9d20fa-82e5-5fe2-8c2e-1445432ecba6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
          }
        }
      }
    },
    {
      "id": "virtual-c1a89beb-ee73-5041-8b70-5e95187dee11",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
          }
        }
      }
    },
    {
      "id": "virtual-11cbc173-4de2-5419-83c0-53cb9a767ce2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
          }
        }
      }
    },
    {
      "id": "virtual-6cc934d4-dcd0-5300-a105-034f6998f88d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
          }
        }
      }
    },
    {
      "id": "virtual-303fd092-4492-5e8a-9fcb-eb0d2f499044",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
          }
        }
      }
    },
    {
      "id": "virtual-97913207-020f-5b9a-a786-846eaa189506",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
          }
        }
      }
    },
    {
      "id": "virtual-043ce931-afa1-5725-b6b8-29c73b782c86",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/76f3ba4e-f058-4832-b8dc-7ba0daa4936f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T08:13:30Z`
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







