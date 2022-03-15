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
      "id": "d1dbd14b-ef22-41fb-a2ee-2b4d98846c2d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-15T10:34:18+00:00",
        "updated_at": "2022-03-15T10:34:18+00:00",
        "number": "http://bqbl.it/d1dbd14b-ef22-41fb-a2ee-2b4d98846c2d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/780652ce6fcb30db8fcc3ce80edd4140/barcode/image/d1dbd14b-ef22-41fb-a2ee-2b4d98846c2d/47a0f4db-e9cb-4669-8452-e84cc133286c.svg",
        "owner_id": "dccde2f1-80bf-4f96-bb26-a4ffe961c50f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dccde2f1-80bf-4f96-bb26-a4ffe961c50f"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F2a9e5418-4351-4b89-a669-58ef65a1f96c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2a9e5418-4351-4b89-a669-58ef65a1f96c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-15T10:34:19+00:00",
        "updated_at": "2022-03-15T10:34:19+00:00",
        "number": "http://bqbl.it/2a9e5418-4351-4b89-a669-58ef65a1f96c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4656c2ca5efd6d7067af60db502fc6c9/barcode/image/2a9e5418-4351-4b89-a669-58ef65a1f96c/7ab177d2-59cd-4be1-bada-9a98ac3b1a08.svg",
        "owner_id": "cbba3344-a6c8-4107-9413-bd8822fba5de",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cbba3344-a6c8-4107-9413-bd8822fba5de"
          },
          "data": {
            "type": "customers",
            "id": "cbba3344-a6c8-4107-9413-bd8822fba5de"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cbba3344-a6c8-4107-9413-bd8822fba5de",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-15T10:34:19+00:00",
        "updated_at": "2022-03-15T10:34:19+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Jerde, Cruickshank and Funk",
        "email": "cruickshank.and.funk.jerde@huels-shanahan.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=cbba3344-a6c8-4107-9413-bd8822fba5de&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cbba3344-a6c8-4107-9413-bd8822fba5de&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cbba3344-a6c8-4107-9413-bd8822fba5de&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYWYyYjg1NjItYzcyMy00MWU0LTgyODktNjBhNGI2OTUxNTEz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "af2b8562-c723-41e4-8289-60a4b6951513",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-15T10:34:20+00:00",
        "updated_at": "2022-03-15T10:34:20+00:00",
        "number": "http://bqbl.it/af2b8562-c723-41e4-8289-60a4b6951513",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bf75bc4ad0315f7b1872e63218624128/barcode/image/af2b8562-c723-41e4-8289-60a4b6951513/4fa5f51e-1cf9-4218-ba71-88e0ada8c595.svg",
        "owner_id": "042bde19-3fac-4533-a90b-122504853716",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/042bde19-3fac-4533-a90b-122504853716"
          },
          "data": {
            "type": "customers",
            "id": "042bde19-3fac-4533-a90b-122504853716"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "042bde19-3fac-4533-a90b-122504853716",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-15T10:34:20+00:00",
        "updated_at": "2022-03-15T10:34:20+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Gulgowski, Brown and Braun",
        "email": "and_gulgowski_brown_braun@stracke.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=042bde19-3fac-4533-a90b-122504853716&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=042bde19-3fac-4533-a90b-122504853716&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=042bde19-3fac-4533-a90b-122504853716&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-15T10:34:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7f2146f5-4d32-4362-a062-3a47d08e340a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7f2146f5-4d32-4362-a062-3a47d08e340a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-15T10:34:20+00:00",
      "updated_at": "2022-03-15T10:34:20+00:00",
      "number": "http://bqbl.it/7f2146f5-4d32-4362-a062-3a47d08e340a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/db915f5e3d0b855cef650e82d1c595f4/barcode/image/7f2146f5-4d32-4362-a062-3a47d08e340a/e80474d5-3cd8-4d40-990f-bfad4f0b90f5.svg",
      "owner_id": "35a5e1f2-3a24-4f30-b4b1-a40ee91185b8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/35a5e1f2-3a24-4f30-b4b1-a40ee91185b8"
        },
        "data": {
          "type": "customers",
          "id": "35a5e1f2-3a24-4f30-b4b1-a40ee91185b8"
        }
      }
    }
  },
  "included": [
    {
      "id": "35a5e1f2-3a24-4f30-b4b1-a40ee91185b8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-15T10:34:20+00:00",
        "updated_at": "2022-03-15T10:34:20+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Herman, Dibbert and Buckridge",
        "email": "and.buckridge.dibbert.herman@terry-king.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=35a5e1f2-3a24-4f30-b4b1-a40ee91185b8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=35a5e1f2-3a24-4f30-b4b1-a40ee91185b8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=35a5e1f2-3a24-4f30-b4b1-a40ee91185b8&filter[owner_type]=customers"
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
          "owner_id": "be8efda7-e470-4fc5-bf22-2d181c34be16",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3e98de52-041d-4e81-8a9c-5dcbefa3b788",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-15T10:34:21+00:00",
      "updated_at": "2022-03-15T10:34:21+00:00",
      "number": "http://bqbl.it/3e98de52-041d-4e81-8a9c-5dcbefa3b788",
      "barcode_type": "qr_code",
      "image_url": "/uploads/7fd52865d116365affdd4dde2894c2f1/barcode/image/3e98de52-041d-4e81-8a9c-5dcbefa3b788/96d17aeb-de99-46fa-b052-00c078607c33.svg",
      "owner_id": "be8efda7-e470-4fc5-bf22-2d181c34be16",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ff66cfe5-66fb-4bc8-8f32-3128bd31a9e7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ff66cfe5-66fb-4bc8-8f32-3128bd31a9e7",
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
    "id": "ff66cfe5-66fb-4bc8-8f32-3128bd31a9e7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-15T10:34:21+00:00",
      "updated_at": "2022-03-15T10:34:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/02c704e946e9979aaa69554db4ba728f/barcode/image/ff66cfe5-66fb-4bc8-8f32-3128bd31a9e7/bf014caa-4f85-4f0d-9adc-7a4b401b4078.svg",
      "owner_id": "cac98a93-02d1-45f7-afee-ccef7b283ca5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c822ae15-ecdd-485d-833b-9b02f173b983' \
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