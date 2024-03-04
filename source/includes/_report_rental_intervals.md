# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-02-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e3d8d02d-98e8-4f8c-83cf-aaca802b11b0&filter%5Btill%5D=2024-03-03+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "92d47772-225f-46c0-9e58-be4d53b06eb1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
          }
        }
      }
    },
    {
      "id": "11ce8866-c51e-453d-94ec-7cc1f673cb48",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
          }
        }
      }
    },
    {
      "id": "ca6b2e16-322f-414c-9692-8b7056391161",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
          }
        }
      }
    },
    {
      "id": "9ff0c8aa-abcd-435c-996f-c10376fc791e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
          }
        }
      }
    },
    {
      "id": "05dffe91-66b5-4395-bfbb-d27be0515545",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
          }
        }
      }
    },
    {
      "id": "63f217c5-67fd-4d5c-86a5-453234013e3f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
          }
        }
      }
    },
    {
      "id": "af2b1dc6-a8be-4776-b539-51a5b7b61be0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
          }
        }
      }
    },
    {
      "id": "a2760738-1b46-4e54-b66d-9a081758bf8c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
          }
        }
      }
    },
    {
      "id": "901197aa-26f1-407b-bc7b-476961f7a1bf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
          }
        }
      }
    },
    {
      "id": "c502d25d-08b3-4885-93ee-b0857f31e25c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e3d8d02d-98e8-4f8c-83cf-aaca802b11b0"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







