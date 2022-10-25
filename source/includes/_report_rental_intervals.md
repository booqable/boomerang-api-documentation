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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-15+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b3f35ba6-7ce5-4f9a-b023-69cc23314838&filter%5Btill%5D=2022-10-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-2534b71e-4f02-50c2-9370-bde8fa326c59",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
          }
        }
      }
    },
    {
      "id": "virtual-5249a464-13f3-585d-ad5b-f3452efcb446",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
          }
        }
      }
    },
    {
      "id": "virtual-0865099f-0855-5f16-9598-7b8c41234de5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
          }
        }
      }
    },
    {
      "id": "virtual-8745ed75-e27a-56b6-8a07-610095673326",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
          }
        }
      }
    },
    {
      "id": "virtual-0fe90755-4a0f-5658-8c52-53b7e1c27934",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
          }
        }
      }
    },
    {
      "id": "virtual-7786009c-b4ab-5692-925f-5aaeda0c91c2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
          }
        }
      }
    },
    {
      "id": "virtual-57f0cb15-7061-51de-b73e-33b96b93b121",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
          }
        }
      }
    },
    {
      "id": "virtual-029f75b8-cb93-5538-96cf-9a831fe4a369",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
          }
        }
      }
    },
    {
      "id": "virtual-69022425-4f53-5859-b839-ded62b532ef5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
          }
        }
      }
    },
    {
      "id": "virtual-73c6d419-f1d5-5d33-8348-47300c8f8c3c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b3f35ba6-7ce5-4f9a-b023-69cc23314838"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b3f35ba6-7ce5-4f9a-b023-69cc23314838"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T18:48:25Z`
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







