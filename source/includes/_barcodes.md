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
      "id": "cf5876d4-e664-4fe3-9560-941173c8b6d5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-18T14:41:38+00:00",
        "updated_at": "2021-11-18T14:41:38+00:00",
        "number": "http://bqbl.it/cf5876d4-e664-4fe3-9560-941173c8b6d5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1e92117e3116d4c7f8fdf15011f330ee/barcode/image/cf5876d4-e664-4fe3-9560-941173c8b6d5/1840b260-3eb3-4541-ae24-3f7202060bb3.svg",
        "owner_id": "83610774-642f-4584-92d3-e0047d016292",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/83610774-642f-4584-92d3-e0047d016292"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9e92a06c-d037-4157-9542-475b07224ff1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9e92a06c-d037-4157-9542-475b07224ff1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-18T14:41:39+00:00",
        "updated_at": "2021-11-18T14:41:39+00:00",
        "number": "http://bqbl.it/9e92a06c-d037-4157-9542-475b07224ff1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/67cc21061429b0f7a2de356e744f6884/barcode/image/9e92a06c-d037-4157-9542-475b07224ff1/3be16a0b-367c-4567-9fb7-289b7e1c6c77.svg",
        "owner_id": "e255a96e-228b-44f8-8fbd-20eecb56d7c0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e255a96e-228b-44f8-8fbd-20eecb56d7c0"
          },
          "data": {
            "type": "customers",
            "id": "e255a96e-228b-44f8-8fbd-20eecb56d7c0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e255a96e-228b-44f8-8fbd-20eecb56d7c0",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-18T14:41:39+00:00",
        "updated_at": "2021-11-18T14:41:39+00:00",
        "number": 1,
        "name": "Rogahn, Kunze and Pouros",
        "email": "pouros_kunze_rogahn_and@haag-rohan.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=e255a96e-228b-44f8-8fbd-20eecb56d7c0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e255a96e-228b-44f8-8fbd-20eecb56d7c0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e255a96e-228b-44f8-8fbd-20eecb56d7c0&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9e92a06c-d037-4157-9542-475b07224ff1&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9e92a06c-d037-4157-9542-475b07224ff1&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9e92a06c-d037-4157-9542-475b07224ff1&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-18T14:41:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5989c9b0-cc22-4434-9310-4ec2e8487299?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5989c9b0-cc22-4434-9310-4ec2e8487299",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-18T14:41:39+00:00",
      "updated_at": "2021-11-18T14:41:39+00:00",
      "number": "http://bqbl.it/5989c9b0-cc22-4434-9310-4ec2e8487299",
      "barcode_type": "qr_code",
      "image_url": "/uploads/07eeeb602cc671884616f3eb1e52ebf9/barcode/image/5989c9b0-cc22-4434-9310-4ec2e8487299/275f1538-f8c3-4381-88e6-b69659b075fd.svg",
      "owner_id": "088eea54-d958-474b-bd54-45dbb45f3d6a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/088eea54-d958-474b-bd54-45dbb45f3d6a"
        },
        "data": {
          "type": "customers",
          "id": "088eea54-d958-474b-bd54-45dbb45f3d6a"
        }
      }
    }
  },
  "included": [
    {
      "id": "088eea54-d958-474b-bd54-45dbb45f3d6a",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-18T14:41:39+00:00",
        "updated_at": "2021-11-18T14:41:39+00:00",
        "number": 1,
        "name": "Klein-Sanford",
        "email": "sanford.klein@schmeler-boyle.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=088eea54-d958-474b-bd54-45dbb45f3d6a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=088eea54-d958-474b-bd54-45dbb45f3d6a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=088eea54-d958-474b-bd54-45dbb45f3d6a&filter[owner_type]=customers"
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
          "owner_id": "737912ea-e0b2-4f7d-8ff4-c03a59ee16f6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "576747d4-89da-4408-9ace-1ab7114f5f16",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-18T14:41:40+00:00",
      "updated_at": "2021-11-18T14:41:40+00:00",
      "number": "http://bqbl.it/576747d4-89da-4408-9ace-1ab7114f5f16",
      "barcode_type": "qr_code",
      "image_url": "/uploads/eee02d446c055ec1e754d9c02ab2ebf6/barcode/image/576747d4-89da-4408-9ace-1ab7114f5f16/21c96654-8839-4667-a61f-2ec48c7bf340.svg",
      "owner_id": "737912ea-e0b2-4f7d-8ff4-c03a59ee16f6",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=737912ea-e0b2-4f7d-8ff4-c03a59ee16f6&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=737912ea-e0b2-4f7d-8ff4-c03a59ee16f6&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=737912ea-e0b2-4f7d-8ff4-c03a59ee16f6&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a3b5bc14-eb8f-4e5b-9148-6e5e282bb0b9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a3b5bc14-eb8f-4e5b-9148-6e5e282bb0b9",
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
    "id": "a3b5bc14-eb8f-4e5b-9148-6e5e282bb0b9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-18T14:41:40+00:00",
      "updated_at": "2021-11-18T14:41:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/26702c7129e3e0df76773830254566d6/barcode/image/a3b5bc14-eb8f-4e5b-9148-6e5e282bb0b9/73e23f20-de7c-4d4d-b252-07f0faa4e6bf.svg",
      "owner_id": "d40b22b8-8112-4c99-b4c0-40fcae9a257f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bcc979b8-4c9b-42de-a783-d65b9cf3199e' \
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