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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a74ba6a3-9702-4df0-9137-29d490885849&filter%5Btill%5D=2023-01-04+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-6ef2e399-85f2-5f19-9c48-fa26c0318bc3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
          }
        }
      }
    },
    {
      "id": "virtual-e7e475d8-cfd0-5168-b581-bdbf1c329f06",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
          }
        }
      }
    },
    {
      "id": "virtual-828b0fd2-b325-593b-be30-78f334d27a32",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
          }
        }
      }
    },
    {
      "id": "virtual-41abf4aa-05e8-5fdf-8344-a2e5a87c130f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
          }
        }
      }
    },
    {
      "id": "virtual-8172f31f-4057-536c-a350-7cbbbefa60a7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
          }
        }
      }
    },
    {
      "id": "virtual-8cf056a5-44d7-5bc9-9f40-eb3094d613bc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
          }
        }
      }
    },
    {
      "id": "virtual-7b7fc646-1e81-5909-924a-c02d521f45d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
          }
        }
      }
    },
    {
      "id": "virtual-a5f8d62b-1cab-5f46-b583-b532d041b49f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
          }
        }
      }
    },
    {
      "id": "virtual-ccb73917-d41d-57a3-a770-ce6a889c91b6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
          }
        }
      }
    },
    {
      "id": "virtual-f3c412b0-1524-5ee9-8808-11ffe1ffdf6e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74ba6a3-9702-4df0-9137-29d490885849"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74ba6a3-9702-4df0-9137-29d490885849"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:42:08Z`
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







