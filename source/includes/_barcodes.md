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
      "id": "41228056-8e38-44d0-8830-6b279ed28bed",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T15:42:11+00:00",
        "updated_at": "2022-10-13T15:42:11+00:00",
        "number": "http://bqbl.it/41228056-8e38-44d0-8830-6b279ed28bed",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9627f0dc3083c3ff78fab14a99b809b5/barcode/image/41228056-8e38-44d0-8830-6b279ed28bed/c577f708-a655-4c7c-8aa6-4d12297c26fc.svg",
        "owner_id": "cd2cbf98-a74a-47b2-ba69-a7df0c7649c8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cd2cbf98-a74a-47b2-ba69-a7df0c7649c8"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb925aff2-eaad-4d57-949b-29ca59434b9b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b925aff2-eaad-4d57-949b-29ca59434b9b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T15:42:11+00:00",
        "updated_at": "2022-10-13T15:42:11+00:00",
        "number": "http://bqbl.it/b925aff2-eaad-4d57-949b-29ca59434b9b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c2b9ea647465a4c592a8b4ad1d1bbb8f/barcode/image/b925aff2-eaad-4d57-949b-29ca59434b9b/ce91b309-ce87-4707-97a5-b09dd5b59cc4.svg",
        "owner_id": "f91f059b-165a-4e3a-8904-a461bd7230c5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f91f059b-165a-4e3a-8904-a461bd7230c5"
          },
          "data": {
            "type": "customers",
            "id": "f91f059b-165a-4e3a-8904-a461bd7230c5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f91f059b-165a-4e3a-8904-a461bd7230c5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T15:42:11+00:00",
        "updated_at": "2022-10-13T15:42:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=f91f059b-165a-4e3a-8904-a461bd7230c5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f91f059b-165a-4e3a-8904-a461bd7230c5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f91f059b-165a-4e3a-8904-a461bd7230c5&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYmMxZTc1MTktZGNiNy00Y2FjLThjMDAtNjRhY2IyMzNhNTQ0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bc1e7519-dcb7-4cac-8c00-64acb233a544",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-13T15:42:12+00:00",
        "updated_at": "2022-10-13T15:42:12+00:00",
        "number": "http://bqbl.it/bc1e7519-dcb7-4cac-8c00-64acb233a544",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ceed2750bccdc7dadf82032f5570a606/barcode/image/bc1e7519-dcb7-4cac-8c00-64acb233a544/e19bd041-e0b9-49d6-b6a4-63e8c6385f92.svg",
        "owner_id": "57a3e30f-af0e-416d-a1c4-b29083ac013c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/57a3e30f-af0e-416d-a1c4-b29083ac013c"
          },
          "data": {
            "type": "customers",
            "id": "57a3e30f-af0e-416d-a1c4-b29083ac013c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "57a3e30f-af0e-416d-a1c4-b29083ac013c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T15:42:12+00:00",
        "updated_at": "2022-10-13T15:42:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=57a3e30f-af0e-416d-a1c4-b29083ac013c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=57a3e30f-af0e-416d-a1c4-b29083ac013c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=57a3e30f-af0e-416d-a1c4-b29083ac013c&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T15:41:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f98ce4c4-a17c-4a45-9bcd-e773b4309a1f?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f98ce4c4-a17c-4a45-9bcd-e773b4309a1f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T15:42:12+00:00",
      "updated_at": "2022-10-13T15:42:12+00:00",
      "number": "http://bqbl.it/f98ce4c4-a17c-4a45-9bcd-e773b4309a1f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/fe39c889d06c656eb7c1d9087d09dd35/barcode/image/f98ce4c4-a17c-4a45-9bcd-e773b4309a1f/b6f2c268-6e2c-4f3a-be10-fe2a401242ec.svg",
      "owner_id": "c35f1b11-40ec-4bcd-b1bb-b8c8d0b2cea2",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c35f1b11-40ec-4bcd-b1bb-b8c8d0b2cea2"
        },
        "data": {
          "type": "customers",
          "id": "c35f1b11-40ec-4bcd-b1bb-b8c8d0b2cea2"
        }
      }
    }
  },
  "included": [
    {
      "id": "c35f1b11-40ec-4bcd-b1bb-b8c8d0b2cea2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-13T15:42:12+00:00",
        "updated_at": "2022-10-13T15:42:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c35f1b11-40ec-4bcd-b1bb-b8c8d0b2cea2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c35f1b11-40ec-4bcd-b1bb-b8c8d0b2cea2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c35f1b11-40ec-4bcd-b1bb-b8c8d0b2cea2&filter[owner_type]=customers"
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
          "owner_id": "21bf295f-afbe-4e87-be3d-61d7155c0f16",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4a92fa49-e79a-4bb0-9d26-aa82ad135137",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T15:42:13+00:00",
      "updated_at": "2022-10-13T15:42:13+00:00",
      "number": "http://bqbl.it/4a92fa49-e79a-4bb0-9d26-aa82ad135137",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1ea3dfeb3af5ff411124260d1a2da502/barcode/image/4a92fa49-e79a-4bb0-9d26-aa82ad135137/85e911f3-ae06-4359-b8bb-68ee3543e70b.svg",
      "owner_id": "21bf295f-afbe-4e87-be3d-61d7155c0f16",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9b1bc446-3141-43ef-8312-563eb2bac68b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9b1bc446-3141-43ef-8312-563eb2bac68b",
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
    "id": "9b1bc446-3141-43ef-8312-563eb2bac68b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-13T15:42:13+00:00",
      "updated_at": "2022-10-13T15:42:13+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8ffd6907195c17cfdf9b058dbd3e07a3/barcode/image/9b1bc446-3141-43ef-8312-563eb2bac68b/d5b37a94-f7cd-4c3f-a14a-77c488813e83.svg",
      "owner_id": "e12fd8e8-bc4e-483b-b640-e3a53e769ed9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5b925e67-0c52-47d6-962f-ef82ab1633ff' \
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