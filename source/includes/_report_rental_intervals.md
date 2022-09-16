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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=833af466-de9c-4927-8138-6e26a77bd020&filter%5Btill%5D=2022-09-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-13229bd3-7451-5b8f-af1d-1d9112e571c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
          }
        }
      }
    },
    {
      "id": "virtual-4910a07d-3590-5fb7-be5f-3dd4f594323e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
          }
        }
      }
    },
    {
      "id": "virtual-868c87c6-94d3-5fd0-b322-5b2d7287d031",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
          }
        }
      }
    },
    {
      "id": "virtual-c00836a1-de1b-5f17-a8bd-5a1db45e2a64",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
          }
        }
      }
    },
    {
      "id": "virtual-e8727d5a-165a-58bd-a7ac-9ad54e4853a4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
          }
        }
      }
    },
    {
      "id": "virtual-1fb9236e-5e13-5118-97e9-74f6b6c5c728",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
          }
        }
      }
    },
    {
      "id": "virtual-09d89ec0-71cc-5fae-a7f8-76ce7f33b0f5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
          }
        }
      }
    },
    {
      "id": "virtual-1b0bf3b8-9817-5aa8-9a58-47279b08dfde",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
          }
        }
      }
    },
    {
      "id": "virtual-a3d66cca-6ec1-55bf-a622-f5caa3b23a47",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
          }
        }
      }
    },
    {
      "id": "virtual-c2fd59d9-8b7c-5d18-a9ff-b3ca8c94f9e8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "833af466-de9c-4927-8138-6e26a77bd020"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/833af466-de9c-4927-8138-6e26a77bd020"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T11:48:02Z`
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







