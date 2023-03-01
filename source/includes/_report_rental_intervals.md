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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-19+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=321aa62a-a937-4c9f-8f4a-7b784c819ab9&filter%5Btill%5D=2023-02-28+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b24dbf3b-ced4-5af7-a0b2-253848b10a85",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
          }
        }
      }
    },
    {
      "id": "virtual-9e4fec15-4008-57d5-8fcb-56626791c079",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
          }
        }
      }
    },
    {
      "id": "virtual-750104a0-ec0d-5afe-9a93-5baf2c67a91e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
          }
        }
      }
    },
    {
      "id": "virtual-459bc0a3-5f28-5232-af27-c7efb281f977",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
          }
        }
      }
    },
    {
      "id": "virtual-08ad9c04-0378-5aa8-b8c8-15cc2ba36761",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
          }
        }
      }
    },
    {
      "id": "virtual-83e9e070-23a2-5a29-8987-5276a1c1b2fb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
          }
        }
      }
    },
    {
      "id": "virtual-ad2ba596-956e-5e39-84ac-0225e4bc1788",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
          }
        }
      }
    },
    {
      "id": "virtual-3f646fb5-3299-5bf8-9d5d-e651c2d1a054",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
          }
        }
      }
    },
    {
      "id": "virtual-a0c743a4-fd73-5542-b786-749b156dfa1d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
          }
        }
      }
    },
    {
      "id": "virtual-4da2f0ec-8052-5383-82f6-33e9627838e2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "321aa62a-a937-4c9f-8f4a-7b784c819ab9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/321aa62a-a937-4c9f-8f4a-7b784c819ab9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T09:59:27Z`
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







