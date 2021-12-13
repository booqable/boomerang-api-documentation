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
      "id": "091904f1-408c-44f8-b6d1-84010a535f09",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-13T08:13:34+00:00",
        "updated_at": "2021-12-13T08:13:34+00:00",
        "number": "http://bqbl.it/091904f1-408c-44f8-b6d1-84010a535f09",
        "barcode_type": "qr_code",
        "image_url": "/uploads/210e0170dbd5962c8938296841ba9cd9/barcode/image/091904f1-408c-44f8-b6d1-84010a535f09/44fa0182-7103-49a9-86a6-baef7cef33f8.svg",
        "owner_id": "4dc3328d-86f2-4b3f-baf8-2fea3a64229e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4dc3328d-86f2-4b3f-baf8-2fea3a64229e"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4e32682d-7771-4ce9-886c-6bd864b3f6dd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4e32682d-7771-4ce9-886c-6bd864b3f6dd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-13T08:13:35+00:00",
        "updated_at": "2021-12-13T08:13:35+00:00",
        "number": "http://bqbl.it/4e32682d-7771-4ce9-886c-6bd864b3f6dd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d9c27b0c5dd5456afe1a6f504d7b2e07/barcode/image/4e32682d-7771-4ce9-886c-6bd864b3f6dd/fa78b72b-2853-4775-a134-ae3a008ad668.svg",
        "owner_id": "d50c3471-e727-41c4-a5eb-c8ef519d57ed",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d50c3471-e727-41c4-a5eb-c8ef519d57ed"
          },
          "data": {
            "type": "customers",
            "id": "d50c3471-e727-41c4-a5eb-c8ef519d57ed"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d50c3471-e727-41c4-a5eb-c8ef519d57ed",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-13T08:13:35+00:00",
        "updated_at": "2021-12-13T08:13:35+00:00",
        "number": 1,
        "name": "Strosin-Zemlak",
        "email": "strosin.zemlak@conn.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=d50c3471-e727-41c4-a5eb-c8ef519d57ed&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d50c3471-e727-41c4-a5eb-c8ef519d57ed&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d50c3471-e727-41c4-a5eb-c8ef519d57ed&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4e32682d-7771-4ce9-886c-6bd864b3f6dd&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4e32682d-7771-4ce9-886c-6bd864b3f6dd&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4e32682d-7771-4ce9-886c-6bd864b3f6dd&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-13T08:13:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/922f7616-9cb9-4964-ad50-78013f312a9d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "922f7616-9cb9-4964-ad50-78013f312a9d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-13T08:13:36+00:00",
      "updated_at": "2021-12-13T08:13:36+00:00",
      "number": "http://bqbl.it/922f7616-9cb9-4964-ad50-78013f312a9d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9fc73cd95b236fe06ebd34b456ecb09c/barcode/image/922f7616-9cb9-4964-ad50-78013f312a9d/92e0f06a-1bbd-45e9-aec3-2be706a322d3.svg",
      "owner_id": "c673636a-1df9-4f70-a3b1-2981c21483f9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c673636a-1df9-4f70-a3b1-2981c21483f9"
        },
        "data": {
          "type": "customers",
          "id": "c673636a-1df9-4f70-a3b1-2981c21483f9"
        }
      }
    }
  },
  "included": [
    {
      "id": "c673636a-1df9-4f70-a3b1-2981c21483f9",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-13T08:13:36+00:00",
        "updated_at": "2021-12-13T08:13:36+00:00",
        "number": 1,
        "name": "Lockman, Metz and O'Connell",
        "email": "and.o.connell.lockman.metz@buckridge.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=c673636a-1df9-4f70-a3b1-2981c21483f9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c673636a-1df9-4f70-a3b1-2981c21483f9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c673636a-1df9-4f70-a3b1-2981c21483f9&filter[owner_type]=customers"
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
          "owner_id": "08342511-f861-41ba-a40d-a4f2d3a72322",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "49d20eac-7412-4ee7-9119-7f3831ff647b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-13T08:13:37+00:00",
      "updated_at": "2021-12-13T08:13:37+00:00",
      "number": "http://bqbl.it/49d20eac-7412-4ee7-9119-7f3831ff647b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/00c49a6eecb33f7ff307d8fecb6bcd19/barcode/image/49d20eac-7412-4ee7-9119-7f3831ff647b/b4281d10-3ae7-4210-bcfc-e817ee99a1be.svg",
      "owner_id": "08342511-f861-41ba-a40d-a4f2d3a72322",
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
  "links": {
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=08342511-f861-41ba-a40d-a4f2d3a72322&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=08342511-f861-41ba-a40d-a4f2d3a72322&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=08342511-f861-41ba-a40d-a4f2d3a72322&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/52fc1f77-0141-45ce-9832-b136a7b9e9e5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "52fc1f77-0141-45ce-9832-b136a7b9e9e5",
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
    "id": "52fc1f77-0141-45ce-9832-b136a7b9e9e5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-13T08:13:37+00:00",
      "updated_at": "2021-12-13T08:13:37+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a053fa2802ac0bcd5678676d2b9e0028/barcode/image/52fc1f77-0141-45ce-9832-b136a7b9e9e5/36406aec-6a8f-490d-acc4-281bc966d8f2.svg",
      "owner_id": "f3600804-9072-4925-aa84-e281982c5722",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9d529a00-076a-4f69-9bb0-ef406160ebf8' \
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