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
      "id": "ae409ac4-82d6-4dd9-b85a-55d8d64ad277",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-12T10:54:58+00:00",
        "updated_at": "2022-01-12T10:54:58+00:00",
        "number": "http://bqbl.it/ae409ac4-82d6-4dd9-b85a-55d8d64ad277",
        "barcode_type": "qr_code",
        "image_url": "/uploads/226f45c7259859bdf67eb754cb39db68/barcode/image/ae409ac4-82d6-4dd9-b85a-55d8d64ad277/cfe2c768-2719-4b3d-b422-55b113f258b3.svg",
        "owner_id": "dc7f2ed9-4163-4ad2-8dbd-4896041fee42",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dc7f2ed9-4163-4ad2-8dbd-4896041fee42"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5a401e09-3a30-417e-a80d-6f47d0d4ff41&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5a401e09-3a30-417e-a80d-6f47d0d4ff41",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-12T10:54:59+00:00",
        "updated_at": "2022-01-12T10:54:59+00:00",
        "number": "http://bqbl.it/5a401e09-3a30-417e-a80d-6f47d0d4ff41",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b807d38ff8c092a451f01c762a8d9225/barcode/image/5a401e09-3a30-417e-a80d-6f47d0d4ff41/43e7a189-6c36-4c6f-998c-2ace3d472a2c.svg",
        "owner_id": "f72722e4-e805-4bc9-b3db-9f3022ddd9b2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f72722e4-e805-4bc9-b3db-9f3022ddd9b2"
          },
          "data": {
            "type": "customers",
            "id": "f72722e4-e805-4bc9-b3db-9f3022ddd9b2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f72722e4-e805-4bc9-b3db-9f3022ddd9b2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-12T10:54:59+00:00",
        "updated_at": "2022-01-12T10:54:59+00:00",
        "number": 1,
        "name": "Ferry, Schumm and Price",
        "email": "ferry.and.price.schumm@lakin.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=f72722e4-e805-4bc9-b3db-9f3022ddd9b2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f72722e4-e805-4bc9-b3db-9f3022ddd9b2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f72722e4-e805-4bc9-b3db-9f3022ddd9b2&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5a401e09-3a30-417e-a80d-6f47d0d4ff41&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5a401e09-3a30-417e-a80d-6f47d0d4ff41&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5a401e09-3a30-417e-a80d-6f47d0d4ff41&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-12T10:54:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ade2ece8-8a16-4698-9249-bd3aeeabb605?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ade2ece8-8a16-4698-9249-bd3aeeabb605",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-12T10:54:59+00:00",
      "updated_at": "2022-01-12T10:54:59+00:00",
      "number": "http://bqbl.it/ade2ece8-8a16-4698-9249-bd3aeeabb605",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ab2d400508dafdd6291793613370f725/barcode/image/ade2ece8-8a16-4698-9249-bd3aeeabb605/53bf89a3-fcc8-4271-90aa-c62f517ac400.svg",
      "owner_id": "3812d4c9-5bbe-44ab-b33d-0eaa8fb100de",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3812d4c9-5bbe-44ab-b33d-0eaa8fb100de"
        },
        "data": {
          "type": "customers",
          "id": "3812d4c9-5bbe-44ab-b33d-0eaa8fb100de"
        }
      }
    }
  },
  "included": [
    {
      "id": "3812d4c9-5bbe-44ab-b33d-0eaa8fb100de",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-12T10:54:59+00:00",
        "updated_at": "2022-01-12T10:54:59+00:00",
        "number": 1,
        "name": "Durgan Group",
        "email": "group.durgan@swift-mraz.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=3812d4c9-5bbe-44ab-b33d-0eaa8fb100de&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3812d4c9-5bbe-44ab-b33d-0eaa8fb100de&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3812d4c9-5bbe-44ab-b33d-0eaa8fb100de&filter[owner_type]=customers"
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
          "owner_id": "251045fa-e3dd-4ee5-bbb1-d63ca12008f4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6b4088a8-af4b-46c7-91db-ed71a96bb6c9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-12T10:55:00+00:00",
      "updated_at": "2022-01-12T10:55:00+00:00",
      "number": "http://bqbl.it/6b4088a8-af4b-46c7-91db-ed71a96bb6c9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/52e1642784dce271b2fc1f1b21ad9f3f/barcode/image/6b4088a8-af4b-46c7-91db-ed71a96bb6c9/9f294715-e69d-4fb0-bddc-03f1e64d30d9.svg",
      "owner_id": "251045fa-e3dd-4ee5-bbb1-d63ca12008f4",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=251045fa-e3dd-4ee5-bbb1-d63ca12008f4&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=251045fa-e3dd-4ee5-bbb1-d63ca12008f4&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=251045fa-e3dd-4ee5-bbb1-d63ca12008f4&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5134c2ec-5f06-43a9-b3bc-38824582cf48' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5134c2ec-5f06-43a9-b3bc-38824582cf48",
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
    "id": "5134c2ec-5f06-43a9-b3bc-38824582cf48",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-12T10:55:00+00:00",
      "updated_at": "2022-01-12T10:55:00+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/311ae7ec7919eea7b34e5aef424613c5/barcode/image/5134c2ec-5f06-43a9-b3bc-38824582cf48/7ea9b350-cb29-4872-a2c6-d1827611cbeb.svg",
      "owner_id": "8cc5195b-c594-4473-a8dc-2396103fe027",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/490653f5-22de-47fe-87fe-45a5c79a9686' \
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