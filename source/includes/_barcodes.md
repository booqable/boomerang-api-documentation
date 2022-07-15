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
      "id": "7abf0bc5-6dfc-4627-933d-12e65a3f9e4c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-15T09:53:04+00:00",
        "updated_at": "2022-07-15T09:53:04+00:00",
        "number": "http://bqbl.it/7abf0bc5-6dfc-4627-933d-12e65a3f9e4c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4260acccd0ad749472ca80f7eac8ae40/barcode/image/7abf0bc5-6dfc-4627-933d-12e65a3f9e4c/a14be2a0-ec01-4cec-b6dc-08bc206057c8.svg",
        "owner_id": "836446f0-85a6-405a-94a4-11d9e45670e1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/836446f0-85a6-405a-94a4-11d9e45670e1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdf149601-f631-4c35-bc41-0d803b3a175b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "df149601-f631-4c35-bc41-0d803b3a175b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-15T09:53:05+00:00",
        "updated_at": "2022-07-15T09:53:05+00:00",
        "number": "http://bqbl.it/df149601-f631-4c35-bc41-0d803b3a175b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/01ecacb2273fd0338e7611009f9c48fa/barcode/image/df149601-f631-4c35-bc41-0d803b3a175b/01c7f151-cec1-448c-89f5-d215eb49b76a.svg",
        "owner_id": "f99c3342-49d3-4d9a-990b-b5c692de49bb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f99c3342-49d3-4d9a-990b-b5c692de49bb"
          },
          "data": {
            "type": "customers",
            "id": "f99c3342-49d3-4d9a-990b-b5c692de49bb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f99c3342-49d3-4d9a-990b-b5c692de49bb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-15T09:53:05+00:00",
        "updated_at": "2022-07-15T09:53:05+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Durgan-Hessel",
        "email": "durgan_hessel@greenfelder.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=f99c3342-49d3-4d9a-990b-b5c692de49bb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f99c3342-49d3-4d9a-990b-b5c692de49bb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f99c3342-49d3-4d9a-990b-b5c692de49bb&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjRhYjRiYjctMTkwZC00ODEwLTlhOGItZTZjZTkzZWNhOTg1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "24ab4bb7-190d-4810-9a8b-e6ce93eca985",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-15T09:53:06+00:00",
        "updated_at": "2022-07-15T09:53:06+00:00",
        "number": "http://bqbl.it/24ab4bb7-190d-4810-9a8b-e6ce93eca985",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ac430991dbc2d9b7526ed6231c5d800a/barcode/image/24ab4bb7-190d-4810-9a8b-e6ce93eca985/527a3e80-6985-45c8-9f40-4bc52d72c0c0.svg",
        "owner_id": "ee9910a5-06fa-4b42-99a1-2359436fd515",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ee9910a5-06fa-4b42-99a1-2359436fd515"
          },
          "data": {
            "type": "customers",
            "id": "ee9910a5-06fa-4b42-99a1-2359436fd515"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ee9910a5-06fa-4b42-99a1-2359436fd515",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-15T09:53:06+00:00",
        "updated_at": "2022-07-15T09:53:06+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Quitzon-Bednar",
        "email": "quitzon_bednar@heaney.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=ee9910a5-06fa-4b42-99a1-2359436fd515&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ee9910a5-06fa-4b42-99a1-2359436fd515&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ee9910a5-06fa-4b42-99a1-2359436fd515&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T09:52:44Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f762374d-82fc-400a-9c8f-2f935f34ea7e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f762374d-82fc-400a-9c8f-2f935f34ea7e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-15T09:53:06+00:00",
      "updated_at": "2022-07-15T09:53:06+00:00",
      "number": "http://bqbl.it/f762374d-82fc-400a-9c8f-2f935f34ea7e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d32b11d00eec2c236f2973da7cb0c453/barcode/image/f762374d-82fc-400a-9c8f-2f935f34ea7e/d2cf7352-1a66-4caf-9b50-bad5626b672a.svg",
      "owner_id": "18617517-6b2e-46b5-953e-9e48764bc36b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/18617517-6b2e-46b5-953e-9e48764bc36b"
        },
        "data": {
          "type": "customers",
          "id": "18617517-6b2e-46b5-953e-9e48764bc36b"
        }
      }
    }
  },
  "included": [
    {
      "id": "18617517-6b2e-46b5-953e-9e48764bc36b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-15T09:53:06+00:00",
        "updated_at": "2022-07-15T09:53:06+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Bins LLC",
        "email": "llc.bins@leffler-crist.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=18617517-6b2e-46b5-953e-9e48764bc36b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=18617517-6b2e-46b5-953e-9e48764bc36b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=18617517-6b2e-46b5-953e-9e48764bc36b&filter[owner_type]=customers"
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
          "owner_id": "b9470124-a73d-4a2c-8a27-28989124581d",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3a8578f1-97a3-483f-b8e3-c2131b1a2976",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-15T09:53:07+00:00",
      "updated_at": "2022-07-15T09:53:07+00:00",
      "number": "http://bqbl.it/3a8578f1-97a3-483f-b8e3-c2131b1a2976",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c381cdf1d86ef189d48a07c6462c4882/barcode/image/3a8578f1-97a3-483f-b8e3-c2131b1a2976/d4a04a04-1086-4974-9037-bbf535142ce0.svg",
      "owner_id": "b9470124-a73d-4a2c-8a27-28989124581d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e73166bd-8fba-481b-b985-d50c40ee5585' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e73166bd-8fba-481b-b985-d50c40ee5585",
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
    "id": "e73166bd-8fba-481b-b985-d50c40ee5585",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-15T09:53:08+00:00",
      "updated_at": "2022-07-15T09:53:08+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b30dcd13c5db375b6efc08829e6688b3/barcode/image/e73166bd-8fba-481b-b985-d50c40ee5585/e7636d01-a9f0-4574-90ef-91c65b05d532.svg",
      "owner_id": "422e40fa-6590-4d3f-bb73-8bb6504df543",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ab444889-0bbf-4e40-ab2b-26a5d4bd16b2' \
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