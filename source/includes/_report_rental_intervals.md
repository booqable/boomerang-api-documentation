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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4043514a-fe86-45ef-a70a-53388348ab52&filter%5Btill%5D=2023-01-04+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0b1b9c70-76a6-5775-9c25-e07d65bf0b85",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
          }
        }
      }
    },
    {
      "id": "virtual-4edf8767-d5f9-5b40-b960-bb83a7679db4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
          }
        }
      }
    },
    {
      "id": "virtual-98c99c93-f08b-5e86-9e02-d76d4cf9db9a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
          }
        }
      }
    },
    {
      "id": "virtual-8407987d-50aa-596c-9fb4-81a247d5d249",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
          }
        }
      }
    },
    {
      "id": "virtual-c8be4f2c-9abf-5278-b84e-e5742c25f03e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
          }
        }
      }
    },
    {
      "id": "virtual-1132723e-125d-5806-a5d2-a703663de6ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
          }
        }
      }
    },
    {
      "id": "virtual-fbc0bba1-1cbc-5f1d-bf0a-d2765cf5e6fc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
          }
        }
      }
    },
    {
      "id": "virtual-5b854ced-9992-5fc9-86cb-06c574b77bb7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
          }
        }
      }
    },
    {
      "id": "virtual-879649ac-0f15-523f-91ab-be600ddea51f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
          }
        }
      }
    },
    {
      "id": "virtual-1f41fe19-f24e-5f96-9e03-89c0a439d72b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4043514a-fe86-45ef-a70a-53388348ab52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4043514a-fe86-45ef-a70a-53388348ab52"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T11:25:38Z`
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







