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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-08-09+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=22c2b5be-0d07-424e-ad25-2e84a7291b2e&filter%5Btill%5D=2022-08-18+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e977bd8f-e419-5945-9ac2-3aab4ce248af",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
          }
        }
      }
    },
    {
      "id": "virtual-ebc8d56e-bf62-57fc-baed-cc5ec6ea259b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
          }
        }
      }
    },
    {
      "id": "virtual-9042d709-af45-514a-9a93-aa55cd01dd49",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
          }
        }
      }
    },
    {
      "id": "virtual-aaad29fe-95f7-5012-a3ec-bdb90e9f44b6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
          }
        }
      }
    },
    {
      "id": "virtual-99981dfb-039b-505d-b685-e76f625268f5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
          }
        }
      }
    },
    {
      "id": "virtual-68af9862-f250-5c3a-a3f8-14dddb17b24c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
          }
        }
      }
    },
    {
      "id": "virtual-d366b06f-2e40-5005-aa08-fcd29d8960db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
          }
        }
      }
    },
    {
      "id": "virtual-bda7dc23-7a1c-5105-a163-d99d9aef77f6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
          }
        }
      }
    },
    {
      "id": "virtual-f2c4c684-364c-529c-88c1-6e644154b6e2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
          }
        }
      }
    },
    {
      "id": "virtual-f4234634-8a81-5554-b113-68ab112b64da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "22c2b5be-0d07-424e-ad25-2e84a7291b2e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/22c2b5be-0d07-424e-ad25-2e84a7291b2e"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-08-19T07:55:05Z`
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







