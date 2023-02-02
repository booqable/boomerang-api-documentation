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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=fcb7a95a-5571-41f3-86a9-d554ee50b723&filter%5Btill%5D=2023-02-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0b28c19a-dc59-5d6f-9ee7-110e9d4066ae",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
          }
        }
      }
    },
    {
      "id": "virtual-7bab2198-df0e-5b9f-918a-d6dc63dd8a3e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
          }
        }
      }
    },
    {
      "id": "virtual-c3f5c5aa-a858-52e6-9622-74390da0b258",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
          }
        }
      }
    },
    {
      "id": "virtual-76944331-6a86-50b0-9856-8f7560161960",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
          }
        }
      }
    },
    {
      "id": "virtual-a7cee779-8425-5013-8d53-d049cc2d8111",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
          }
        }
      }
    },
    {
      "id": "virtual-374856eb-2e00-53ab-968d-870e14407216",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
          }
        }
      }
    },
    {
      "id": "virtual-22c535ff-a30c-5f22-bd26-3747a4f0a769",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
          }
        }
      }
    },
    {
      "id": "virtual-90c4ccb7-b86d-517f-a82e-247ce86c2e41",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
          }
        }
      }
    },
    {
      "id": "virtual-15b45627-7d4f-5d7b-b7ff-6e75c8b4f117",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
          }
        }
      }
    },
    {
      "id": "virtual-60b295f5-95ba-50cd-8253-b1da55b6c974",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fcb7a95a-5571-41f3-86a9-d554ee50b723"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fcb7a95a-5571-41f3-86a9-d554ee50b723"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:36:16Z`
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







