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
      "id": "932b799d-505e-4793-829f-68401619a8d0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-04T10:57:12+00:00",
        "updated_at": "2022-03-04T10:57:12+00:00",
        "number": "http://bqbl.it/932b799d-505e-4793-829f-68401619a8d0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0e7453e4669a6897d17cace9747cd3a5/barcode/image/932b799d-505e-4793-829f-68401619a8d0/963d99be-e313-4761-991c-aad9ba805eab.svg",
        "owner_id": "4a458ec9-b796-4745-be54-b116f98be892",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4a458ec9-b796-4745-be54-b116f98be892"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe539f935-db33-4cf3-a18a-c8be13b7a63f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e539f935-db33-4cf3-a18a-c8be13b7a63f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-04T10:57:13+00:00",
        "updated_at": "2022-03-04T10:57:13+00:00",
        "number": "http://bqbl.it/e539f935-db33-4cf3-a18a-c8be13b7a63f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/41bbb364794eee3c920883c9fbdb7df2/barcode/image/e539f935-db33-4cf3-a18a-c8be13b7a63f/4eec8cd9-0918-4a26-96e5-ce452b25d9ab.svg",
        "owner_id": "3149ac97-6f30-4d34-bebc-c2c7520c5572",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3149ac97-6f30-4d34-bebc-c2c7520c5572"
          },
          "data": {
            "type": "customers",
            "id": "3149ac97-6f30-4d34-bebc-c2c7520c5572"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3149ac97-6f30-4d34-bebc-c2c7520c5572",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-04T10:57:13+00:00",
        "updated_at": "2022-03-04T10:57:13+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Armstrong-Stark",
        "email": "armstrong.stark@hessel.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=3149ac97-6f30-4d34-bebc-c2c7520c5572&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3149ac97-6f30-4d34-bebc-c2c7520c5572&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3149ac97-6f30-4d34-bebc-c2c7520c5572&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjkyODJiODktNWQ3MS00Y2E0LWE2MTgtZDFmMDUyYzlhYmYw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "69282b89-5d71-4ca4-a618-d1f052c9abf0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-04T10:57:13+00:00",
        "updated_at": "2022-03-04T10:57:13+00:00",
        "number": "http://bqbl.it/69282b89-5d71-4ca4-a618-d1f052c9abf0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/315a1b20fb36ce72ffb8ad9b6a7ee145/barcode/image/69282b89-5d71-4ca4-a618-d1f052c9abf0/e111ea58-56a0-45ba-91cc-ee685beba9f0.svg",
        "owner_id": "c7faf548-562b-461f-bde0-17b74a8985e7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c7faf548-562b-461f-bde0-17b74a8985e7"
          },
          "data": {
            "type": "customers",
            "id": "c7faf548-562b-461f-bde0-17b74a8985e7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c7faf548-562b-461f-bde0-17b74a8985e7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-04T10:57:13+00:00",
        "updated_at": "2022-03-04T10:57:13+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Quitzon-Towne",
        "email": "towne.quitzon@okon.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=c7faf548-562b-461f-bde0-17b74a8985e7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c7faf548-562b-461f-bde0-17b74a8985e7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c7faf548-562b-461f-bde0-17b74a8985e7&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-04T10:57:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c0c3d365-8a6c-47a0-ae61-8ad8267b38ef?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c0c3d365-8a6c-47a0-ae61-8ad8267b38ef",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-04T10:57:14+00:00",
      "updated_at": "2022-03-04T10:57:14+00:00",
      "number": "http://bqbl.it/c0c3d365-8a6c-47a0-ae61-8ad8267b38ef",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ce3e2605240b01e43dd1c0af8c442ebd/barcode/image/c0c3d365-8a6c-47a0-ae61-8ad8267b38ef/04fbdcc5-8922-46a9-9189-00818c533270.svg",
      "owner_id": "c30ec95a-9b3f-4e38-ade5-8a0360804e6f",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c30ec95a-9b3f-4e38-ade5-8a0360804e6f"
        },
        "data": {
          "type": "customers",
          "id": "c30ec95a-9b3f-4e38-ade5-8a0360804e6f"
        }
      }
    }
  },
  "included": [
    {
      "id": "c30ec95a-9b3f-4e38-ade5-8a0360804e6f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-04T10:57:14+00:00",
        "updated_at": "2022-03-04T10:57:14+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Langworth-Parisian",
        "email": "parisian_langworth@zieme.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=c30ec95a-9b3f-4e38-ade5-8a0360804e6f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c30ec95a-9b3f-4e38-ade5-8a0360804e6f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c30ec95a-9b3f-4e38-ade5-8a0360804e6f&filter[owner_type]=customers"
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
          "owner_id": "57424187-d771-4360-af6b-6827222159d3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f657f1cf-edfd-4c81-9fa2-7e1c778ab84f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-04T10:57:15+00:00",
      "updated_at": "2022-03-04T10:57:15+00:00",
      "number": "http://bqbl.it/f657f1cf-edfd-4c81-9fa2-7e1c778ab84f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7248ece0e7b161c389a482a0fe7b9af0/barcode/image/f657f1cf-edfd-4c81-9fa2-7e1c778ab84f/635e7eb9-ac6a-4f5f-a77e-587f69cff5b7.svg",
      "owner_id": "57424187-d771-4360-af6b-6827222159d3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/8eac4512-6cdd-4922-b048-a5753ca200e8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8eac4512-6cdd-4922-b048-a5753ca200e8",
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
    "id": "8eac4512-6cdd-4922-b048-a5753ca200e8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-04T10:57:15+00:00",
      "updated_at": "2022-03-04T10:57:15+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/82f4ffb6b8fb8343b3330fe2fc7790ce/barcode/image/8eac4512-6cdd-4922-b048-a5753ca200e8/dab7e36f-6622-4ad1-b42a-177d1ccc139a.svg",
      "owner_id": "608bcc21-ae11-456a-b21c-cb2caba8c134",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/07c9d9c6-5cc2-4e90-bff3-36038f2062bb' \
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