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
`owner` | **Customer**<br>Associated Owner


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
      "id": "252917ad-c83b-41c6-a17e-70567f1a15fa",
      "type": "barcodes",
      "attributes": {
        "number": "http://bqbl.it/252917ad-c83b-41c6-a17e-70567f1a15fa",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d10fd2104c0e31a33cf18054c434c456/barcode/image/252917ad-c83b-41c6-a17e-70567f1a15fa/078d597f-10cf-4121-a043-603eb8b73f57.svg",
        "owner_id": "84f849c2-cfe7-465c-b983-c112117fb384",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/84f849c2-cfe7-465c-b983-c112117fb384"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffab8170a-5ec0-4b99-af96-0f2df4e6ab67&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fab8170a-5ec0-4b99-af96-0f2df4e6ab67",
      "type": "barcodes",
      "attributes": {
        "number": "http://bqbl.it/fab8170a-5ec0-4b99-af96-0f2df4e6ab67",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4bb54441a899c78f951b991ef32bcd2e/barcode/image/fab8170a-5ec0-4b99-af96-0f2df4e6ab67/f13f6fa0-8cc6-4302-9338-2a93fd443c21.svg",
        "owner_id": "e29e0153-9ac2-47b1-a58b-ae56c8e5acd7",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e29e0153-9ac2-47b1-a58b-ae56c8e5acd7"
          },
          "data": {
            "type": "customers",
            "id": "e29e0153-9ac2-47b1-a58b-ae56c8e5acd7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e29e0153-9ac2-47b1-a58b-ae56c8e5acd7",
      "type": "customers",
      "attributes": {
        "number": 1,
        "name": "Walsh-Thiel",
        "email": "thiel.walsh@ryan.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=e29e0153-9ac2-47b1-a58b-ae56c8e5acd7&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e29e0153-9ac2-47b1-a58b-ae56c8e5acd7"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=e29e0153-9ac2-47b1-a58b-ae56c8e5acd7&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffab8170a-5ec0-4b99-af96-0f2df4e6ab67&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffab8170a-5ec0-4b99-af96-0f2df4e6ab67&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffab8170a-5ec0-4b99-af96-0f2df4e6ab67&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-25T12:33:46Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


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
    --url 'https://example.booqable.com/api/boomerang/barcodes/92d765ce-dd7e-49f5-b396-175877928c9c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "92d765ce-dd7e-49f5-b396-175877928c9c",
    "type": "barcodes",
    "attributes": {
      "number": "http://bqbl.it/92d765ce-dd7e-49f5-b396-175877928c9c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cc4b2bbba30dfa7eed816f3cdd6ccd46/barcode/image/92d765ce-dd7e-49f5-b396-175877928c9c/96431084-88d4-44b2-9bd2-4b3d8b68efab.svg",
      "owner_id": "20eb0814-f789-483b-b7b9-f61e47d6ef42",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/20eb0814-f789-483b-b7b9-f61e47d6ef42"
        },
        "data": {
          "type": "customers",
          "id": "20eb0814-f789-483b-b7b9-f61e47d6ef42"
        }
      }
    }
  },
  "included": [
    {
      "id": "20eb0814-f789-483b-b7b9-f61e47d6ef42",
      "type": "customers",
      "attributes": {
        "number": 1,
        "name": "Lemke-Wyman",
        "email": "wyman.lemke@corkery.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=20eb0814-f789-483b-b7b9-f61e47d6ef42&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=20eb0814-f789-483b-b7b9-f61e47d6ef42"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=20eb0814-f789-483b-b7b9-f61e47d6ef42&filter[notable_type]=Customer"
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
          "owner_id": "4878bf9c-b90d-4b48-b824-37de401a166c",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "403af4c0-e551-48ae-89ab-8cfb5f519c11",
    "type": "barcodes",
    "attributes": {
      "number": "http://bqbl.it/403af4c0-e551-48ae-89ab-8cfb5f519c11",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f3836abb940e081d67df213f419d1c42/barcode/image/403af4c0-e551-48ae-89ab-8cfb5f519c11/74e95d63-20da-47fb-a296-658064fdd266.svg",
      "owner_id": "4878bf9c-b90d-4b48-b824-37de401a166c",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=4878bf9c-b90d-4b48-b824-37de401a166c&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=4878bf9c-b90d-4b48-b824-37de401a166c&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=4878bf9c-b90d-4b48-b824-37de401a166c&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c3175871-b8b7-4492-8644-c8ba09414c3b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c3175871-b8b7-4492-8644-c8ba09414c3b",
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
    "id": "c3175871-b8b7-4492-8644-c8ba09414c3b",
    "type": "barcodes",
    "attributes": {
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0c204460b69952539930e0a679e6156c/barcode/image/c3175871-b8b7-4492-8644-c8ba09414c3b/0a37f61d-373b-4cb3-a3c0-9fdfbfbc3f5e.svg",
      "owner_id": "4d1acdf7-cbf9-4802-86b3-546c15823a0a",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0d79fc80-8ce4-4bf8-93d6-f7b55bacf034' \
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