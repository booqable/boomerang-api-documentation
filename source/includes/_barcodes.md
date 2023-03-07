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
`number` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`barcode_type` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`image_url` | **String** `readonly`<br>The barcode as an image
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


## Relationships
Barcodes have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


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
      "id": "b01587fb-8eee-448f-a538-0193c29f6569",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T12:09:26+00:00",
        "updated_at": "2023-03-07T12:09:26+00:00",
        "number": "http://bqbl.it/b01587fb-8eee-448f-a538-0193c29f6569",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1f977532a02c19ed048bdf4a496f87f3/barcode/image/b01587fb-8eee-448f-a538-0193c29f6569/2ea04004-0219-42de-bae3-7442e7e9aa96.svg",
        "owner_id": "fd2b7aa1-1792-4756-ac8b-f5037ea9485a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fd2b7aa1-1792-4756-ac8b-f5037ea9485a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F72f41ee4-857e-42ff-ac79-309b9a4a0d4c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "72f41ee4-857e-42ff-ac79-309b9a4a0d4c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T12:09:26+00:00",
        "updated_at": "2023-03-07T12:09:26+00:00",
        "number": "http://bqbl.it/72f41ee4-857e-42ff-ac79-309b9a4a0d4c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a193a831ac2c83bd5b1481fa2f0436f3/barcode/image/72f41ee4-857e-42ff-ac79-309b9a4a0d4c/4ed8d3a8-5d68-4b69-91d4-bde932e11335.svg",
        "owner_id": "ff9a656d-59f2-4ae8-9c47-747ec45e0be0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ff9a656d-59f2-4ae8-9c47-747ec45e0be0"
          },
          "data": {
            "type": "customers",
            "id": "ff9a656d-59f2-4ae8-9c47-747ec45e0be0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ff9a656d-59f2-4ae8-9c47-747ec45e0be0",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T12:09:26+00:00",
        "updated_at": "2023-03-07T12:09:26+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-2@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=ff9a656d-59f2-4ae8-9c47-747ec45e0be0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ff9a656d-59f2-4ae8-9c47-747ec45e0be0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ff9a656d-59f2-4ae8-9c47-747ec45e0be0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmJlMzVkMWUtYzRiOC00YmMwLThhOTYtMjRjZGVjZTg0OTcz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2be35d1e-c4b8-4bc0-8a96-24cdece84973",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-07T12:09:27+00:00",
        "updated_at": "2023-03-07T12:09:27+00:00",
        "number": "http://bqbl.it/2be35d1e-c4b8-4bc0-8a96-24cdece84973",
        "barcode_type": "qr_code",
        "image_url": "/uploads/15e2f79795ee2d435801d3ce2b15d673/barcode/image/2be35d1e-c4b8-4bc0-8a96-24cdece84973/203e8f0d-41f3-4bf8-a4a4-dfca6777770d.svg",
        "owner_id": "aa3576d0-c45d-49ce-9c49-aa2762ffc3f4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aa3576d0-c45d-49ce-9c49-aa2762ffc3f4"
          },
          "data": {
            "type": "customers",
            "id": "aa3576d0-c45d-49ce-9c49-aa2762ffc3f4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "aa3576d0-c45d-49ce-9c49-aa2762ffc3f4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T12:09:27+00:00",
        "updated_at": "2023-03-07T12:09:27+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-4@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=aa3576d0-c45d-49ce-9c49-aa2762ffc3f4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aa3576d0-c45d-49ce-9c49-aa2762ffc3f4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=aa3576d0-c45d-49ce-9c49-aa2762ffc3f4&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T12:09:04Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **String** <br>`eq`
`barcode_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/999b5506-50c8-405c-89d8-cb1fdfac720a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "999b5506-50c8-405c-89d8-cb1fdfac720a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T12:09:28+00:00",
      "updated_at": "2023-03-07T12:09:28+00:00",
      "number": "http://bqbl.it/999b5506-50c8-405c-89d8-cb1fdfac720a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/75655380ee920358a94dd3e8952953fa/barcode/image/999b5506-50c8-405c-89d8-cb1fdfac720a/003770a6-7629-4eb1-ab0e-4707e7c2b75c.svg",
      "owner_id": "7d3b717c-41b6-4507-93a6-1bf3b9920391",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7d3b717c-41b6-4507-93a6-1bf3b9920391"
        },
        "data": {
          "type": "customers",
          "id": "7d3b717c-41b6-4507-93a6-1bf3b9920391"
        }
      }
    }
  },
  "included": [
    {
      "id": "7d3b717c-41b6-4507-93a6-1bf3b9920391",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-07T12:09:27+00:00",
        "updated_at": "2023-03-07T12:09:28+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-5@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=7d3b717c-41b6-4507-93a6-1bf3b9920391&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7d3b717c-41b6-4507-93a6-1bf3b9920391&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7d3b717c-41b6-4507-93a6-1bf3b9920391&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


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
          "owner_id": "df3b7328-8499-4b7a-a5a7-c8d395f022ed",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "34af1288-b3ad-4a90-95e5-7740b311cd4f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T12:09:28+00:00",
      "updated_at": "2023-03-07T12:09:28+00:00",
      "number": "http://bqbl.it/34af1288-b3ad-4a90-95e5-7740b311cd4f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1ba7d8713a4ee0a493a7956693a7e668/barcode/image/34af1288-b3ad-4a90-95e5-7740b311cd4f/bcc37182-a5c8-451d-bf9c-1e5e2d237250.svg",
      "owner_id": "df3b7328-8499-4b7a-a5a7-c8d395f022ed",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/2fb7c11b-701e-4ba1-84fc-1c1009d60cf6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2fb7c11b-701e-4ba1-84fc-1c1009d60cf6",
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
    "id": "2fb7c11b-701e-4ba1-84fc-1c1009d60cf6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-07T12:09:29+00:00",
      "updated_at": "2023-03-07T12:09:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1c94eb1e664aa3e1bd04f23cea1d8128/barcode/image/2fb7c11b-701e-4ba1-84fc-1c1009d60cf6/50d2c8c3-412b-4206-96ed-c1598c6d26ad.svg",
      "owner_id": "13c6d961-92b8-459c-9f1b-f54856608983",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e04a5684-554a-4f95-98d5-061d8ff60f2c' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=id,created_at,updated_at`


### Includes

This request does not accept any includes