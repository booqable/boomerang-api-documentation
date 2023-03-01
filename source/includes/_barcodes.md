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
`number` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


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
      "id": "6d4fb94b-8941-4bc2-8461-3e99e122a6a2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T14:48:09+00:00",
        "updated_at": "2023-03-01T14:48:09+00:00",
        "number": "http://bqbl.it/6d4fb94b-8941-4bc2-8461-3e99e122a6a2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/152a9ff99611d48449a3eeae798642c3/barcode/image/6d4fb94b-8941-4bc2-8461-3e99e122a6a2/bde47158-a426-4386-b69b-647098402c63.svg",
        "owner_id": "45cc0906-da21-45c8-ba77-217e2fc2ce4c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/45cc0906-da21-45c8-ba77-217e2fc2ce4c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fdfe5dfd2-eba8-4e7f-af77-40d5341d378d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dfe5dfd2-eba8-4e7f-af77-40d5341d378d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T14:48:10+00:00",
        "updated_at": "2023-03-01T14:48:10+00:00",
        "number": "http://bqbl.it/dfe5dfd2-eba8-4e7f-af77-40d5341d378d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/36c28aa260882b278aa43419d3e059a0/barcode/image/dfe5dfd2-eba8-4e7f-af77-40d5341d378d/d722761b-2073-439f-ae32-18d136f46d9f.svg",
        "owner_id": "6caa95fb-a354-4f84-88df-56097630e09f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6caa95fb-a354-4f84-88df-56097630e09f"
          },
          "data": {
            "type": "customers",
            "id": "6caa95fb-a354-4f84-88df-56097630e09f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6caa95fb-a354-4f84-88df-56097630e09f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T14:48:10+00:00",
        "updated_at": "2023-03-01T14:48:10+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-2@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=6caa95fb-a354-4f84-88df-56097630e09f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6caa95fb-a354-4f84-88df-56097630e09f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6caa95fb-a354-4f84-88df-56097630e09f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNGY2NDdjMmQtOGEyNS00YTM2LWIxODItZWM5OTUxZDM5YjE3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4f647c2d-8a25-4a36-b182-ec9951d39b17",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T14:48:10+00:00",
        "updated_at": "2023-03-01T14:48:10+00:00",
        "number": "http://bqbl.it/4f647c2d-8a25-4a36-b182-ec9951d39b17",
        "barcode_type": "qr_code",
        "image_url": "/uploads/896f38834214e8e2c32f861ba7001349/barcode/image/4f647c2d-8a25-4a36-b182-ec9951d39b17/867a1b30-c3c1-48d5-9b95-0316292cf0c8.svg",
        "owner_id": "b765ee2a-8a18-429a-86ff-ee9358455afc",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b765ee2a-8a18-429a-86ff-ee9358455afc"
          },
          "data": {
            "type": "customers",
            "id": "b765ee2a-8a18-429a-86ff-ee9358455afc"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b765ee2a-8a18-429a-86ff-ee9358455afc",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T14:48:10+00:00",
        "updated_at": "2023-03-01T14:48:10+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-4@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=b765ee2a-8a18-429a-86ff-ee9358455afc&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b765ee2a-8a18-429a-86ff-ee9358455afc&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b765ee2a-8a18-429a-86ff-ee9358455afc&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:47:52Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String** <br>`eq`
`barcode_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/4853528c-10a4-4b2e-90b2-fb69f30d7457?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4853528c-10a4-4b2e-90b2-fb69f30d7457",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T14:48:11+00:00",
      "updated_at": "2023-03-01T14:48:11+00:00",
      "number": "http://bqbl.it/4853528c-10a4-4b2e-90b2-fb69f30d7457",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ce4108f22917cd58e4de4fe9b167f9b9/barcode/image/4853528c-10a4-4b2e-90b2-fb69f30d7457/ae0d65bc-2ccb-4896-bc22-d850089f612b.svg",
      "owner_id": "4263987d-7a9e-45c9-af10-035e616bf0b2",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/4263987d-7a9e-45c9-af10-035e616bf0b2"
        },
        "data": {
          "type": "customers",
          "id": "4263987d-7a9e-45c9-af10-035e616bf0b2"
        }
      }
    }
  },
  "included": [
    {
      "id": "4263987d-7a9e-45c9-af10-035e616bf0b2",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T14:48:11+00:00",
        "updated_at": "2023-03-01T14:48:11+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-5@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=4263987d-7a9e-45c9-af10-035e616bf0b2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4263987d-7a9e-45c9-af10-035e616bf0b2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4263987d-7a9e-45c9-af10-035e616bf0b2&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "0e93dfae-4ca6-4ac8-a4ce-a4c6688a36f9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "35b91f19-8dff-47c3-b37d-1d4119488d4c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T14:48:11+00:00",
      "updated_at": "2023-03-01T14:48:11+00:00",
      "number": "http://bqbl.it/35b91f19-8dff-47c3-b37d-1d4119488d4c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b2c58fcb809cb7f85f2d7d619743d0f5/barcode/image/35b91f19-8dff-47c3-b37d-1d4119488d4c/57deba93-9edf-45ae-abc4-b870c88c7d95.svg",
      "owner_id": "0e93dfae-4ca6-4ac8-a4ce-a4c6688a36f9",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/a9de9598-1651-4846-98bb-49d19471c050' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a9de9598-1651-4846-98bb-49d19471c050",
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
    "id": "a9de9598-1651-4846-98bb-49d19471c050",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T14:48:12+00:00",
      "updated_at": "2023-03-01T14:48:12+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bf2b53806f96d6b0602f1de857fc80cd/barcode/image/a9de9598-1651-4846-98bb-49d19471c050/3c289020-ebcf-4ff4-9f52-087e4110802e.svg",
      "owner_id": "d8c7e8aa-7b06-458c-9a0e-dd0d1b36c14d",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e608f4b2-7242-49af-890d-7d70c2af9d69' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes