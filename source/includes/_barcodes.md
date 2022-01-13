# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
      "id": "78e30b56-334a-419f-8d30-ab2262623ad0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-13T13:08:36+00:00",
        "updated_at": "2022-01-13T13:08:36+00:00",
        "number": "http://bqbl.it/78e30b56-334a-419f-8d30-ab2262623ad0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a86c973df345229150a46a9f30d51408/barcode/image/78e30b56-334a-419f-8d30-ab2262623ad0/e2b0b897-8fde-4883-8a63-c689f4fba7a0.svg",
        "owner_id": "f60fd931-5888-4658-9fe0-819ad635cf62",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f60fd931-5888-4658-9fe0-819ad635cf62"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7663d011-e32f-4285-b543-20339a8de6c5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7663d011-e32f-4285-b543-20339a8de6c5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-13T13:08:37+00:00",
        "updated_at": "2022-01-13T13:08:37+00:00",
        "number": "http://bqbl.it/7663d011-e32f-4285-b543-20339a8de6c5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b9d702e31c37c334259176f259293af3/barcode/image/7663d011-e32f-4285-b543-20339a8de6c5/29b2c208-892e-4071-a313-24dcd075569f.svg",
        "owner_id": "8a2f3a49-b86d-458a-b25f-9a4098061c9c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8a2f3a49-b86d-458a-b25f-9a4098061c9c"
          },
          "data": {
            "type": "customers",
            "id": "8a2f3a49-b86d-458a-b25f-9a4098061c9c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8a2f3a49-b86d-458a-b25f-9a4098061c9c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-13T13:08:37+00:00",
        "updated_at": "2022-01-13T13:08:37+00:00",
        "number": 1,
        "name": "Lind, Nitzsche and Luettgen",
        "email": "nitzsche_luettgen_lind_and@tillman.net",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=8a2f3a49-b86d-458a-b25f-9a4098061c9c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8a2f3a49-b86d-458a-b25f-9a4098061c9c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8a2f3a49-b86d-458a-b25f-9a4098061c9c&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-13T13:08:20Z`
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
`number` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/53675deb-0b90-4321-ba66-0f3793645d45?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "53675deb-0b90-4321-ba66-0f3793645d45",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-13T13:08:38+00:00",
      "updated_at": "2022-01-13T13:08:38+00:00",
      "number": "http://bqbl.it/53675deb-0b90-4321-ba66-0f3793645d45",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6b077904d23be689c066c547a2fc1873/barcode/image/53675deb-0b90-4321-ba66-0f3793645d45/01034959-0ff3-4401-b262-3fa06e8217ef.svg",
      "owner_id": "f95fcc03-128b-4b01-856f-96f8dcd87dbf",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f95fcc03-128b-4b01-856f-96f8dcd87dbf"
        },
        "data": {
          "type": "customers",
          "id": "f95fcc03-128b-4b01-856f-96f8dcd87dbf"
        }
      }
    }
  },
  "included": [
    {
      "id": "f95fcc03-128b-4b01-856f-96f8dcd87dbf",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-13T13:08:38+00:00",
        "updated_at": "2022-01-13T13:08:38+00:00",
        "number": 1,
        "name": "Rohan Group",
        "email": "rohan.group@quitzon-von.co",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=f95fcc03-128b-4b01-856f-96f8dcd87dbf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f95fcc03-128b-4b01-856f-96f8dcd87dbf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f95fcc03-128b-4b01-856f-96f8dcd87dbf&filter[owner_type]=customers"
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
          "owner_id": "ec69daab-93dd-4875-8bfc-5437ab6636b6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "00fcdbe2-13c8-4900-9bd7-68b6040ce22d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-13T13:08:39+00:00",
      "updated_at": "2022-01-13T13:08:39+00:00",
      "number": "http://bqbl.it/00fcdbe2-13c8-4900-9bd7-68b6040ce22d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/459c6e5b7b65be243461d1aade38d598/barcode/image/00fcdbe2-13c8-4900-9bd7-68b6040ce22d/08f2ad97-913a-4885-80a5-41bd29239a57.svg",
      "owner_id": "ec69daab-93dd-4875-8bfc-5437ab6636b6",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b49b9c5d-fddd-4e8e-be2a-b8b4f01ff6d9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b49b9c5d-fddd-4e8e-be2a-b8b4f01ff6d9",
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
    "id": "b49b9c5d-fddd-4e8e-be2a-b8b4f01ff6d9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-13T13:08:40+00:00",
      "updated_at": "2022-01-13T13:08:40+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8cef4b847bc90d051773a14eb10902d5/barcode/image/b49b9c5d-fddd-4e8e-be2a-b8b4f01ff6d9/b14f0f7a-bef8-4acd-8675-de3a829d9103.svg",
      "owner_id": "50844c0b-1d6f-42a8-8f34-b6675391d8b3",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d47e45a8-6956-4f8f-8745-4e4a6b1b12cb' \
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