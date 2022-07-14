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
      "id": "34c042d0-e162-4bff-9c59-bab10a4d0e17",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T10:48:34+00:00",
        "updated_at": "2022-07-14T10:48:34+00:00",
        "number": "http://bqbl.it/34c042d0-e162-4bff-9c59-bab10a4d0e17",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4f392b2ca2e9ea34e8b31387059b8ea9/barcode/image/34c042d0-e162-4bff-9c59-bab10a4d0e17/7ee164f3-4e94-4b08-8ee8-abe0197e68e8.svg",
        "owner_id": "e33900bb-6f48-4e40-adaf-da12f85d80cd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e33900bb-6f48-4e40-adaf-da12f85d80cd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F9d353b78-6c9e-4c2d-a61b-f5e2c9664b27&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9d353b78-6c9e-4c2d-a61b-f5e2c9664b27",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T10:48:35+00:00",
        "updated_at": "2022-07-14T10:48:35+00:00",
        "number": "http://bqbl.it/9d353b78-6c9e-4c2d-a61b-f5e2c9664b27",
        "barcode_type": "qr_code",
        "image_url": "/uploads/796822df0dcaf9d22ca8652081183523/barcode/image/9d353b78-6c9e-4c2d-a61b-f5e2c9664b27/57e94398-0743-4095-9b21-3fc264d59960.svg",
        "owner_id": "a6994653-1fb0-45ee-b148-9f40460cb630",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a6994653-1fb0-45ee-b148-9f40460cb630"
          },
          "data": {
            "type": "customers",
            "id": "a6994653-1fb0-45ee-b148-9f40460cb630"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a6994653-1fb0-45ee-b148-9f40460cb630",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:48:35+00:00",
        "updated_at": "2022-07-14T10:48:35+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Cummings and Sons",
        "email": "sons.cummings.and@gutkowski-cruickshank.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=a6994653-1fb0-45ee-b148-9f40460cb630&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a6994653-1fb0-45ee-b148-9f40460cb630&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a6994653-1fb0-45ee-b148-9f40460cb630&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmEyMGNiOTUtYmYyNC00YTYxLTg2OTEtZDQ0NDVhNzQ4OTFh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6a20cb95-bf24-4a61-8691-d4445a74891a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T10:48:35+00:00",
        "updated_at": "2022-07-14T10:48:35+00:00",
        "number": "http://bqbl.it/6a20cb95-bf24-4a61-8691-d4445a74891a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b7114cd0a9b6167cefafabf1ae65a0be/barcode/image/6a20cb95-bf24-4a61-8691-d4445a74891a/2f29d773-9432-4165-8112-fbdc16654129.svg",
        "owner_id": "f1917df0-68de-4100-a7c9-417a7550716f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f1917df0-68de-4100-a7c9-417a7550716f"
          },
          "data": {
            "type": "customers",
            "id": "f1917df0-68de-4100-a7c9-417a7550716f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f1917df0-68de-4100-a7c9-417a7550716f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:48:35+00:00",
        "updated_at": "2022-07-14T10:48:35+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Schmeler and Sons",
        "email": "and_sons_schmeler@buckridge.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=f1917df0-68de-4100-a7c9-417a7550716f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f1917df0-68de-4100-a7c9-417a7550716f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f1917df0-68de-4100-a7c9-417a7550716f&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:48:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ef352399-c1c5-441b-a10b-f58e6afaedff?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ef352399-c1c5-441b-a10b-f58e6afaedff",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T10:48:35+00:00",
      "updated_at": "2022-07-14T10:48:35+00:00",
      "number": "http://bqbl.it/ef352399-c1c5-441b-a10b-f58e6afaedff",
      "barcode_type": "qr_code",
      "image_url": "/uploads/34ced5ba7df8cea829f59465c787fbd1/barcode/image/ef352399-c1c5-441b-a10b-f58e6afaedff/e77588a7-ae69-4d55-8694-8a74b5ca911e.svg",
      "owner_id": "8a2e5773-1ef9-4d6b-885f-e2f1d90a1e1c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8a2e5773-1ef9-4d6b-885f-e2f1d90a1e1c"
        },
        "data": {
          "type": "customers",
          "id": "8a2e5773-1ef9-4d6b-885f-e2f1d90a1e1c"
        }
      }
    }
  },
  "included": [
    {
      "id": "8a2e5773-1ef9-4d6b-885f-e2f1d90a1e1c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:48:35+00:00",
        "updated_at": "2022-07-14T10:48:36+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hirthe-Dach",
        "email": "dach.hirthe@quitzon-durgan.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=8a2e5773-1ef9-4d6b-885f-e2f1d90a1e1c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8a2e5773-1ef9-4d6b-885f-e2f1d90a1e1c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8a2e5773-1ef9-4d6b-885f-e2f1d90a1e1c&filter[owner_type]=customers"
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
          "owner_id": "099fee47-f4b0-4a48-99d7-32cb4feb2eeb",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "168f3629-72aa-4dcc-b7c1-2a1fec10e5bd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T10:48:36+00:00",
      "updated_at": "2022-07-14T10:48:36+00:00",
      "number": "http://bqbl.it/168f3629-72aa-4dcc-b7c1-2a1fec10e5bd",
      "barcode_type": "qr_code",
      "image_url": "/uploads/045e16fa366f2dbcf0a73219890c814e/barcode/image/168f3629-72aa-4dcc-b7c1-2a1fec10e5bd/56be7359-4eb9-4718-bed7-856443d02084.svg",
      "owner_id": "099fee47-f4b0-4a48-99d7-32cb4feb2eeb",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4adade17-b217-48ea-b24a-04bd04344a82' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4adade17-b217-48ea-b24a-04bd04344a82",
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
    "id": "4adade17-b217-48ea-b24a-04bd04344a82",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T10:48:36+00:00",
      "updated_at": "2022-07-14T10:48:36+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5b2269355a0a7775c34f4cd44dfb45f7/barcode/image/4adade17-b217-48ea-b24a-04bd04344a82/35c990f8-a5c1-47df-88ec-2e0707f788d8.svg",
      "owner_id": "2c20e9ca-dc65-4b9d-974e-f8d0a6ae2394",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d0b1bec5-d3b8-4adb-8ecc-0dfe275375f4' \
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