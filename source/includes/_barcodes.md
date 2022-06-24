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
      "id": "c33ce164-7f85-4eb2-b339-17a98f930327",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-24T14:44:58+00:00",
        "updated_at": "2022-06-24T14:44:58+00:00",
        "number": "http://bqbl.it/c33ce164-7f85-4eb2-b339-17a98f930327",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c8543c96b81bbfc7fd0ccb5533f0917a/barcode/image/c33ce164-7f85-4eb2-b339-17a98f930327/9e5f0b02-e912-497e-bdbf-59bd5d6fe1dc.svg",
        "owner_id": "9b233a21-a7a1-42e6-b787-deaa5ff1be4b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9b233a21-a7a1-42e6-b787-deaa5ff1be4b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe3dcaccd-3130-4dde-9121-39712636e194&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e3dcaccd-3130-4dde-9121-39712636e194",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-24T14:44:59+00:00",
        "updated_at": "2022-06-24T14:44:59+00:00",
        "number": "http://bqbl.it/e3dcaccd-3130-4dde-9121-39712636e194",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4312f229f6f83df832b25958a11479e9/barcode/image/e3dcaccd-3130-4dde-9121-39712636e194/6739f806-26bc-46ef-81be-5622f14f4d7e.svg",
        "owner_id": "29dd930f-33d6-498f-9bc3-db786aa644d9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/29dd930f-33d6-498f-9bc3-db786aa644d9"
          },
          "data": {
            "type": "customers",
            "id": "29dd930f-33d6-498f-9bc3-db786aa644d9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "29dd930f-33d6-498f-9bc3-db786aa644d9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-24T14:44:59+00:00",
        "updated_at": "2022-06-24T14:44:59+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Langworth-Ernser",
        "email": "langworth_ernser@farrell.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=29dd930f-33d6-498f-9bc3-db786aa644d9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=29dd930f-33d6-498f-9bc3-db786aa644d9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=29dd930f-33d6-498f-9bc3-db786aa644d9&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDhkNDJiODktNDk5NC00MTdhLTlhYmUtYzI4YTY3MTRhZWJj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "08d42b89-4994-417a-9abe-c28a6714aebc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-24T14:44:59+00:00",
        "updated_at": "2022-06-24T14:44:59+00:00",
        "number": "http://bqbl.it/08d42b89-4994-417a-9abe-c28a6714aebc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9834aa00846eeb802ce7d52c3d64b94f/barcode/image/08d42b89-4994-417a-9abe-c28a6714aebc/8a222172-8af9-4ad5-89ed-0933a02c84ac.svg",
        "owner_id": "733b82d0-fb3a-48a7-8a24-52e2142700ca",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/733b82d0-fb3a-48a7-8a24-52e2142700ca"
          },
          "data": {
            "type": "customers",
            "id": "733b82d0-fb3a-48a7-8a24-52e2142700ca"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "733b82d0-fb3a-48a7-8a24-52e2142700ca",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-24T14:44:59+00:00",
        "updated_at": "2022-06-24T14:44:59+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Will-Osinski",
        "email": "osinski.will@raynor.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=733b82d0-fb3a-48a7-8a24-52e2142700ca&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=733b82d0-fb3a-48a7-8a24-52e2142700ca&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=733b82d0-fb3a-48a7-8a24-52e2142700ca&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-24T14:44:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/51b7ee10-1e3d-4c8e-9a6d-e7d7e6ae376a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "51b7ee10-1e3d-4c8e-9a6d-e7d7e6ae376a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-24T14:45:00+00:00",
      "updated_at": "2022-06-24T14:45:00+00:00",
      "number": "http://bqbl.it/51b7ee10-1e3d-4c8e-9a6d-e7d7e6ae376a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/683e757258ee005a1c7ca3f45bc86a2a/barcode/image/51b7ee10-1e3d-4c8e-9a6d-e7d7e6ae376a/be0c5d0c-c70f-405b-905e-ca1b00f2bf22.svg",
      "owner_id": "6ecafc66-83dc-4179-b9f3-243219ccc0e5",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6ecafc66-83dc-4179-b9f3-243219ccc0e5"
        },
        "data": {
          "type": "customers",
          "id": "6ecafc66-83dc-4179-b9f3-243219ccc0e5"
        }
      }
    }
  },
  "included": [
    {
      "id": "6ecafc66-83dc-4179-b9f3-243219ccc0e5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-24T14:45:00+00:00",
        "updated_at": "2022-06-24T14:45:00+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kuphal LLC",
        "email": "llc.kuphal@schaefer.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=6ecafc66-83dc-4179-b9f3-243219ccc0e5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6ecafc66-83dc-4179-b9f3-243219ccc0e5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6ecafc66-83dc-4179-b9f3-243219ccc0e5&filter[owner_type]=customers"
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
          "owner_id": "ebbf0b63-b4a8-43da-999c-ba3014691ab6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "128b5bac-9282-4599-accc-b88ffb696137",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-24T14:45:00+00:00",
      "updated_at": "2022-06-24T14:45:00+00:00",
      "number": "http://bqbl.it/128b5bac-9282-4599-accc-b88ffb696137",
      "barcode_type": "qr_code",
      "image_url": "/uploads/dc829c164229748cb2bdb6ac56e9fe50/barcode/image/128b5bac-9282-4599-accc-b88ffb696137/00c1a305-1cb1-406e-93be-103a3c12c89a.svg",
      "owner_id": "ebbf0b63-b4a8-43da-999c-ba3014691ab6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6e1b65ad-0e91-4dfd-9947-bdd678fd1016' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6e1b65ad-0e91-4dfd-9947-bdd678fd1016",
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
    "id": "6e1b65ad-0e91-4dfd-9947-bdd678fd1016",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-24T14:45:01+00:00",
      "updated_at": "2022-06-24T14:45:01+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c54bf85e1ae52d77fbdf75e110341862/barcode/image/6e1b65ad-0e91-4dfd-9947-bdd678fd1016/e8493748-e5a1-4740-8107-6d815683b4f6.svg",
      "owner_id": "7034e545-fe2c-4974-94cd-7a134d5b4316",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/14b3895d-b4ba-44ef-8df6-91a3ca1f12cb' \
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