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
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


## Relationships
A barcodes has the following relationships:

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
      "id": "065f8d97-56f2-4591-a5f0-1c269a139a5f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-11T12:48:13+00:00",
        "updated_at": "2021-10-11T12:48:13+00:00",
        "number": "http://bqbl.it/065f8d97-56f2-4591-a5f0-1c269a139a5f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2258445c4d3146816cdb10194b1fe415/barcode/image/065f8d97-56f2-4591-a5f0-1c269a139a5f/c33ffc0e-25ee-4b0e-8aab-7a59dec1fde7.svg",
        "owner_id": "bd6f1b7b-951f-49b7-97f5-4078514f592b",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/bd6f1b7b-951f-49b7-97f5-4078514f592b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa2a553d2-fa36-4353-ae2b-af6837012311&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a2a553d2-fa36-4353-ae2b-af6837012311",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-10-11T12:48:14+00:00",
        "updated_at": "2021-10-11T12:48:14+00:00",
        "number": "http://bqbl.it/a2a553d2-fa36-4353-ae2b-af6837012311",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bf223a50008ead5f82e7a44e1917524a/barcode/image/a2a553d2-fa36-4353-ae2b-af6837012311/cadb9f28-c71d-499b-801c-27031c7089e3.svg",
        "owner_id": "1ea58d00-8897-46a7-b5f1-0b37c55f54d1",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1ea58d00-8897-46a7-b5f1-0b37c55f54d1"
          },
          "data": {
            "type": "customers",
            "id": "1ea58d00-8897-46a7-b5f1-0b37c55f54d1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1ea58d00-8897-46a7-b5f1-0b37c55f54d1",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-11T12:48:14+00:00",
        "updated_at": "2021-10-11T12:48:14+00:00",
        "number": 1,
        "name": "Robel LLC",
        "email": "robel.llc@watsica-kiehn.info",
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
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1ea58d00-8897-46a7-b5f1-0b37c55f54d1"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-11T12:48:10Z`
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

> How to fetch a barcodes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/52cd461c-a940-4fef-b602-41137e2faa49?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "52cd461c-a940-4fef-b602-41137e2faa49",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-11T12:48:15+00:00",
      "updated_at": "2021-10-11T12:48:15+00:00",
      "number": "http://bqbl.it/52cd461c-a940-4fef-b602-41137e2faa49",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0e5ec9e10a6ad0420fed72ca578dc98e/barcode/image/52cd461c-a940-4fef-b602-41137e2faa49/7df2d208-b4a1-4324-b6ae-5990be1bf904.svg",
      "owner_id": "c97a7c5b-d9d1-4df5-bc23-5de2dded02f2",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c97a7c5b-d9d1-4df5-bc23-5de2dded02f2"
        },
        "data": {
          "type": "customers",
          "id": "c97a7c5b-d9d1-4df5-bc23-5de2dded02f2"
        }
      }
    }
  },
  "included": [
    {
      "id": "c97a7c5b-d9d1-4df5-bc23-5de2dded02f2",
      "type": "customers",
      "attributes": {
        "created_at": "2021-10-11T12:48:15+00:00",
        "updated_at": "2021-10-11T12:48:15+00:00",
        "number": 1,
        "name": "Lang-Streich",
        "email": "lang_streich@pollich.info",
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
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c97a7c5b-d9d1-4df5-bc23-5de2dded02f2"
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
          "owner_id": "4a54c694-6682-4357-84a7-9704ddaece97",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "79811f83-03ea-4fee-ac85-f22591aeb4be",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-11T12:48:16+00:00",
      "updated_at": "2021-10-11T12:48:16+00:00",
      "number": "http://bqbl.it/79811f83-03ea-4fee-ac85-f22591aeb4be",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8e2c908df54db917a2abbc0f3fc89d0e/barcode/image/79811f83-03ea-4fee-ac85-f22591aeb4be/4c4f2dea-803f-4f6f-8345-d2ec85344224.svg",
      "owner_id": "4a54c694-6682-4357-84a7-9704ddaece97",
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode

> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/bd86c37f-81fe-44a5-b559-bf597a247323' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bd86c37f-81fe-44a5-b559-bf597a247323",
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
    "id": "bd86c37f-81fe-44a5-b559-bf597a247323",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-10-11T12:48:16+00:00",
      "updated_at": "2021-10-11T12:48:16+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2db2ffacb0f1735b316d6422cfcfd3d5/barcode/image/bd86c37f-81fe-44a5-b559-bf597a247323/d4b3156a-bc4b-406d-8deb-7026b94de3c4.svg",
      "owner_id": "dc57bb05-551f-478a-87f7-c5cc61abd7aa",
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Item`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode

> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/b5df5493-ddb9-420d-bb95-a117b38be472' \
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