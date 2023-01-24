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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b7eff357-cf8a-42e0-9195-9c39ca4f7791&filter%5Btill%5D=2023-01-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-7fa0eb03-a3fa-5449-bc95-2baf27cc1bf6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
          }
        }
      }
    },
    {
      "id": "virtual-eea7d2fe-fdb2-5fd2-8225-8f109de336aa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
          }
        }
      }
    },
    {
      "id": "virtual-b87f706b-06df-55b5-823c-920aeb81512b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
          }
        }
      }
    },
    {
      "id": "virtual-01f01ccc-d2c3-5cc3-8e8b-cb7e9d62b4fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
          }
        }
      }
    },
    {
      "id": "virtual-8c7dbe97-6ede-5955-8105-ee9a9e3f6a11",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
          }
        }
      }
    },
    {
      "id": "virtual-d788b630-583c-57a2-b809-fd4e75de46fb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
          }
        }
      }
    },
    {
      "id": "virtual-42a3f539-c83a-5dfb-b661-d417d12b99e9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
          }
        }
      }
    },
    {
      "id": "virtual-eb04ee6d-1f86-5f8a-937a-051a6cc57c9f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
          }
        }
      }
    },
    {
      "id": "virtual-5354493d-65d6-5634-9ef3-8c9de84b1ea0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
          }
        }
      }
    },
    {
      "id": "virtual-2ba35bc7-ab12-565b-a01a-87381a9d55dc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b7eff357-cf8a-42e0-9195-9c39ca4f7791"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b7eff357-cf8a-42e0-9195-9c39ca4f7791"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T14:00:04Z`
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







