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
      "id": "534c5bed-61ef-43fe-8e9e-9c418cf74c31",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-18T07:34:14+00:00",
        "updated_at": "2022-07-18T07:34:14+00:00",
        "number": "http://bqbl.it/534c5bed-61ef-43fe-8e9e-9c418cf74c31",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f81ed54950842deb2ca99b1d1ec62198/barcode/image/534c5bed-61ef-43fe-8e9e-9c418cf74c31/cc9f40cc-a7be-47a5-9311-c367160b7372.svg",
        "owner_id": "a0942ed8-38fa-4acb-b27b-c2507f98503c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a0942ed8-38fa-4acb-b27b-c2507f98503c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd5108f5d-61ca-4fe9-adfd-6a48996a74e4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d5108f5d-61ca-4fe9-adfd-6a48996a74e4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-18T07:34:15+00:00",
        "updated_at": "2022-07-18T07:34:15+00:00",
        "number": "http://bqbl.it/d5108f5d-61ca-4fe9-adfd-6a48996a74e4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6e6daa037b21a6f8a430730c8f044215/barcode/image/d5108f5d-61ca-4fe9-adfd-6a48996a74e4/f12d852c-b463-4c43-bcdc-77ae67911283.svg",
        "owner_id": "5986e3a5-e72e-4d2c-a9e3-331fbc927331",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5986e3a5-e72e-4d2c-a9e3-331fbc927331"
          },
          "data": {
            "type": "customers",
            "id": "5986e3a5-e72e-4d2c-a9e3-331fbc927331"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5986e3a5-e72e-4d2c-a9e3-331fbc927331",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-18T07:34:15+00:00",
        "updated_at": "2022-07-18T07:34:15+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Bauch and Sons",
        "email": "sons.bauch.and@dietrich.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=5986e3a5-e72e-4d2c-a9e3-331fbc927331&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5986e3a5-e72e-4d2c-a9e3-331fbc927331&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5986e3a5-e72e-4d2c-a9e3-331fbc927331&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMTI4NmY3YzYtOTU2Ny00ZmQ4LWJhMWEtYTZkODg1MmFjZjNk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1286f7c6-9567-4fd8-ba1a-a6d8852acf3d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-18T07:34:15+00:00",
        "updated_at": "2022-07-18T07:34:15+00:00",
        "number": "http://bqbl.it/1286f7c6-9567-4fd8-ba1a-a6d8852acf3d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/414b37fe65b8a1781e54aa24bb4b1f33/barcode/image/1286f7c6-9567-4fd8-ba1a-a6d8852acf3d/b86a2439-f112-4589-89f4-5683f00ef3bb.svg",
        "owner_id": "22361500-3b5c-4da2-b801-05273775e5de",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/22361500-3b5c-4da2-b801-05273775e5de"
          },
          "data": {
            "type": "customers",
            "id": "22361500-3b5c-4da2-b801-05273775e5de"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "22361500-3b5c-4da2-b801-05273775e5de",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-18T07:34:15+00:00",
        "updated_at": "2022-07-18T07:34:15+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Lockman-Mayer",
        "email": "lockman.mayer@runte.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=22361500-3b5c-4da2-b801-05273775e5de&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=22361500-3b5c-4da2-b801-05273775e5de&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=22361500-3b5c-4da2-b801-05273775e5de&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-18T07:33:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a0f0fb1d-09f4-43d7-968f-15ecd77b7871?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a0f0fb1d-09f4-43d7-968f-15ecd77b7871",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-18T07:34:16+00:00",
      "updated_at": "2022-07-18T07:34:16+00:00",
      "number": "http://bqbl.it/a0f0fb1d-09f4-43d7-968f-15ecd77b7871",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f08362d623266395974f72c18931186c/barcode/image/a0f0fb1d-09f4-43d7-968f-15ecd77b7871/225a75e8-cef1-4614-b1bb-75654e475b4c.svg",
      "owner_id": "845d7867-1fe6-4805-9cf4-bde676900198",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/845d7867-1fe6-4805-9cf4-bde676900198"
        },
        "data": {
          "type": "customers",
          "id": "845d7867-1fe6-4805-9cf4-bde676900198"
        }
      }
    }
  },
  "included": [
    {
      "id": "845d7867-1fe6-4805-9cf4-bde676900198",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-18T07:34:16+00:00",
        "updated_at": "2022-07-18T07:34:16+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Renner Inc",
        "email": "inc_renner@funk.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=845d7867-1fe6-4805-9cf4-bde676900198&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=845d7867-1fe6-4805-9cf4-bde676900198&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=845d7867-1fe6-4805-9cf4-bde676900198&filter[owner_type]=customers"
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
          "owner_id": "03ea33db-eba7-4283-98fa-38b27f3dfca3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ea864e0e-0157-4e61-ae11-59a9f8c24806",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-18T07:34:16+00:00",
      "updated_at": "2022-07-18T07:34:16+00:00",
      "number": "http://bqbl.it/ea864e0e-0157-4e61-ae11-59a9f8c24806",
      "barcode_type": "qr_code",
      "image_url": "/uploads/60939cfb9a9ff88101577eef8d3752f6/barcode/image/ea864e0e-0157-4e61-ae11-59a9f8c24806/624fbafa-c20b-44f5-91fd-d12e3be33862.svg",
      "owner_id": "03ea33db-eba7-4283-98fa-38b27f3dfca3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9189c331-5e52-44ad-a44c-adcac2dd0a16' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9189c331-5e52-44ad-a44c-adcac2dd0a16",
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
    "id": "9189c331-5e52-44ad-a44c-adcac2dd0a16",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-18T07:34:17+00:00",
      "updated_at": "2022-07-18T07:34:17+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/05e9a83545d44f3b0382ee36979274be/barcode/image/9189c331-5e52-44ad-a44c-adcac2dd0a16/4d12ed1c-df14-4805-ac1a-d1fc4d82458b.svg",
      "owner_id": "9bd87b0d-08a5-4b45-af50-242c18ef593e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/709eb974-d9a7-4f58-95ae-53715cf3357e' \
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