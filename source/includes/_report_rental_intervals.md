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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-19+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=7a0b12ce-e8cd-4086-a858-518d9ed36d9f&filter%5Btill%5D=2023-02-28+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-18dc190a-ab74-5616-9048-f233c7509077",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
          }
        }
      }
    },
    {
      "id": "virtual-6e2a3f30-dc9c-523f-94f6-52b0efd16727",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
          }
        }
      }
    },
    {
      "id": "virtual-7a75607b-9ad6-590a-a3c0-5b3e57865e0c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
          }
        }
      }
    },
    {
      "id": "virtual-d68d2a63-ff0a-5a7c-8d6e-bd3d537abe1e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
          }
        }
      }
    },
    {
      "id": "virtual-049d00af-ca95-5d01-b196-331125ec7f02",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
          }
        }
      }
    },
    {
      "id": "virtual-4ba21597-9724-517e-9294-505e900f5c72",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
          }
        }
      }
    },
    {
      "id": "virtual-918f9c8f-2d40-542b-91f0-11ec5fb1d270",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
          }
        }
      }
    },
    {
      "id": "virtual-eacf4e1b-b9c5-587b-8aa5-9d77efd1739f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
          }
        }
      }
    },
    {
      "id": "virtual-3e11786b-4ee1-5978-96f9-6ee9ee198ebc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
          }
        }
      }
    },
    {
      "id": "virtual-0ae03ba4-fc48-5752-ac85-55f55cc74e15",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7a0b12ce-e8cd-4086-a858-518d9ed36d9f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:15:15Z`
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







