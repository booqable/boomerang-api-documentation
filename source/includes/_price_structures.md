# Price structures

Price structures enable you to control what is being priced for a specific period. Price structures consist of tiles that represent a period. The actual charge that is being calculated will always round up to the nearest tile it can find. You can also set up a flat-fee structure after you've run out of tiles by setting one of the following values: `hour`, `day`, `week`, `month`, `year`.

**There are two kinds of price structures:**

1. `reusable`: Structures that are reusable and that can be assigned to multiple product groups.
2. `private`: Structure for a specific product group. These are automatically created when a product group its `price_type` is set to `private_structure`.

## Endpoints
`GET /api/boomerang/price_structures`

`GET /api/boomerang/price_structures/{id}`

`POST /api/boomerang/price_structures`

`PUT /api/boomerang/price_structures/{id}`

`DELETE /api/boomerang/price_structures/{id}`

## Fields
Every price structure has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the structure
`archived_at` | **Datetime** `readonly`<br>Whether price structure is archived
`price_structure_type` | **String** `readonly`<br>One of `reusable`, `private`
`price_tiles_attributes` | **Array** `writeonly`<br>The price tiles to associate
`hour` | **Float**<br>Multiplier for every hour outside of its tiles
`day` | **Float**<br>Multiplier for every day outside of its tiles
`week` | **Float**<br>Multiplier for every week outside of its tiles
`month` | **Float**<br>Multiplier for every month outside of its tiles
`year` | **Float**<br>Multiplier for every year outside of its tiles


## Relationships
Price structures have the following relationships:

Name | Description
- | -
`price_tiles` | **Price tiles** `readonly`<br>Associated Price tiles


## Listing price structures



> How to fetch a list of price structures:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_structures' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e357a73a-1689-4865-a0d0-cc1770b11e87",
      "type": "price_structures",
      "attributes": {
        "created_at": "2021-12-07T11:02:28+00:00",
        "updated_at": "2021-12-07T11:02:28+00:00",
        "name": "Price per hour (3 hours minimum)",
        "archived_at": null,
        "price_structure_type": "reusable",
        "hour": 1.0,
        "day": 0.0,
        "week": 0.0,
        "month": 0.0,
        "year": 0.0
      },
      "relationships": {
        "price_tiles": {
          "links": {
            "related": "api/boomerang/price_tiles?filter[price_structure_id]=e357a73a-1689-4865-a0d0-cc1770b11e87"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/price_structures?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/price_structures?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/price_structures?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/price_structures`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-07T11:00:38Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_structure_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a price structure with it's tiles:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_structures/6909ef2b-d4df-4a49-aa27-139686a9632b?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6909ef2b-d4df-4a49-aa27-139686a9632b",
    "type": "price_structures",
    "attributes": {
      "created_at": "2021-12-07T11:02:29+00:00",
      "updated_at": "2021-12-07T11:02:29+00:00",
      "name": "Price per hour (3 hours minimum)",
      "archived_at": null,
      "price_structure_type": "reusable",
      "hour": 1.0,
      "day": 0.0,
      "week": 0.0,
      "month": 0.0,
      "year": 0.0
    },
    "relationships": {
      "price_tiles": {
        "links": {
          "related": "api/boomerang/price_tiles?filter[price_structure_id]=6909ef2b-d4df-4a49-aa27-139686a9632b"
        },
        "data": [
          {
            "type": "price_tiles",
            "id": "6bfb966f-ad21-4625-8726-0cbbfde4022e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6bfb966f-ad21-4625-8726-0cbbfde4022e",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2021-12-07T11:02:29+00:00",
        "updated_at": "2021-12-07T11:02:29+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "6909ef2b-d4df-4a49-aa27-139686a9632b"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/6909ef2b-d4df-4a49-aa27-139686a9632b"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/price_structures/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`price_tiles`






## Creating a price structure



> How to create a price structure with price tiles:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/price_structures' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "price_structures",
        "attributes": {
          "name": "Price per hour (3 hours minimum)",
          "hour": 1,
          "price_tiles_attributes": [
            {
              "name": "3 hours",
              "quantity": 3,
              "period": "hours",
              "multiplier": 1
            }
          ]
        }
      },
      "include": "price_tiles"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "110a68bc-fe95-4734-963a-4998b62651c0",
    "type": "price_structures",
    "attributes": {
      "created_at": "2021-12-07T11:02:29+00:00",
      "updated_at": "2021-12-07T11:02:29+00:00",
      "name": "Price per hour (3 hours minimum)",
      "archived_at": null,
      "price_structure_type": "reusable",
      "hour": 1.0,
      "day": 0.0,
      "week": 0.0,
      "month": 0.0,
      "year": 0.0
    },
    "relationships": {
      "price_tiles": {
        "data": [
          {
            "type": "price_tiles",
            "id": "0325fd1c-ebe9-4445-878d-e23112f2e25c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0325fd1c-ebe9-4445-878d-e23112f2e25c",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2021-12-07T11:02:29+00:00",
        "updated_at": "2021-12-07T11:02:29+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 1.0,
        "period": "hours",
        "price_structure_id": "110a68bc-fe95-4734-963a-4998b62651c0"
      },
      "relationships": {
        "price_structure": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/price_structures?data%5Battributes%5D%5Bhour%5D=1&data%5Battributes%5D%5Bname%5D=Price+per+hour+%283+hours+minimum%29&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bname%5D=3+hours&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bquantity%5D=3&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bperiod%5D=hours&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bmultiplier%5D=1&data%5Btype%5D=price_structures&include=price_tiles&page%5Bnumber%5D=1&page%5Bsize%5D=25&price_structure%5Bdata%5D%5Battributes%5D%5Bhour%5D=1&price_structure%5Bdata%5D%5Battributes%5D%5Bname%5D=Price+per+hour+%283+hours+minimum%29&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bname%5D=3+hours&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bquantity%5D=3&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bperiod%5D=hours&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bmultiplier%5D=1&price_structure%5Bdata%5D%5Btype%5D=price_structures&price_structure%5Binclude%5D=price_tiles",
    "first": "api/boomerang/price_structures?data%5Battributes%5D%5Bhour%5D=1&data%5Battributes%5D%5Bname%5D=Price+per+hour+%283+hours+minimum%29&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bname%5D=3+hours&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bquantity%5D=3&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bperiod%5D=hours&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bmultiplier%5D=1&data%5Btype%5D=price_structures&include=price_tiles&page%5Bnumber%5D=1&page%5Bsize%5D=25&price_structure%5Bdata%5D%5Battributes%5D%5Bhour%5D=1&price_structure%5Bdata%5D%5Battributes%5D%5Bname%5D=Price+per+hour+%283+hours+minimum%29&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bname%5D=3+hours&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bquantity%5D=3&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bperiod%5D=hours&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bmultiplier%5D=1&price_structure%5Bdata%5D%5Btype%5D=price_structures&price_structure%5Binclude%5D=price_tiles",
    "last": "api/boomerang/price_structures?data%5Battributes%5D%5Bhour%5D=1&data%5Battributes%5D%5Bname%5D=Price+per+hour+%283+hours+minimum%29&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bname%5D=3+hours&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bquantity%5D=3&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bperiod%5D=hours&data%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bmultiplier%5D=1&data%5Btype%5D=price_structures&include=price_tiles&page%5Bnumber%5D=1&page%5Bsize%5D=25&price_structure%5Bdata%5D%5Battributes%5D%5Bhour%5D=1&price_structure%5Bdata%5D%5Battributes%5D%5Bname%5D=Price+per+hour+%283+hours+minimum%29&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bname%5D=3+hours&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bquantity%5D=3&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bperiod%5D=hours&price_structure%5Bdata%5D%5Battributes%5D%5Bprice_tiles_attributes%5D%5B%5D%5Bmultiplier%5D=1&price_structure%5Bdata%5D%5Btype%5D=price_structures&price_structure%5Binclude%5D=price_tiles"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/price_structures`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the structure
`data[attributes][price_tiles_attributes][]` | **Array**<br>The price tiles to associate
`data[attributes][hour]` | **Float**<br>Multiplier for every hour outside of its tiles
`data[attributes][day]` | **Float**<br>Multiplier for every day outside of its tiles
`data[attributes][week]` | **Float**<br>Multiplier for every week outside of its tiles
`data[attributes][month]` | **Float**<br>Multiplier for every month outside of its tiles
`data[attributes][year]` | **Float**<br>Multiplier for every year outside of its tiles


### Includes

This request accepts the following includes:

`price_tiles`






## Updating a price structure



> How to update a price structure with price tiles:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_structures/b35d7d50-f880-4549-9b83-eec7dc045f66' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b35d7d50-f880-4549-9b83-eec7dc045f66",
        "type": "price_structures",
        "attributes": {
          "name": "Charge per week (cut-rate > 3 weeks)",
          "price_tiles_attributes": [
            {
              "id": "60ae4150-0bdc-4677-87c1-e832ad628db4",
              "name": "1 semana"
            },
            {
              "id": "f33c75fa-2825-444b-a03e-e8c60ab0fb8c",
              "name": "2 semanas"
            },
            {
              "id": "4a587157-5500-4940-8155-9789ddec201d",
              "name": "3 semanas"
            },
            {
              "id": "d708f314-33f9-4dff-a678-be8e89155082",
              "_destroy": true
            }
          ]
        }
      },
      "include": "price_tiles"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b35d7d50-f880-4549-9b83-eec7dc045f66",
    "type": "price_structures",
    "attributes": {
      "created_at": "2021-12-07T11:02:29+00:00",
      "updated_at": "2021-12-07T11:02:29+00:00",
      "name": "Charge per week (cut-rate > 3 weeks)",
      "archived_at": null,
      "price_structure_type": "reusable",
      "hour": 0.0,
      "day": 0.0,
      "week": 0.8,
      "month": 0.0,
      "year": 0.0
    },
    "relationships": {
      "price_tiles": {
        "data": [
          {
            "type": "price_tiles",
            "id": "60ae4150-0bdc-4677-87c1-e832ad628db4"
          },
          {
            "type": "price_tiles",
            "id": "f33c75fa-2825-444b-a03e-e8c60ab0fb8c"
          },
          {
            "type": "price_tiles",
            "id": "4a587157-5500-4940-8155-9789ddec201d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "60ae4150-0bdc-4677-87c1-e832ad628db4",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2021-12-07T11:02:29+00:00",
        "updated_at": "2021-12-07T11:02:29+00:00",
        "name": "1 semana",
        "quantity": 1,
        "length": 604800,
        "multiplier": 1.0,
        "period": "weeks",
        "price_structure_id": "b35d7d50-f880-4549-9b83-eec7dc045f66"
      },
      "relationships": {
        "price_structure": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "f33c75fa-2825-444b-a03e-e8c60ab0fb8c",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2021-12-07T11:02:29+00:00",
        "updated_at": "2021-12-07T11:02:29+00:00",
        "name": "2 semanas",
        "quantity": 2,
        "length": 1209600,
        "multiplier": 2.0,
        "period": "weeks",
        "price_structure_id": "b35d7d50-f880-4549-9b83-eec7dc045f66"
      },
      "relationships": {
        "price_structure": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "4a587157-5500-4940-8155-9789ddec201d",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2021-12-07T11:02:29+00:00",
        "updated_at": "2021-12-07T11:02:29+00:00",
        "name": "3 semanas",
        "quantity": 3,
        "length": 1814400,
        "multiplier": 3.0,
        "period": "weeks",
        "price_structure_id": "b35d7d50-f880-4549-9b83-eec7dc045f66"
      },
      "relationships": {
        "price_structure": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/price_structures/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the structure
`data[attributes][price_tiles_attributes][]` | **Array**<br>The price tiles to associate
`data[attributes][hour]` | **Float**<br>Multiplier for every hour outside of its tiles
`data[attributes][day]` | **Float**<br>Multiplier for every day outside of its tiles
`data[attributes][week]` | **Float**<br>Multiplier for every week outside of its tiles
`data[attributes][month]` | **Float**<br>Multiplier for every month outside of its tiles
`data[attributes][year]` | **Float**<br>Multiplier for every year outside of its tiles


### Includes

This request accepts the following includes:

`price_tiles`






## Deleting a price structure



> How to delete a price structure with tax rates:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_structures/deefd089-9c22-4022-93f7-305539bc5473' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/price_structures/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_tiles`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_structures]=id,created_at,updated_at`


### Includes

This request does not accept any includes