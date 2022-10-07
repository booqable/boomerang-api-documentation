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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b326819e-468f-4250-aee5-0627587f1e3c&filter%5Btill%5D=2022-10-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-16600318-e3bf-532f-9fba-65141e36778d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
          }
        }
      }
    },
    {
      "id": "virtual-fa1237eb-c0b4-5719-b861-743a0a853d4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
          }
        }
      }
    },
    {
      "id": "virtual-78696ea0-5e76-5f10-8277-3b02430e6884",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
          }
        }
      }
    },
    {
      "id": "virtual-b071b9bc-fb6f-5d18-aa5e-5a764ec69cfc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
          }
        }
      }
    },
    {
      "id": "virtual-865af226-c207-5f0f-867c-ebffb75e6c0f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
          }
        }
      }
    },
    {
      "id": "virtual-e6c00516-8730-5ac3-aa43-5de43ffa5b53",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
          }
        }
      }
    },
    {
      "id": "virtual-59548f3a-3839-53d2-a542-3bbf903f0ee7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
          }
        }
      }
    },
    {
      "id": "virtual-06223606-6e2b-5348-bcbf-f68f5bbb1ae3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
          }
        }
      }
    },
    {
      "id": "virtual-ee8baa2e-4496-5dbb-b0a8-a67fc74e8e41",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
          }
        }
      }
    },
    {
      "id": "virtual-04608122-f30e-5983-9bec-749b52975460",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b326819e-468f-4250-aee5-0627587f1e3c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b326819e-468f-4250-aee5-0627587f1e3c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T11:55:31Z`
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







