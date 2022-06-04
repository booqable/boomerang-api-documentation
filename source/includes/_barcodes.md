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
      "id": "9f0c1113-f1d3-4711-83d8-af2ce3bce9b2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-04T09:50:10+00:00",
        "updated_at": "2022-06-04T09:50:10+00:00",
        "number": "http://bqbl.it/9f0c1113-f1d3-4711-83d8-af2ce3bce9b2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/86a5d52dedff5dc43760c943d6da20d9/barcode/image/9f0c1113-f1d3-4711-83d8-af2ce3bce9b2/031129f7-1adc-4a1a-983c-dc6440e2e1e9.svg",
        "owner_id": "63340690-8b92-46ea-a689-fdea22109d86",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/63340690-8b92-46ea-a689-fdea22109d86"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Feeb3a86d-b50e-4f92-a979-ba3d9a91bd27&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eeb3a86d-b50e-4f92-a979-ba3d9a91bd27",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-04T09:50:11+00:00",
        "updated_at": "2022-06-04T09:50:11+00:00",
        "number": "http://bqbl.it/eeb3a86d-b50e-4f92-a979-ba3d9a91bd27",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d787da177fd465602cc721f3856155e4/barcode/image/eeb3a86d-b50e-4f92-a979-ba3d9a91bd27/505d34c7-0cf6-4873-889c-8d0e41357f7b.svg",
        "owner_id": "0c7e583b-931d-4b94-8b7d-75cd24cfac03",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0c7e583b-931d-4b94-8b7d-75cd24cfac03"
          },
          "data": {
            "type": "customers",
            "id": "0c7e583b-931d-4b94-8b7d-75cd24cfac03"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0c7e583b-931d-4b94-8b7d-75cd24cfac03",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-04T09:50:11+00:00",
        "updated_at": "2022-06-04T09:50:11+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Skiles, Miller and Weber",
        "email": "skiles.and.miller.weber@mcglynn-gutmann.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=0c7e583b-931d-4b94-8b7d-75cd24cfac03&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0c7e583b-931d-4b94-8b7d-75cd24cfac03&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0c7e583b-931d-4b94-8b7d-75cd24cfac03&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZmI4YzFjMTgtN2I0OC00NDZjLWJiNjYtZmY3OTFmOWMzNGFm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fb8c1c18-7b48-446c-bb66-ff791f9c34af",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-04T09:50:11+00:00",
        "updated_at": "2022-06-04T09:50:11+00:00",
        "number": "http://bqbl.it/fb8c1c18-7b48-446c-bb66-ff791f9c34af",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6ed4de20a8e025a7b78eb7c8a2ada802/barcode/image/fb8c1c18-7b48-446c-bb66-ff791f9c34af/0ddf7f97-0f02-4281-a49e-38e3864da862.svg",
        "owner_id": "7897e907-bd8f-4a0f-a936-461c89317767",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7897e907-bd8f-4a0f-a936-461c89317767"
          },
          "data": {
            "type": "customers",
            "id": "7897e907-bd8f-4a0f-a936-461c89317767"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7897e907-bd8f-4a0f-a936-461c89317767",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-04T09:50:11+00:00",
        "updated_at": "2022-06-04T09:50:11+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Wuckert, Lockman and Shanahan",
        "email": "shanahan.lockman.wuckert.and@kuphal.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=7897e907-bd8f-4a0f-a936-461c89317767&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7897e907-bd8f-4a0f-a936-461c89317767&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7897e907-bd8f-4a0f-a936-461c89317767&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-04T09:50:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fc354c93-0004-49fd-8281-66fe6b57c7b6?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fc354c93-0004-49fd-8281-66fe6b57c7b6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-04T09:50:12+00:00",
      "updated_at": "2022-06-04T09:50:12+00:00",
      "number": "http://bqbl.it/fc354c93-0004-49fd-8281-66fe6b57c7b6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/687a74b67155678783f4ee0e6c2c676e/barcode/image/fc354c93-0004-49fd-8281-66fe6b57c7b6/7c1acae6-f653-492a-be95-361fb9c94ee7.svg",
      "owner_id": "91941d09-ed34-438f-9462-7d06f1f0464d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/91941d09-ed34-438f-9462-7d06f1f0464d"
        },
        "data": {
          "type": "customers",
          "id": "91941d09-ed34-438f-9462-7d06f1f0464d"
        }
      }
    }
  },
  "included": [
    {
      "id": "91941d09-ed34-438f-9462-7d06f1f0464d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-04T09:50:12+00:00",
        "updated_at": "2022-06-04T09:50:12+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Sporer Group",
        "email": "group_sporer@white-nikolaus.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=91941d09-ed34-438f-9462-7d06f1f0464d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=91941d09-ed34-438f-9462-7d06f1f0464d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=91941d09-ed34-438f-9462-7d06f1f0464d&filter[owner_type]=customers"
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
          "owner_id": "11d13f77-9518-480a-b3c2-37bac3e93509",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c76a75c2-a22c-4141-b329-12a498301649",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-04T09:50:12+00:00",
      "updated_at": "2022-06-04T09:50:12+00:00",
      "number": "http://bqbl.it/c76a75c2-a22c-4141-b329-12a498301649",
      "barcode_type": "qr_code",
      "image_url": "/uploads/73169ae49cc12f0a5bc74f95e3f1e76f/barcode/image/c76a75c2-a22c-4141-b329-12a498301649/b68c48c4-ac63-4e8d-9944-e3709b5f8bac.svg",
      "owner_id": "11d13f77-9518-480a-b3c2-37bac3e93509",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cd6c1ea1-9db6-46d8-bca8-f3c9661115f9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cd6c1ea1-9db6-46d8-bca8-f3c9661115f9",
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
    "id": "cd6c1ea1-9db6-46d8-bca8-f3c9661115f9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-04T09:50:13+00:00",
      "updated_at": "2022-06-04T09:50:13+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b47dddae230697f6d034b413b85ce403/barcode/image/cd6c1ea1-9db6-46d8-bca8-f3c9661115f9/ab93f121-dd6a-4c32-8aab-8e8673aaa974.svg",
      "owner_id": "b3f6037c-b62f-41b8-91f3-8a3a0afd5ff9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6f7f5c02-a4fc-47a7-90fb-6b48c533ea5b' \
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