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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-08+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=8b7744ce-c932-46ac-9202-02b11168c4dd&filter%5Btill%5D=2022-07-17+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f6794236-69be-5dd2-8bf7-1cea38027987",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
          }
        }
      }
    },
    {
      "id": "virtual-36e19b92-0158-5894-9c86-ced777bb54c2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
          }
        }
      }
    },
    {
      "id": "virtual-21c67c40-97c7-5913-840f-725e5f303254",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
          }
        }
      }
    },
    {
      "id": "virtual-74de85ad-e49e-5959-a05e-7a6489f22203",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
          }
        }
      }
    },
    {
      "id": "virtual-edc811c1-f1f4-54de-98a0-1cb46c086624",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
          }
        }
      }
    },
    {
      "id": "virtual-721fe997-9c05-55a2-a5e2-ed2e171abcf4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
          }
        }
      }
    },
    {
      "id": "virtual-7490bcb6-c625-5c0a-a4d7-6e5b1b2747fb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
          }
        }
      }
    },
    {
      "id": "virtual-13a8c598-49d8-52b9-a4c1-a1ada5f303e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
          }
        }
      }
    },
    {
      "id": "virtual-87c2dcc1-dc9b-5db0-92e9-7d273b54c123",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
          }
        }
      }
    },
    {
      "id": "virtual-85027f14-2694-5a16-bf0a-d1827bff2a3f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7744ce-c932-46ac-9202-02b11168c4dd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7744ce-c932-46ac-9202-02b11168c4dd"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-18T07:33:57Z`
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







