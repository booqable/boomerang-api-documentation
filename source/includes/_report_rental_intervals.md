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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=f7c4f969-de8e-42ae-92b1-acc2b0e54a3d&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-445a714d-2192-5def-ae6a-ae5f36a2b0d4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
          }
        }
      }
    },
    {
      "id": "virtual-3b422bb5-ee53-5f35-be4a-ef5fc2b9ac8f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
          }
        }
      }
    },
    {
      "id": "virtual-9f721d33-01ef-51ed-b38b-fbf890b325c2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
          }
        }
      }
    },
    {
      "id": "virtual-cdd42fee-3c2a-5a4f-99a5-b75c0bf495da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
          }
        }
      }
    },
    {
      "id": "virtual-79f82754-6f91-59c5-bb49-46b7711f210f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
          }
        }
      }
    },
    {
      "id": "virtual-0e3af119-8993-59e0-9cdf-a453aa0cc59e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
          }
        }
      }
    },
    {
      "id": "virtual-4960bec7-82aa-5f69-b700-b78695efaa4e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
          }
        }
      }
    },
    {
      "id": "virtual-59a0963a-a667-5b6c-bb6c-63e3f5ba8577",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
          }
        }
      }
    },
    {
      "id": "virtual-b5e41880-29c2-5c38-a24e-f1245451dbd7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
          }
        }
      }
    },
    {
      "id": "virtual-f162074a-b2e3-5651-8728-4d6651ba39b6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f7c4f969-de8e-42ae-92b1-acc2b0e54a3d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T23:11:26Z`
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







