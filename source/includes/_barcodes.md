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
      "id": "dd181072-fc1d-4a37-9465-f56a89c9ea24",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-13T11:41:25+00:00",
        "updated_at": "2022-01-13T11:41:25+00:00",
        "number": "http://bqbl.it/dd181072-fc1d-4a37-9465-f56a89c9ea24",
        "barcode_type": "qr_code",
        "image_url": "/uploads/943bbecfd57afd7323a6771986d60cb0/barcode/image/dd181072-fc1d-4a37-9465-f56a89c9ea24/9e48bdcd-71ed-4368-bce1-b9e88289e5d8.svg",
        "owner_id": "ad20d9e6-c454-40cc-ba8d-cbae1de57ebd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ad20d9e6-c454-40cc-ba8d-cbae1de57ebd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F46871426-bde7-4f82-ad4b-098e5f1bbd89&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "46871426-bde7-4f82-ad4b-098e5f1bbd89",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-01-13T11:41:26+00:00",
        "updated_at": "2022-01-13T11:41:26+00:00",
        "number": "http://bqbl.it/46871426-bde7-4f82-ad4b-098e5f1bbd89",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d26929aaff3ce63b5e738ccdbef17367/barcode/image/46871426-bde7-4f82-ad4b-098e5f1bbd89/778d6a9a-4da5-45a2-a80d-e13844d4de37.svg",
        "owner_id": "7fdf75ef-87cf-41bd-94f1-b074ade1125d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7fdf75ef-87cf-41bd-94f1-b074ade1125d"
          },
          "data": {
            "type": "customers",
            "id": "7fdf75ef-87cf-41bd-94f1-b074ade1125d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7fdf75ef-87cf-41bd-94f1-b074ade1125d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-13T11:41:26+00:00",
        "updated_at": "2022-01-13T11:41:26+00:00",
        "number": 1,
        "name": "Quigley, Dach and Sporer",
        "email": "and.sporer.quigley.dach@kirlin.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=7fdf75ef-87cf-41bd-94f1-b074ade1125d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7fdf75ef-87cf-41bd-94f1-b074ade1125d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7fdf75ef-87cf-41bd-94f1-b074ade1125d&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-13T11:41:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dabfe3e1-5ab0-48b1-99f4-640540a6e64a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dabfe3e1-5ab0-48b1-99f4-640540a6e64a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-13T11:41:26+00:00",
      "updated_at": "2022-01-13T11:41:26+00:00",
      "number": "http://bqbl.it/dabfe3e1-5ab0-48b1-99f4-640540a6e64a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/030da612e19d909ce2d2ed45ec8c290d/barcode/image/dabfe3e1-5ab0-48b1-99f4-640540a6e64a/2ea3c76d-f9e2-4bf5-9f77-1be9171108d9.svg",
      "owner_id": "f48758d8-5475-469f-8f83-f7163d4ef4a3",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f48758d8-5475-469f-8f83-f7163d4ef4a3"
        },
        "data": {
          "type": "customers",
          "id": "f48758d8-5475-469f-8f83-f7163d4ef4a3"
        }
      }
    }
  },
  "included": [
    {
      "id": "f48758d8-5475-469f-8f83-f7163d4ef4a3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-13T11:41:26+00:00",
        "updated_at": "2022-01-13T11:41:26+00:00",
        "number": 1,
        "name": "Hane-Nienow",
        "email": "hane_nienow@adams.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=f48758d8-5475-469f-8f83-f7163d4ef4a3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f48758d8-5475-469f-8f83-f7163d4ef4a3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f48758d8-5475-469f-8f83-f7163d4ef4a3&filter[owner_type]=customers"
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
          "owner_id": "4b3fb0a4-0941-4190-b461-e17b7f33003b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7424169c-b409-40af-9d04-1d237020fceb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-13T11:41:27+00:00",
      "updated_at": "2022-01-13T11:41:27+00:00",
      "number": "http://bqbl.it/7424169c-b409-40af-9d04-1d237020fceb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/56e09ebc9d1e508c14c77150823e22f6/barcode/image/7424169c-b409-40af-9d04-1d237020fceb/3b9b4562-992a-4fb8-ae0a-0a5fc4ec256d.svg",
      "owner_id": "4b3fb0a4-0941-4190-b461-e17b7f33003b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b54a3c7c-f7e4-4b80-922b-8d436c20b2de' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b54a3c7c-f7e4-4b80-922b-8d436c20b2de",
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
    "id": "b54a3c7c-f7e4-4b80-922b-8d436c20b2de",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-01-13T11:41:27+00:00",
      "updated_at": "2022-01-13T11:41:27+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/554763e5d393878695dfbc25e0f92501/barcode/image/b54a3c7c-f7e4-4b80-922b-8d436c20b2de/f1cdc03f-254d-4d61-9e5e-8cc4e3ac3d3e.svg",
      "owner_id": "54cd607d-7c84-4c1d-b673-0d1bd02acb73",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c57cfec9-bd0d-4beb-a6ff-9309ae69f306' \
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