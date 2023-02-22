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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=f385b650-eac7-466d-888f-904e7908e306&filter%5Btill%5D=2023-02-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-226ed5c9-6b9e-5774-9e51-bce98a28109b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
          }
        }
      }
    },
    {
      "id": "virtual-41d91aae-371a-54f0-858f-836198c17714",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
          }
        }
      }
    },
    {
      "id": "virtual-474b8ff7-8fa4-5e6a-98d2-fab3fe4460ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
          }
        }
      }
    },
    {
      "id": "virtual-a0087055-56f9-5461-868e-c3f77f684679",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
          }
        }
      }
    },
    {
      "id": "virtual-225e402d-2234-529b-9263-8716360875c0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
          }
        }
      }
    },
    {
      "id": "virtual-182e877c-9b15-5d7c-a28e-b05e56041dd1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
          }
        }
      }
    },
    {
      "id": "virtual-b3424f25-530f-5341-851c-65b609c5fac4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
          }
        }
      }
    },
    {
      "id": "virtual-9e13a3f8-1940-5f5f-8938-8ea3b69e839a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
          }
        }
      }
    },
    {
      "id": "virtual-be590c77-d23f-52a0-bd8e-6ff13cf6d642",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
          }
        }
      }
    },
    {
      "id": "virtual-369c9cd2-3c22-5069-9aaf-4a77c0bf272b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f385b650-eac7-466d-888f-904e7908e306"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f385b650-eac7-466d-888f-904e7908e306"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T08:39:29Z`
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







