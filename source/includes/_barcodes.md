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
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `Product`, `Customer`, `StockItem`


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
      "id": "2b71c4a7-70f0-4773-9956-c3c8c3455422",
      "type": "barcodes",
      "attributes": {
        "number": "http://bqbl.it/2b71c4a7-70f0-4773-9956-c3c8c3455422",
        "barcode_type": "qr_code",
        "image_url": "/uploads/65827a994163f5992393e3ac55522d47/barcode/image/2b71c4a7-70f0-4773-9956-c3c8c3455422/15df7d19-a544-40f5-9dd4-6cffdaa06410.svg",
        "owner_id": "a8bb85be-c066-4bc5-b135-41aee8c997c1",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a8bb85be-c066-4bc5-b135-41aee8c997c1"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa4babdf1-6707-441d-aacd-cf54f0f68d70&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a4babdf1-6707-441d-aacd-cf54f0f68d70",
      "type": "barcodes",
      "attributes": {
        "number": "http://bqbl.it/a4babdf1-6707-441d-aacd-cf54f0f68d70",
        "barcode_type": "qr_code",
        "image_url": "/uploads/efd5b5d5e7ef7fb7263324cc24d5909f/barcode/image/a4babdf1-6707-441d-aacd-cf54f0f68d70/5815f35d-188c-462e-b9f5-97275597f018.svg",
        "owner_id": "1140897b-712d-4670-bb34-999a7c1cc733",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1140897b-712d-4670-bb34-999a7c1cc733"
          },
          "data": {
            "type": "customers",
            "id": "1140897b-712d-4670-bb34-999a7c1cc733"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1140897b-712d-4670-bb34-999a7c1cc733",
      "type": "customers",
      "attributes": {
        "number": 1,
        "name": "Schimmel, Bergnaum and Kautzer",
        "email": "kautzer.bergnaum.and.schimmel@rodriguez.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=1140897b-712d-4670-bb34-999a7c1cc733&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1140897b-712d-4670-bb34-999a7c1cc733"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=1140897b-712d-4670-bb34-999a7c1cc733&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa4babdf1-6707-441d-aacd-cf54f0f68d70&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa4babdf1-6707-441d-aacd-cf54f0f68d70&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa4babdf1-6707-441d-aacd-cf54f0f68d70&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-08T09:21:28Z`
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
`owner_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fadf8197-e518-46f5-b124-43423935af98?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fadf8197-e518-46f5-b124-43423935af98",
    "type": "barcodes",
    "attributes": {
      "number": "http://bqbl.it/fadf8197-e518-46f5-b124-43423935af98",
      "barcode_type": "qr_code",
      "image_url": "/uploads/373e48d8fbd5f56f1cd1c9f54bd4e768/barcode/image/fadf8197-e518-46f5-b124-43423935af98/cb4aa911-3101-46cc-8d20-bb0b08d0125b.svg",
      "owner_id": "44492eb2-0eda-448e-b247-af6e0db46acd",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/44492eb2-0eda-448e-b247-af6e0db46acd"
        },
        "data": {
          "type": "customers",
          "id": "44492eb2-0eda-448e-b247-af6e0db46acd"
        }
      }
    }
  },
  "included": [
    {
      "id": "44492eb2-0eda-448e-b247-af6e0db46acd",
      "type": "customers",
      "attributes": {
        "number": 1,
        "name": "Bins, Tromp and McCullough",
        "email": "and_bins_tromp_mccullough@quitzon.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=44492eb2-0eda-448e-b247-af6e0db46acd&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=44492eb2-0eda-448e-b247-af6e0db46acd"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=44492eb2-0eda-448e-b247-af6e0db46acd&filter[notable_type]=Customer"
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
          "owner_id": "f7b08ee2-10e7-4439-b144-e74dac214c23",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "09833998-75f6-4121-adf8-787958647581",
    "type": "barcodes",
    "attributes": {
      "number": "http://bqbl.it/09833998-75f6-4121-adf8-787958647581",
      "barcode_type": "qr_code",
      "image_url": "/uploads/18589f13e3447bdb6f715ffba56538f1/barcode/image/09833998-75f6-4121-adf8-787958647581/489d4342-5f17-4c27-9fce-365ba526d597.svg",
      "owner_id": "f7b08ee2-10e7-4439-b144-e74dac214c23",
      "owner_type": "Customer"
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=f7b08ee2-10e7-4439-b144-e74dac214c23&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=f7b08ee2-10e7-4439-b144-e74dac214c23&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=f7b08ee2-10e7-4439-b144-e74dac214c23&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Product`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/ca2556e3-b3d0-464f-8d1d-77dbaa26a59e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ca2556e3-b3d0-464f-8d1d-77dbaa26a59e",
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
    "id": "ca2556e3-b3d0-464f-8d1d-77dbaa26a59e",
    "type": "barcodes",
    "attributes": {
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4deb53ec9fda57cf3049bf2e79f8ebcf/barcode/image/ca2556e3-b3d0-464f-8d1d-77dbaa26a59e/c20cf8da-0502-4f92-86d7-2fe6cf982ae0.svg",
      "owner_id": "11484979-3a09-43da-8892-1c30e68bb5fa",
      "owner_type": "Customer"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Product`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/97be3b42-947f-4141-8561-cc9e6575f924' \
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