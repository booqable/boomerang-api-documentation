# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

Note that when using URLs as numbers, it's advised to base64 encode the number before filtering.

## Endpoints
`GET /api/boomerang/barcodes`

`GET /api/boomerang/barcodes/{id}`

`POST /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

`DELETE /api/boomerang/barcodes/{id}`

## Fields
Every barcode has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order**<br>Associated Owner


## Listing barcodes



> How to fetch a list of barcodes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "01343167-6fa2-44fb-8f44-39d127b53220",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-05T09:12:24+00:00",
        "updated_at": "2022-05-05T09:12:24+00:00",
        "number": "http://bqbl.it/01343167-6fa2-44fb-8f44-39d127b53220",
        "barcode_type": "qr_code",
        "image_url": "/uploads/945ea841739374e36c17e2bd8dff23ba/barcode/image/01343167-6fa2-44fb-8f44-39d127b53220/4cb1008a-10b6-4191-b94e-68c090112ecc.svg",
        "owner_id": "63b70066-6b22-4ab8-8d40-319407551e73",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/63b70066-6b22-4ab8-8d40-319407551e73"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F60afa05f-05f2-4d8b-9446-9f3666ab7ae7&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "60afa05f-05f2-4d8b-9446-9f3666ab7ae7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-05T09:12:25+00:00",
        "updated_at": "2022-05-05T09:12:25+00:00",
        "number": "http://bqbl.it/60afa05f-05f2-4d8b-9446-9f3666ab7ae7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6bb30f17d9fef1dd0fd485305c732b31/barcode/image/60afa05f-05f2-4d8b-9446-9f3666ab7ae7/9d56f946-05d5-48bf-81ac-66dcadc4f425.svg",
        "owner_id": "790593ae-b057-4348-add8-d01645d5e9f2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/790593ae-b057-4348-add8-d01645d5e9f2"
          },
          "data": {
            "type": "customers",
            "id": "790593ae-b057-4348-add8-d01645d5e9f2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "790593ae-b057-4348-add8-d01645d5e9f2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-05T09:12:25+00:00",
        "updated_at": "2022-05-05T09:12:25+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Prohaska, Bins and Heidenreich",
        "email": "and.heidenreich.prohaska.bins@okuneva.biz",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=790593ae-b057-4348-add8-d01645d5e9f2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=790593ae-b057-4348-add8-d01645d5e9f2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=790593ae-b057-4348-add8-d01645d5e9f2&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTVlMjQxYzYtZDExMC00ZjA1LWE1NzYtYjBiZjNmNjRhMDY4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a5e241c6-d110-4f05-a576-b0bf3f64a068",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-05T09:12:25+00:00",
        "updated_at": "2022-05-05T09:12:25+00:00",
        "number": "http://bqbl.it/a5e241c6-d110-4f05-a576-b0bf3f64a068",
        "barcode_type": "qr_code",
        "image_url": "/uploads/dd279ca421ba58f2f91d13a400bfc5a6/barcode/image/a5e241c6-d110-4f05-a576-b0bf3f64a068/4d974092-05f9-44a2-a8ac-a6ae20cc165c.svg",
        "owner_id": "a34932b9-c8e9-4338-be0e-8646d784e4bd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a34932b9-c8e9-4338-be0e-8646d784e4bd"
          },
          "data": {
            "type": "customers",
            "id": "a34932b9-c8e9-4338-be0e-8646d784e4bd"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a34932b9-c8e9-4338-be0e-8646d784e4bd",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-05T09:12:25+00:00",
        "updated_at": "2022-05-05T09:12:25+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Balistreri and Sons",
        "email": "sons_and_balistreri@gottlieb.biz",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=a34932b9-c8e9-4338-be0e-8646d784e4bd&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a34932b9-c8e9-4338-be0e-8646d784e4bd&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a34932b9-c8e9-4338-be0e-8646d784e4bd&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T09:12:14Z`
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
`number` | **String**<br>`eq`
`barcode_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/d4c41cc1-a393-456e-bdfa-4a8292d2696a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d4c41cc1-a393-456e-bdfa-4a8292d2696a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-05T09:12:26+00:00",
      "updated_at": "2022-05-05T09:12:26+00:00",
      "number": "http://bqbl.it/d4c41cc1-a393-456e-bdfa-4a8292d2696a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/727c1eb5cd5f7594d31199b5d86da90b/barcode/image/d4c41cc1-a393-456e-bdfa-4a8292d2696a/f2d1c3cb-b315-47b0-8657-ced27ec63d56.svg",
      "owner_id": "6c60b01b-9ce1-4019-8db3-ca1877b6a5ca",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6c60b01b-9ce1-4019-8db3-ca1877b6a5ca"
        },
        "data": {
          "type": "customers",
          "id": "6c60b01b-9ce1-4019-8db3-ca1877b6a5ca"
        }
      }
    }
  },
  "included": [
    {
      "id": "6c60b01b-9ce1-4019-8db3-ca1877b6a5ca",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-05T09:12:26+00:00",
        "updated_at": "2022-05-05T09:12:26+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Roob, Rohan and Runolfsdottir",
        "email": "and.roob.runolfsdottir.rohan@schaden-quigley.biz",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=6c60b01b-9ce1-4019-8db3-ca1877b6a5ca&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6c60b01b-9ce1-4019-8db3-ca1877b6a5ca&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6c60b01b-9ce1-4019-8db3-ca1877b6a5ca&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`owner`






## Creating a barcode



> How to create a barcode:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/barcodes' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "barcodes",
        "attributes": {
          "barcode_type": "qr_code",
          "owner_id": "922c7382-e853-499a-81a6-b7db18ceb80d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a4423a93-11e9-48cf-a2bf-f1e21c824bfc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-05T09:12:26+00:00",
      "updated_at": "2022-05-05T09:12:26+00:00",
      "number": "http://bqbl.it/a4423a93-11e9-48cf-a2bf-f1e21c824bfc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8fa4d0bbfef62116df9f17338d3c1442/barcode/image/a4423a93-11e9-48cf-a2bf-f1e21c824bfc/0c6a9f48-8caf-49ff-9979-619e4aa920fd.svg",
      "owner_id": "922c7382-e853-499a-81a6-b7db18ceb80d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/barcodes`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/aa2fe141-b7f0-48d0-aa70-48ef5e11af65' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "aa2fe141-b7f0-48d0-aa70-48ef5e11af65",
        "type": "barcodes",
        "attributes": {
          "number": "https://myfancysite.com"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aa2fe141-b7f0-48d0-aa70-48ef5e11af65",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-05T09:12:27+00:00",
      "updated_at": "2022-05-05T09:12:27+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3854028a2429f535b411c153b6292493/barcode/image/aa2fe141-b7f0-48d0-aa70-48ef5e11af65/d62b954e-af8b-4c41-b711-936f64185015.svg",
      "owner_id": "03159b2f-d4e7-4fb8-98a9-4e0219955bdb",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String**<br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/15b28596-7b65-429d-a896-28f39624abe8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes