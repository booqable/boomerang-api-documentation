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
      "id": "9aedb574-48e3-4fb7-aef9-a2c3ffe05e47",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-04T10:04:13+00:00",
        "updated_at": "2022-05-04T10:04:13+00:00",
        "number": "http://bqbl.it/9aedb574-48e3-4fb7-aef9-a2c3ffe05e47",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b4f15096c4940bc46bb8697ae4fba23c/barcode/image/9aedb574-48e3-4fb7-aef9-a2c3ffe05e47/cb0d45bb-a26c-491b-bff6-bcd4d3a0973a.svg",
        "owner_id": "40ca2807-e6e4-41ae-84a5-bc5ee493cad0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/40ca2807-e6e4-41ae-84a5-bc5ee493cad0"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F706a0a90-7ab8-4ce4-af59-2d7af046c692&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "706a0a90-7ab8-4ce4-af59-2d7af046c692",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-04T10:04:13+00:00",
        "updated_at": "2022-05-04T10:04:13+00:00",
        "number": "http://bqbl.it/706a0a90-7ab8-4ce4-af59-2d7af046c692",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f17b38ad83e253feb16ae4eb8bb63b26/barcode/image/706a0a90-7ab8-4ce4-af59-2d7af046c692/53e181f9-f2db-4f40-ab48-607e9b832992.svg",
        "owner_id": "8d67d901-3dc5-4006-a22a-dc01b39ef0c3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8d67d901-3dc5-4006-a22a-dc01b39ef0c3"
          },
          "data": {
            "type": "customers",
            "id": "8d67d901-3dc5-4006-a22a-dc01b39ef0c3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8d67d901-3dc5-4006-a22a-dc01b39ef0c3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-04T10:04:13+00:00",
        "updated_at": "2022-05-04T10:04:13+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Williamson-Lesch",
        "email": "williamson.lesch@rogahn.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=8d67d901-3dc5-4006-a22a-dc01b39ef0c3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8d67d901-3dc5-4006-a22a-dc01b39ef0c3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8d67d901-3dc5-4006-a22a-dc01b39ef0c3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDdmOWYxN2YtMmUxYS00NjQ0LWIyZGEtODJmYTA0YWMyZGJk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "07f9f17f-2e1a-4644-b2da-82fa04ac2dbd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-04T10:04:14+00:00",
        "updated_at": "2022-05-04T10:04:14+00:00",
        "number": "http://bqbl.it/07f9f17f-2e1a-4644-b2da-82fa04ac2dbd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3c365ba7c4afa78e5c0af4a83f4cc22f/barcode/image/07f9f17f-2e1a-4644-b2da-82fa04ac2dbd/2fc293f5-f7c0-4369-9c44-cfca86c8e4bf.svg",
        "owner_id": "15061e00-7475-4aaf-829e-8dd3d127ff2d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/15061e00-7475-4aaf-829e-8dd3d127ff2d"
          },
          "data": {
            "type": "customers",
            "id": "15061e00-7475-4aaf-829e-8dd3d127ff2d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "15061e00-7475-4aaf-829e-8dd3d127ff2d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-04T10:04:14+00:00",
        "updated_at": "2022-05-04T10:04:14+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "King-Steuber",
        "email": "king_steuber@marks.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=15061e00-7475-4aaf-829e-8dd3d127ff2d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=15061e00-7475-4aaf-829e-8dd3d127ff2d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=15061e00-7475-4aaf-829e-8dd3d127ff2d&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-04T10:04:04Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/abe67798-440f-4db8-8349-c0891bcd2785?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "abe67798-440f-4db8-8349-c0891bcd2785",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-04T10:04:14+00:00",
      "updated_at": "2022-05-04T10:04:14+00:00",
      "number": "http://bqbl.it/abe67798-440f-4db8-8349-c0891bcd2785",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0338b2cf71eebcbf09c6e491af7899c7/barcode/image/abe67798-440f-4db8-8349-c0891bcd2785/7c09f7f3-fec3-4c0a-94a6-0ec75f5642f3.svg",
      "owner_id": "51293058-6c4a-48d0-bc67-db090786169b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/51293058-6c4a-48d0-bc67-db090786169b"
        },
        "data": {
          "type": "customers",
          "id": "51293058-6c4a-48d0-bc67-db090786169b"
        }
      }
    }
  },
  "included": [
    {
      "id": "51293058-6c4a-48d0-bc67-db090786169b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-04T10:04:14+00:00",
        "updated_at": "2022-05-04T10:04:14+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Feil Inc",
        "email": "feil_inc@steuber.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=51293058-6c4a-48d0-bc67-db090786169b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=51293058-6c4a-48d0-bc67-db090786169b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=51293058-6c4a-48d0-bc67-db090786169b&filter[owner_type]=customers"
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
          "owner_id": "94487a28-748f-4b6b-ae11-0e1902c6e2a6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6a474850-6564-4541-a1cb-1b077dffe6a6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-04T10:04:15+00:00",
      "updated_at": "2022-05-04T10:04:15+00:00",
      "number": "http://bqbl.it/6a474850-6564-4541-a1cb-1b077dffe6a6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b3be656c2279715c3d744d5fbd8e52ad/barcode/image/6a474850-6564-4541-a1cb-1b077dffe6a6/030264ae-6846-4c50-a899-da74f14e0a11.svg",
      "owner_id": "94487a28-748f-4b6b-ae11-0e1902c6e2a6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/676889b5-ac3f-4174-a337-411432c693d2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "676889b5-ac3f-4174-a337-411432c693d2",
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
    "id": "676889b5-ac3f-4174-a337-411432c693d2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-04T10:04:15+00:00",
      "updated_at": "2022-05-04T10:04:15+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/646b8099b8d89fac18ca3987ea993b62/barcode/image/676889b5-ac3f-4174-a337-411432c693d2/574e1095-d8b7-45e8-bea3-afdb74fc4c82.svg",
      "owner_id": "ff449841-4feb-4f8d-8477-4f182250a149",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cf4ae018-233d-40ef-be78-dfc8fa61be9c' \
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