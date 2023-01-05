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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2bf01165-5158-4edf-ba56-0d20e3e18542&filter%5Btill%5D=2023-01-04+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8073386f-2501-5fd5-9f64-2358d8a98ef4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
          }
        }
      }
    },
    {
      "id": "virtual-d0190989-0c10-56f2-990e-d9dabd4133fa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
          }
        }
      }
    },
    {
      "id": "virtual-4d22a7b9-6815-5709-962a-7e26a7cf0281",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
          }
        }
      }
    },
    {
      "id": "virtual-2263065f-bcbf-5d3a-85b4-af2bd66ae4c1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
          }
        }
      }
    },
    {
      "id": "virtual-4f425582-085a-5042-9ca4-7e4c93acb30c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
          }
        }
      }
    },
    {
      "id": "virtual-0e0063ae-449f-50d7-bdd0-5d65a172afc8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
          }
        }
      }
    },
    {
      "id": "virtual-59931687-d028-519f-a27a-1d02188ae4c6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
          }
        }
      }
    },
    {
      "id": "virtual-41533cad-6848-5737-88aa-777e2730c257",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
          }
        }
      }
    },
    {
      "id": "virtual-4f89c579-ab5b-540c-b162-af23423cf618",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
          }
        }
      }
    },
    {
      "id": "virtual-335ef66c-4182-5c70-b82f-62c3eef29ccf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bf01165-5158-4edf-ba56-0d20e3e18542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bf01165-5158-4edf-ba56-0d20e3e18542"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T16:26:10Z`
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







