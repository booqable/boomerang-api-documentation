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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=50a7ed60-b9c0-46fe-8cb3-4c159c1ac165&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8fbed027-0c00-5edb-8868-3b4801f61e60",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
          }
        }
      }
    },
    {
      "id": "virtual-655ac03c-36a1-5584-99ba-89caa528ea18",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
          }
        }
      }
    },
    {
      "id": "virtual-32cd49b4-8514-55cc-a48b-267ca87b51ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
          }
        }
      }
    },
    {
      "id": "virtual-3ffdb83e-505e-52ce-af67-b2e0c56ecff9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
          }
        }
      }
    },
    {
      "id": "virtual-c6dbe7f0-189a-5d27-b837-82ebbb7e5827",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
          }
        }
      }
    },
    {
      "id": "virtual-186ad756-1d6b-550f-95b0-68dd490fe9c9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
          }
        }
      }
    },
    {
      "id": "virtual-adfd84ce-d274-5220-815f-45de6daba36a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
          }
        }
      }
    },
    {
      "id": "virtual-34287baf-fd08-51eb-b580-55c28f6db489",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
          }
        }
      }
    },
    {
      "id": "virtual-77b0cdb9-602c-5c85-bdd8-ca5c9014f86e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
          }
        }
      }
    },
    {
      "id": "virtual-e9715135-5184-5a7b-82ff-1291aac647ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/50a7ed60-b9c0-46fe-8cb3-4c159c1ac165"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T15:34:16Z`
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







