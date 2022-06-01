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
      "id": "1e579223-ec67-44a8-8256-33c292b2c0e4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-01T08:55:30+00:00",
        "updated_at": "2022-06-01T08:55:30+00:00",
        "number": "http://bqbl.it/1e579223-ec67-44a8-8256-33c292b2c0e4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/505449b1a0efb217b4f6ee65ccef4b0b/barcode/image/1e579223-ec67-44a8-8256-33c292b2c0e4/f95ca748-4c99-4708-89b8-e0a2066d5438.svg",
        "owner_id": "21ce7b5b-d200-4c5a-bbca-53c910bc4b8e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/21ce7b5b-d200-4c5a-bbca-53c910bc4b8e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fa88311c3-bfd9-4b10-b924-880e920dbc4e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a88311c3-bfd9-4b10-b924-880e920dbc4e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-01T08:55:30+00:00",
        "updated_at": "2022-06-01T08:55:30+00:00",
        "number": "http://bqbl.it/a88311c3-bfd9-4b10-b924-880e920dbc4e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a5bfcdae83681977ee0d57516c1c2090/barcode/image/a88311c3-bfd9-4b10-b924-880e920dbc4e/fa17b5cd-d86b-4d0a-8bdd-b1a948ca4123.svg",
        "owner_id": "5b31c3dd-e74d-48a2-babd-1cd24ea027f2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5b31c3dd-e74d-48a2-babd-1cd24ea027f2"
          },
          "data": {
            "type": "customers",
            "id": "5b31c3dd-e74d-48a2-babd-1cd24ea027f2"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5b31c3dd-e74d-48a2-babd-1cd24ea027f2",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-01T08:55:30+00:00",
        "updated_at": "2022-06-01T08:55:30+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kessler-Gerlach",
        "email": "kessler_gerlach@muller.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=5b31c3dd-e74d-48a2-babd-1cd24ea027f2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5b31c3dd-e74d-48a2-babd-1cd24ea027f2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5b31c3dd-e74d-48a2-babd-1cd24ea027f2&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjRmOTFkODAtMDc1Ny00ZjE1LThjZTktZTZjMTY2NDNlNTEw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f4f91d80-0757-4f15-8ce9-e6c16643e510",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-01T08:55:31+00:00",
        "updated_at": "2022-06-01T08:55:31+00:00",
        "number": "http://bqbl.it/f4f91d80-0757-4f15-8ce9-e6c16643e510",
        "barcode_type": "qr_code",
        "image_url": "/uploads/feca21822772c105692cd65a0509865a/barcode/image/f4f91d80-0757-4f15-8ce9-e6c16643e510/e5034e3e-4dfc-4c0d-85e3-4d7c28bc5e9a.svg",
        "owner_id": "ef57dfab-6990-4a99-8a5c-fe9344953d94",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ef57dfab-6990-4a99-8a5c-fe9344953d94"
          },
          "data": {
            "type": "customers",
            "id": "ef57dfab-6990-4a99-8a5c-fe9344953d94"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ef57dfab-6990-4a99-8a5c-fe9344953d94",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-01T08:55:31+00:00",
        "updated_at": "2022-06-01T08:55:31+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Leuschke Inc",
        "email": "leuschke_inc@reilly.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=ef57dfab-6990-4a99-8a5c-fe9344953d94&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ef57dfab-6990-4a99-8a5c-fe9344953d94&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ef57dfab-6990-4a99-8a5c-fe9344953d94&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-01T08:55:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/404dc203-ad12-4e70-9a57-6b3094c3b780?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "404dc203-ad12-4e70-9a57-6b3094c3b780",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-01T08:55:31+00:00",
      "updated_at": "2022-06-01T08:55:31+00:00",
      "number": "http://bqbl.it/404dc203-ad12-4e70-9a57-6b3094c3b780",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1c428120623ed7ef59813b5b6dc1258a/barcode/image/404dc203-ad12-4e70-9a57-6b3094c3b780/aeec979b-29fd-43fe-b264-439616efb704.svg",
      "owner_id": "f7bde45f-b44b-467c-a807-5e441a000f92",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f7bde45f-b44b-467c-a807-5e441a000f92"
        },
        "data": {
          "type": "customers",
          "id": "f7bde45f-b44b-467c-a807-5e441a000f92"
        }
      }
    }
  },
  "included": [
    {
      "id": "f7bde45f-b44b-467c-a807-5e441a000f92",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-01T08:55:31+00:00",
        "updated_at": "2022-06-01T08:55:31+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kutch, Nitzsche and Orn",
        "email": "orn_kutch_nitzsche_and@williamson.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=f7bde45f-b44b-467c-a807-5e441a000f92&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f7bde45f-b44b-467c-a807-5e441a000f92&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f7bde45f-b44b-467c-a807-5e441a000f92&filter[owner_type]=customers"
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
          "owner_id": "e91bd98d-75bc-4462-90ce-303c65714830",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b0efe70d-90fb-4862-b84a-08ca170a7d93",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-01T08:55:32+00:00",
      "updated_at": "2022-06-01T08:55:32+00:00",
      "number": "http://bqbl.it/b0efe70d-90fb-4862-b84a-08ca170a7d93",
      "barcode_type": "qr_code",
      "image_url": "/uploads/64e1a5d6a11a12adc0881a3bf9c97dd4/barcode/image/b0efe70d-90fb-4862-b84a-08ca170a7d93/69190d59-dce4-4697-b272-bbfa2f44e9c4.svg",
      "owner_id": "e91bd98d-75bc-4462-90ce-303c65714830",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/60d4ffc6-d853-4b25-9287-4fa93844f5e5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "60d4ffc6-d853-4b25-9287-4fa93844f5e5",
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
    "id": "60d4ffc6-d853-4b25-9287-4fa93844f5e5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-01T08:55:32+00:00",
      "updated_at": "2022-06-01T08:55:32+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2c5d278acf7024bc74f73185fda37fdd/barcode/image/60d4ffc6-d853-4b25-9287-4fa93844f5e5/4018159f-1a1a-44b5-8664-b28d04e40144.svg",
      "owner_id": "4d88aa19-256b-470a-9bb0-ec612a521200",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b1b6346a-be2f-4e3d-9a77-04734607eece' \
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