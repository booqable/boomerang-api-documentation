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
      "id": "83524818-389d-4e8f-9508-d7da53f9a21c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-23T12:50:24+00:00",
        "updated_at": "2022-06-23T12:50:24+00:00",
        "number": "http://bqbl.it/83524818-389d-4e8f-9508-d7da53f9a21c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e9f1f04ee27ab779cf22c1ae5347a657/barcode/image/83524818-389d-4e8f-9508-d7da53f9a21c/31f9781c-e8eb-45b8-b98f-7dc3b1919d33.svg",
        "owner_id": "40bda55e-b93e-4181-9afc-7ca35fa762d2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/40bda55e-b93e-4181-9afc-7ca35fa762d2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1b64bdec-ebfc-42e7-ba8b-b10023848d6e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1b64bdec-ebfc-42e7-ba8b-b10023848d6e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-23T12:50:24+00:00",
        "updated_at": "2022-06-23T12:50:24+00:00",
        "number": "http://bqbl.it/1b64bdec-ebfc-42e7-ba8b-b10023848d6e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/317d9745f3ff7b6f23d242d38988661c/barcode/image/1b64bdec-ebfc-42e7-ba8b-b10023848d6e/f31f54fd-c8e6-410c-aed1-a6323cf71f4b.svg",
        "owner_id": "f7f82b2a-7ec0-4898-85a8-9f848c4a5fca",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f7f82b2a-7ec0-4898-85a8-9f848c4a5fca"
          },
          "data": {
            "type": "customers",
            "id": "f7f82b2a-7ec0-4898-85a8-9f848c4a5fca"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f7f82b2a-7ec0-4898-85a8-9f848c4a5fca",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-23T12:50:24+00:00",
        "updated_at": "2022-06-23T12:50:24+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Rogahn-Lockman",
        "email": "lockman.rogahn@stanton.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=f7f82b2a-7ec0-4898-85a8-9f848c4a5fca&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f7f82b2a-7ec0-4898-85a8-9f848c4a5fca&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f7f82b2a-7ec0-4898-85a8-9f848c4a5fca&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTNlYzRmMTgtOTE4NS00MzY5LTlmNTctOWVlMWM2YWM4M2Iy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "53ec4f18-9185-4369-9f57-9ee1c6ac83b2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-23T12:50:25+00:00",
        "updated_at": "2022-06-23T12:50:25+00:00",
        "number": "http://bqbl.it/53ec4f18-9185-4369-9f57-9ee1c6ac83b2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6bb6e420d235e7d6b737c85dba083efe/barcode/image/53ec4f18-9185-4369-9f57-9ee1c6ac83b2/3c7b6995-7ec6-4996-92f1-2a84bcabc25f.svg",
        "owner_id": "e766120f-b2d1-4ad9-9c57-5b264931cf9a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e766120f-b2d1-4ad9-9c57-5b264931cf9a"
          },
          "data": {
            "type": "customers",
            "id": "e766120f-b2d1-4ad9-9c57-5b264931cf9a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e766120f-b2d1-4ad9-9c57-5b264931cf9a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-23T12:50:25+00:00",
        "updated_at": "2022-06-23T12:50:25+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Simonis-Effertz",
        "email": "effertz.simonis@daugherty-cole.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=e766120f-b2d1-4ad9-9c57-5b264931cf9a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e766120f-b2d1-4ad9-9c57-5b264931cf9a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e766120f-b2d1-4ad9-9c57-5b264931cf9a&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T12:50:09Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e3b662fc-0432-473c-b75a-9a4f8720e034?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e3b662fc-0432-473c-b75a-9a4f8720e034",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-23T12:50:25+00:00",
      "updated_at": "2022-06-23T12:50:25+00:00",
      "number": "http://bqbl.it/e3b662fc-0432-473c-b75a-9a4f8720e034",
      "barcode_type": "qr_code",
      "image_url": "/uploads/06ed71c439505af2e36fcba07ad12de6/barcode/image/e3b662fc-0432-473c-b75a-9a4f8720e034/f31688d8-4267-481a-b922-d6feceb417fd.svg",
      "owner_id": "6ab2987e-f51f-49e9-b920-274cfe036a9a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6ab2987e-f51f-49e9-b920-274cfe036a9a"
        },
        "data": {
          "type": "customers",
          "id": "6ab2987e-f51f-49e9-b920-274cfe036a9a"
        }
      }
    }
  },
  "included": [
    {
      "id": "6ab2987e-f51f-49e9-b920-274cfe036a9a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-23T12:50:25+00:00",
        "updated_at": "2022-06-23T12:50:25+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Rau Inc",
        "email": "rau_inc@denesik.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=6ab2987e-f51f-49e9-b920-274cfe036a9a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6ab2987e-f51f-49e9-b920-274cfe036a9a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6ab2987e-f51f-49e9-b920-274cfe036a9a&filter[owner_type]=customers"
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
          "owner_id": "2934b565-7ab9-4065-820a-1357befd5add",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cba43b96-d2f3-4046-9a79-3dc4da8aa56e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-23T12:50:26+00:00",
      "updated_at": "2022-06-23T12:50:26+00:00",
      "number": "http://bqbl.it/cba43b96-d2f3-4046-9a79-3dc4da8aa56e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c24deef195550b681eb3d063978dad59/barcode/image/cba43b96-d2f3-4046-9a79-3dc4da8aa56e/985506a2-9910-4a64-9ace-5556d3189552.svg",
      "owner_id": "2934b565-7ab9-4065-820a-1357befd5add",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1f13ba87-2f2c-493e-819d-8e7c9143ea0a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1f13ba87-2f2c-493e-819d-8e7c9143ea0a",
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
    "id": "1f13ba87-2f2c-493e-819d-8e7c9143ea0a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-23T12:50:26+00:00",
      "updated_at": "2022-06-23T12:50:26+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8902b5e33fd3df026fc5a8797341d845/barcode/image/1f13ba87-2f2c-493e-819d-8e7c9143ea0a/c463c063-029e-47b2-a04b-eee0bd7438d5.svg",
      "owner_id": "5584b312-ccac-44e8-bd23-b9bb40e7a79d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ce2273e8-8457-470b-9661-7d13f0779466' \
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