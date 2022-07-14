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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=657a8543-2e98-46a5-bb9e-e696b7ed98cd&filter%5Btill%5D=2022-07-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ac3092f3-e2fe-5524-946c-38f6746cf2af",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
          }
        }
      }
    },
    {
      "id": "virtual-78817af7-7229-51a9-9243-3b1a0f665f64",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
          }
        }
      }
    },
    {
      "id": "virtual-43e14501-9048-5a58-8978-d94922fc49f6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
          }
        }
      }
    },
    {
      "id": "virtual-6dafdf00-6033-5c1a-b4eb-a586e861aa57",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
          }
        }
      }
    },
    {
      "id": "virtual-bf41177c-4c78-5184-a68e-a30e3d06a8a4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
          }
        }
      }
    },
    {
      "id": "virtual-47a5ac19-b9d5-569e-8e82-77ca95cd7d89",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
          }
        }
      }
    },
    {
      "id": "virtual-7ebd460e-8992-5aa8-aa6e-36adc7046ae5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
          }
        }
      }
    },
    {
      "id": "virtual-ed7b6c8b-1916-566e-9ee0-c4ee9c628dc2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
          }
        }
      }
    },
    {
      "id": "virtual-08d44999-5d5d-51cd-bf1b-663003cba41d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
          }
        }
      }
    },
    {
      "id": "virtual-11aec946-6acd-5c59-806e-4473d8358410",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "657a8543-2e98-46a5-bb9e-e696b7ed98cd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/657a8543-2e98-46a5-bb9e-e696b7ed98cd"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T12:38:59Z`
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







