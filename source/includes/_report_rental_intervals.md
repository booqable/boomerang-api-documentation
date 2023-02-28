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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-18+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=87ded965-e7cd-4976-afa6-8dd494e35cbc&filter%5Btill%5D=2023-02-27+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-293a8747-011d-5046-bc38-9af7e3e298c0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
          }
        }
      }
    },
    {
      "id": "virtual-438541be-40b8-50d3-9a0b-f99f7f2d5b75",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
          }
        }
      }
    },
    {
      "id": "virtual-ec003aba-8846-5271-b5be-017fe464df05",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
          }
        }
      }
    },
    {
      "id": "virtual-8302f140-ae65-5d3e-887c-5100ec7fd3dc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
          }
        }
      }
    },
    {
      "id": "virtual-b3a1abea-42eb-54e8-9710-475ee4d15af7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
          }
        }
      }
    },
    {
      "id": "virtual-ddadaa6c-999f-530e-a7b9-355bc94420ea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
          }
        }
      }
    },
    {
      "id": "virtual-46007b3c-d338-5ad6-bf1c-17eaceb0d45a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
          }
        }
      }
    },
    {
      "id": "virtual-d56324b1-493a-5bb6-a100-3e23e80f60e5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
          }
        }
      }
    },
    {
      "id": "virtual-bf13472b-6cae-569c-a8cc-c2ab42d65be6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
          }
        }
      }
    },
    {
      "id": "virtual-2799024d-92e1-5407-9b47-645e45248c2e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "87ded965-e7cd-4976-afa6-8dd494e35cbc"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/87ded965-e7cd-4976-afa6-8dd494e35cbc"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T08:10:21Z`
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







