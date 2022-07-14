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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=07cf0ec9-ed16-40a0-ab54-be4a773c0741&filter%5Btill%5D=2022-07-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e21d4790-dd1a-5c53-b635-522ee10e2287",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
          }
        }
      }
    },
    {
      "id": "virtual-175d9342-1b13-54c8-962f-5d988043e739",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
          }
        }
      }
    },
    {
      "id": "virtual-581b9648-1ecd-5ba5-9d51-f8f11c09c4fa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
          }
        }
      }
    },
    {
      "id": "virtual-6ae05ce6-f2e2-5c40-9c37-3541363e2c39",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
          }
        }
      }
    },
    {
      "id": "virtual-4304acec-48f0-529c-9a86-20c54aeed67f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
          }
        }
      }
    },
    {
      "id": "virtual-82bd0017-e2b7-5f50-a588-bb8235e52363",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
          }
        }
      }
    },
    {
      "id": "virtual-2e62f534-4f7b-5673-8e95-99658e3c6239",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
          }
        }
      }
    },
    {
      "id": "virtual-77419686-09a7-5c5c-8291-f7b702464c04",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
          }
        }
      }
    },
    {
      "id": "virtual-8f35af3d-c159-508a-a463-d2ae520c45a8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
          }
        }
      }
    },
    {
      "id": "virtual-963afeaf-51c3-54ba-b632-55191d312eb7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "07cf0ec9-ed16-40a0-ab54-be4a773c0741"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/07cf0ec9-ed16-40a0-ab54-be4a773c0741"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T21:13:00Z`
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







