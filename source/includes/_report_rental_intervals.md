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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=24a80790-9fa4-4210-8504-95af74b051c7&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-02be924d-4e15-546d-a06a-774c6a8bd0b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
          }
        }
      }
    },
    {
      "id": "virtual-6d73dfa2-83f0-5b14-ae68-a75cb07a79aa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
          }
        }
      }
    },
    {
      "id": "virtual-bf659224-d116-5b45-87a7-59f58676deee",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
          }
        }
      }
    },
    {
      "id": "virtual-42b66a23-018d-5ca6-b930-aa95e61c33d8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
          }
        }
      }
    },
    {
      "id": "virtual-483f917a-8f88-541f-b46f-8460f421f009",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
          }
        }
      }
    },
    {
      "id": "virtual-d43ea5db-4cc6-51ad-b1cd-7e9817dab2b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
          }
        }
      }
    },
    {
      "id": "virtual-6f9db45e-f029-5ee3-bba2-b55e52ef3e51",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
          }
        }
      }
    },
    {
      "id": "virtual-ef5f9d67-89ce-5fdc-aeeb-515fa83b9014",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
          }
        }
      }
    },
    {
      "id": "virtual-83e4af14-92b2-5fd3-afbb-81810f58ff63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
          }
        }
      }
    },
    {
      "id": "virtual-98d20b39-fd61-56fd-98cc-91089ba3fe85",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24a80790-9fa4-4210-8504-95af74b051c7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24a80790-9fa4-4210-8504-95af74b051c7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:58:46Z`
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







