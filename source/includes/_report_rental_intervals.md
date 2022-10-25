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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-15+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=089ff206-3d4d-488c-9e64-c0c0917ddcce&filter%5Btill%5D=2022-10-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c0e82cdb-205e-56e0-a538-e3b192cc5c6a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
          }
        }
      }
    },
    {
      "id": "virtual-374150a1-a6e3-59c2-8d16-8024f565de2c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
          }
        }
      }
    },
    {
      "id": "virtual-464ea6fb-312c-5e1f-b4e4-958d147dcc61",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
          }
        }
      }
    },
    {
      "id": "virtual-db1cc5dd-9d8e-50b8-a02b-b04d9e3c8bae",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
          }
        }
      }
    },
    {
      "id": "virtual-3c068946-fe80-5006-af4e-da53926020b4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
          }
        }
      }
    },
    {
      "id": "virtual-2c6bf497-e6b2-50aa-8951-ff6d1fe0be40",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
          }
        }
      }
    },
    {
      "id": "virtual-788ced08-c486-5bb0-b4f6-cb34aa85b1eb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
          }
        }
      }
    },
    {
      "id": "virtual-bcb4785b-ebfd-58e7-8eda-ffd1c253ffe0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
          }
        }
      }
    },
    {
      "id": "virtual-e0af6d5d-75d3-543a-964c-ff17952b6864",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
          }
        }
      }
    },
    {
      "id": "virtual-5df15bff-56f3-548a-97ef-2ad89a754319",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "089ff206-3d4d-488c-9e64-c0c0917ddcce"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/089ff206-3d4d-488c-9e64-c0c0917ddcce"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T17:50:56Z`
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







