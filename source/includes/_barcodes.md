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
      "id": "ad8fde60-5c93-4be8-b221-f88cbdfc0a33",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-19T11:08:35+00:00",
        "updated_at": "2022-05-19T11:08:35+00:00",
        "number": "http://bqbl.it/ad8fde60-5c93-4be8-b221-f88cbdfc0a33",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1daa9fa4cd132446e77ccca66fc466a1/barcode/image/ad8fde60-5c93-4be8-b221-f88cbdfc0a33/0371b5fb-6468-49e0-ae57-a0cfce5389e1.svg",
        "owner_id": "507ee6c4-7fe6-4904-8e5a-abdb6326955b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/507ee6c4-7fe6-4904-8e5a-abdb6326955b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2abd6ce8-1ccf-4532-a6d0-bfd8cbd6f618&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2abd6ce8-1ccf-4532-a6d0-bfd8cbd6f618",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-19T11:08:35+00:00",
        "updated_at": "2022-05-19T11:08:35+00:00",
        "number": "http://bqbl.it/2abd6ce8-1ccf-4532-a6d0-bfd8cbd6f618",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c424af07b1b0212915c42db08ed6d5a5/barcode/image/2abd6ce8-1ccf-4532-a6d0-bfd8cbd6f618/b2559c9f-a022-4272-87a7-3a7ff4bfbb96.svg",
        "owner_id": "b1cafd35-f8ff-4d33-aa7d-2444c8d0e3e7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b1cafd35-f8ff-4d33-aa7d-2444c8d0e3e7"
          },
          "data": {
            "type": "customers",
            "id": "b1cafd35-f8ff-4d33-aa7d-2444c8d0e3e7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b1cafd35-f8ff-4d33-aa7d-2444c8d0e3e7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-19T11:08:35+00:00",
        "updated_at": "2022-05-19T11:08:35+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Treutel LLC",
        "email": "llc.treutel@collins-cassin.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=b1cafd35-f8ff-4d33-aa7d-2444c8d0e3e7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b1cafd35-f8ff-4d33-aa7d-2444c8d0e3e7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b1cafd35-f8ff-4d33-aa7d-2444c8d0e3e7&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODYwNTU5NGYtOWViNy00YWE2LWJiMjctMGViOGIxZDc0MDUy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8605594f-9eb7-4aa6-bb27-0eb8b1d74052",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-19T11:08:36+00:00",
        "updated_at": "2022-05-19T11:08:36+00:00",
        "number": "http://bqbl.it/8605594f-9eb7-4aa6-bb27-0eb8b1d74052",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6196ad54e1f3ed6a5e809feab50060c3/barcode/image/8605594f-9eb7-4aa6-bb27-0eb8b1d74052/2a173eaa-7973-403e-9314-ca648a370533.svg",
        "owner_id": "82c5eb03-8293-42f5-9854-f6deaa12200b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/82c5eb03-8293-42f5-9854-f6deaa12200b"
          },
          "data": {
            "type": "customers",
            "id": "82c5eb03-8293-42f5-9854-f6deaa12200b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "82c5eb03-8293-42f5-9854-f6deaa12200b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-19T11:08:36+00:00",
        "updated_at": "2022-05-19T11:08:36+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Stokes-O'Kon",
        "email": "o.stokes.kon@swift.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=82c5eb03-8293-42f5-9854-f6deaa12200b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=82c5eb03-8293-42f5-9854-f6deaa12200b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=82c5eb03-8293-42f5-9854-f6deaa12200b&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T11:08:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c02c3ab3-432c-4233-9a45-3c22a377bdbe?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c02c3ab3-432c-4233-9a45-3c22a377bdbe",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-19T11:08:37+00:00",
      "updated_at": "2022-05-19T11:08:37+00:00",
      "number": "http://bqbl.it/c02c3ab3-432c-4233-9a45-3c22a377bdbe",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5fd645811bb01006e1cef234c0829f9c/barcode/image/c02c3ab3-432c-4233-9a45-3c22a377bdbe/e99ac987-ef1e-481a-8de0-365f27ecafb6.svg",
      "owner_id": "abae5cad-4de7-4df2-929a-17bfe32432b1",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/abae5cad-4de7-4df2-929a-17bfe32432b1"
        },
        "data": {
          "type": "customers",
          "id": "abae5cad-4de7-4df2-929a-17bfe32432b1"
        }
      }
    }
  },
  "included": [
    {
      "id": "abae5cad-4de7-4df2-929a-17bfe32432b1",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-19T11:08:36+00:00",
        "updated_at": "2022-05-19T11:08:37+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Cruickshank-Jakubowski",
        "email": "jakubowski_cruickshank@bins-hills.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=abae5cad-4de7-4df2-929a-17bfe32432b1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=abae5cad-4de7-4df2-929a-17bfe32432b1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=abae5cad-4de7-4df2-929a-17bfe32432b1&filter[owner_type]=customers"
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
          "owner_id": "3c09f45c-c128-4ac2-8f07-273c3a5b657b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c22b63df-14b5-4249-a289-f24046ed0c8e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-19T11:08:37+00:00",
      "updated_at": "2022-05-19T11:08:37+00:00",
      "number": "http://bqbl.it/c22b63df-14b5-4249-a289-f24046ed0c8e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6ea215f785f91eff4ed4799c2c629eeb/barcode/image/c22b63df-14b5-4249-a289-f24046ed0c8e/1479edef-e095-45b8-94e3-c36e55a5145d.svg",
      "owner_id": "3c09f45c-c128-4ac2-8f07-273c3a5b657b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ba535137-f3ff-4067-8e45-c83abeeee24a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ba535137-f3ff-4067-8e45-c83abeeee24a",
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
    "id": "ba535137-f3ff-4067-8e45-c83abeeee24a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-19T11:08:38+00:00",
      "updated_at": "2022-05-19T11:08:38+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/38e9faca390c2c7d0097123a817af790/barcode/image/ba535137-f3ff-4067-8e45-c83abeeee24a/fe1d5578-fbe7-4b62-8a63-bbf9bc45516e.svg",
      "owner_id": "9ce938fd-79a7-4acc-a96d-19d961ebf474",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/01722d57-0439-4ca5-8790-e5bcdbf097ca' \
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