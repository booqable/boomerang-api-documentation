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
      "id": "84d9fc5e-e029-470d-a754-47bfe5ac8b93",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-13T07:09:43+00:00",
        "updated_at": "2022-04-13T07:09:43+00:00",
        "number": "http://bqbl.it/84d9fc5e-e029-470d-a754-47bfe5ac8b93",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e585897b4bf107548c836730bbcc396c/barcode/image/84d9fc5e-e029-470d-a754-47bfe5ac8b93/af006044-bd1a-4bc3-b3da-12cfdceda15c.svg",
        "owner_id": "1f6210b6-53af-4d07-862d-22189382971c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1f6210b6-53af-4d07-862d-22189382971c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F75b6de9e-94ba-479b-b554-494ca05783b4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "75b6de9e-94ba-479b-b554-494ca05783b4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-13T07:09:44+00:00",
        "updated_at": "2022-04-13T07:09:44+00:00",
        "number": "http://bqbl.it/75b6de9e-94ba-479b-b554-494ca05783b4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/586f8f5111e827d0a5c81744e8090f78/barcode/image/75b6de9e-94ba-479b-b554-494ca05783b4/4a0b352b-c72b-4b05-a615-95f806fe4d79.svg",
        "owner_id": "80e62b9c-95ea-487d-871a-7a163256f53b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/80e62b9c-95ea-487d-871a-7a163256f53b"
          },
          "data": {
            "type": "customers",
            "id": "80e62b9c-95ea-487d-871a-7a163256f53b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "80e62b9c-95ea-487d-871a-7a163256f53b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-13T07:09:44+00:00",
        "updated_at": "2022-04-13T07:09:44+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Rohan and Sons",
        "email": "rohan_and_sons@bayer.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=80e62b9c-95ea-487d-871a-7a163256f53b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=80e62b9c-95ea-487d-871a-7a163256f53b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=80e62b9c-95ea-487d-871a-7a163256f53b&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjUyMjFiMjgtNDg1Ny00NDM3LWE0MGEtOTJjZjQzZjUzZTY4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "25221b28-4857-4437-a40a-92cf43f53e68",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-04-13T07:09:45+00:00",
        "updated_at": "2022-04-13T07:09:45+00:00",
        "number": "http://bqbl.it/25221b28-4857-4437-a40a-92cf43f53e68",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6e8b5c09056cce78625d1ee0465797f6/barcode/image/25221b28-4857-4437-a40a-92cf43f53e68/dff36961-b113-4f2b-986f-eed81475fd5d.svg",
        "owner_id": "a2f041d5-d929-4c41-bf37-955ff6b2d403",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a2f041d5-d929-4c41-bf37-955ff6b2d403"
          },
          "data": {
            "type": "customers",
            "id": "a2f041d5-d929-4c41-bf37-955ff6b2d403"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a2f041d5-d929-4c41-bf37-955ff6b2d403",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-13T07:09:45+00:00",
        "updated_at": "2022-04-13T07:09:45+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Ward-Grimes",
        "email": "grimes.ward@armstrong.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=a2f041d5-d929-4c41-bf37-955ff6b2d403&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a2f041d5-d929-4c41-bf37-955ff6b2d403&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a2f041d5-d929-4c41-bf37-955ff6b2d403&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-13T07:09:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/779fdd88-2ab2-491f-971c-946a0725a185?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "779fdd88-2ab2-491f-971c-946a0725a185",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-13T07:09:45+00:00",
      "updated_at": "2022-04-13T07:09:45+00:00",
      "number": "http://bqbl.it/779fdd88-2ab2-491f-971c-946a0725a185",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ac86f7c9c9d481c09a8c6247013b1a0c/barcode/image/779fdd88-2ab2-491f-971c-946a0725a185/0fc3f165-dc5a-41be-baf6-59ec6d88bea8.svg",
      "owner_id": "e2335382-51f0-4234-95e0-3a57ea93ea5f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e2335382-51f0-4234-95e0-3a57ea93ea5f"
        },
        "data": {
          "type": "customers",
          "id": "e2335382-51f0-4234-95e0-3a57ea93ea5f"
        }
      }
    }
  },
  "included": [
    {
      "id": "e2335382-51f0-4234-95e0-3a57ea93ea5f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-13T07:09:45+00:00",
        "updated_at": "2022-04-13T07:09:45+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Smitham-Heathcote",
        "email": "heathcote_smitham@dooley.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=e2335382-51f0-4234-95e0-3a57ea93ea5f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e2335382-51f0-4234-95e0-3a57ea93ea5f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e2335382-51f0-4234-95e0-3a57ea93ea5f&filter[owner_type]=customers"
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
          "owner_id": "9c3d2485-20c2-490c-bc60-a9385d410eb9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e4fbf5c3-413e-4e11-8c47-e00e59ecdeb7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-13T07:09:46+00:00",
      "updated_at": "2022-04-13T07:09:46+00:00",
      "number": "http://bqbl.it/e4fbf5c3-413e-4e11-8c47-e00e59ecdeb7",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9b59a75e53704081f7c2acbb56a76560/barcode/image/e4fbf5c3-413e-4e11-8c47-e00e59ecdeb7/7eb09ce7-db4c-4b5f-9f2e-5d5657523924.svg",
      "owner_id": "9c3d2485-20c2-490c-bc60-a9385d410eb9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d7eb146c-3f8e-4e26-80f4-22eb2e79a5e9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d7eb146c-3f8e-4e26-80f4-22eb2e79a5e9",
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
    "id": "d7eb146c-3f8e-4e26-80f4-22eb2e79a5e9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-04-13T07:09:47+00:00",
      "updated_at": "2022-04-13T07:09:47+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/723587d2002d2f2b395b08360e26442e/barcode/image/d7eb146c-3f8e-4e26-80f4-22eb2e79a5e9/778f6541-b049-4037-b6ca-fc2a7df91a5a.svg",
      "owner_id": "f349ce38-e50b-4074-b194-98d0ada72607",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bc86630b-0416-46e6-9147-7f32083d8e03' \
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