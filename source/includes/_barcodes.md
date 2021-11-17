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
      "id": "0a346371-c859-459b-8934-5cec855b3e11",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-17T21:04:12+00:00",
        "updated_at": "2021-11-17T21:04:12+00:00",
        "number": "http://bqbl.it/0a346371-c859-459b-8934-5cec855b3e11",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ceec73e4c8f911de0245537fb1bec912/barcode/image/0a346371-c859-459b-8934-5cec855b3e11/1277a928-4182-4d20-bd03-e64851188c25.svg",
        "owner_id": "a0f16751-92ee-4fd4-85e7-9c8764ff1059",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a0f16751-92ee-4fd4-85e7-9c8764ff1059"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F95a127bc-4677-43a5-9060-ba20938f5b33&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "95a127bc-4677-43a5-9060-ba20938f5b33",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-11-17T21:04:13+00:00",
        "updated_at": "2021-11-17T21:04:13+00:00",
        "number": "http://bqbl.it/95a127bc-4677-43a5-9060-ba20938f5b33",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0605c3e9ae4f0cde7ffca852d29cd3eb/barcode/image/95a127bc-4677-43a5-9060-ba20938f5b33/3c2738cf-6bba-4902-9bdb-160174488056.svg",
        "owner_id": "aabc20ef-0e03-4437-a187-d2d83487758f",
        "owner_type": "Customer"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aabc20ef-0e03-4437-a187-d2d83487758f"
          },
          "data": {
            "type": "customers",
            "id": "aabc20ef-0e03-4437-a187-d2d83487758f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "aabc20ef-0e03-4437-a187-d2d83487758f",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-17T21:04:13+00:00",
        "updated_at": "2021-11-17T21:04:13+00:00",
        "number": 1,
        "name": "Hoppe and Sons",
        "email": "hoppe_and_sons@swift-rempel.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=aabc20ef-0e03-4437-a187-d2d83487758f&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aabc20ef-0e03-4437-a187-d2d83487758f"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=aabc20ef-0e03-4437-a187-d2d83487758f&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F95a127bc-4677-43a5-9060-ba20938f5b33&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F95a127bc-4677-43a5-9060-ba20938f5b33&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F95a127bc-4677-43a5-9060-ba20938f5b33&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-17T21:04:03Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/139c4145-7812-42e2-8937-c766c7d5f67d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "139c4145-7812-42e2-8937-c766c7d5f67d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-17T21:04:13+00:00",
      "updated_at": "2021-11-17T21:04:13+00:00",
      "number": "http://bqbl.it/139c4145-7812-42e2-8937-c766c7d5f67d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5f9587ca5204dbb9e30d2146b6ad0d0a/barcode/image/139c4145-7812-42e2-8937-c766c7d5f67d/3c4b1ba3-8358-4220-8f31-cb4a90c78f26.svg",
      "owner_id": "58bb2823-9470-40b4-8d60-d95af5e31811",
      "owner_type": "Customer"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/58bb2823-9470-40b4-8d60-d95af5e31811"
        },
        "data": {
          "type": "customers",
          "id": "58bb2823-9470-40b4-8d60-d95af5e31811"
        }
      }
    }
  },
  "included": [
    {
      "id": "58bb2823-9470-40b4-8d60-d95af5e31811",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-17T21:04:13+00:00",
        "updated_at": "2021-11-17T21:04:13+00:00",
        "number": 1,
        "name": "Predovic and Sons",
        "email": "sons.predovic.and@bogan.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=58bb2823-9470-40b4-8d60-d95af5e31811&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=58bb2823-9470-40b4-8d60-d95af5e31811"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=58bb2823-9470-40b4-8d60-d95af5e31811&filter[notable_type]=Customer"
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
          "owner_id": "50183e0d-31b1-47ba-a9c3-fe189279197b",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d647d64a-2318-4d93-85b1-a7227a3e417a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-17T21:04:14+00:00",
      "updated_at": "2021-11-17T21:04:14+00:00",
      "number": "http://bqbl.it/d647d64a-2318-4d93-85b1-a7227a3e417a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/63b640548443e9fd034e64f5739e48b4/barcode/image/d647d64a-2318-4d93-85b1-a7227a3e417a/bef348fa-d47f-4a61-b1bf-511b8382aa13.svg",
      "owner_id": "50183e0d-31b1-47ba-a9c3-fe189279197b",
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
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=50183e0d-31b1-47ba-a9c3-fe189279197b&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=50183e0d-31b1-47ba-a9c3-fe189279197b&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=50183e0d-31b1-47ba-a9c3-fe189279197b&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/94f9632f-20a8-4b2f-9073-39459193e5ce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "94f9632f-20a8-4b2f-9073-39459193e5ce",
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
    "id": "94f9632f-20a8-4b2f-9073-39459193e5ce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-11-17T21:04:14+00:00",
      "updated_at": "2021-11-17T21:04:14+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/be354d7eaf103a8d93c73584e242bd9d/barcode/image/94f9632f-20a8-4b2f-9073-39459193e5ce/dc0eda27-2572-40c0-8f50-6d9687a83e34.svg",
      "owner_id": "9d37cac0-aba2-4d40-8f0a-85f0935f1183",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/302fc89b-e5d6-4028-91ec-a0a303315693' \
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