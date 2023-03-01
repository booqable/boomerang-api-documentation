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
      "id": "b78f11ce-dad5-4b4f-94bf-356c06ae85d8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T09:59:51+00:00",
        "updated_at": "2023-03-01T09:59:51+00:00",
        "number": "http://bqbl.it/b78f11ce-dad5-4b4f-94bf-356c06ae85d8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/811903b23b02a430fc00e6fb971ea639/barcode/image/b78f11ce-dad5-4b4f-94bf-356c06ae85d8/fbc0b243-10f8-4ac3-890b-06998f5024f8.svg",
        "owner_id": "24c47e23-e561-4d0d-9bca-042bc6a526ac",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/24c47e23-e561-4d0d-9bca-042bc6a526ac"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fbcf638f0-61d6-4a6e-a8be-01cd52799604&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bcf638f0-61d6-4a6e-a8be-01cd52799604",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T09:59:51+00:00",
        "updated_at": "2023-03-01T09:59:51+00:00",
        "number": "http://bqbl.it/bcf638f0-61d6-4a6e-a8be-01cd52799604",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4e2e0cd33316f43abeef567e1ad238cb/barcode/image/bcf638f0-61d6-4a6e-a8be-01cd52799604/8201e110-d96d-4aff-915e-58203815778f.svg",
        "owner_id": "1ae93177-a5c7-4449-bda9-51832ccebc2d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1ae93177-a5c7-4449-bda9-51832ccebc2d"
          },
          "data": {
            "type": "customers",
            "id": "1ae93177-a5c7-4449-bda9-51832ccebc2d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1ae93177-a5c7-4449-bda9-51832ccebc2d",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T09:59:51+00:00",
        "updated_at": "2023-03-01T09:59:51+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1ae93177-a5c7-4449-bda9-51832ccebc2d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1ae93177-a5c7-4449-bda9-51832ccebc2d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1ae93177-a5c7-4449-bda9-51832ccebc2d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDRkNTFjMzEtMWMxOC00NDkzLWEzNzAtOTQ0NDNmNDEyMTM1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "04d51c31-1c18-4493-a370-94443f412135",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-01T09:59:52+00:00",
        "updated_at": "2023-03-01T09:59:52+00:00",
        "number": "http://bqbl.it/04d51c31-1c18-4493-a370-94443f412135",
        "barcode_type": "qr_code",
        "image_url": "/uploads/423a035092931436a5d8264c9906f88b/barcode/image/04d51c31-1c18-4493-a370-94443f412135/03fe5982-18a0-4761-8230-6ac366e00dda.svg",
        "owner_id": "0e35bccb-abd1-4e32-904f-030429b518e1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0e35bccb-abd1-4e32-904f-030429b518e1"
          },
          "data": {
            "type": "customers",
            "id": "0e35bccb-abd1-4e32-904f-030429b518e1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0e35bccb-abd1-4e32-904f-030429b518e1",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T09:59:52+00:00",
        "updated_at": "2023-03-01T09:59:52+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0e35bccb-abd1-4e32-904f-030429b518e1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0e35bccb-abd1-4e32-904f-030429b518e1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0e35bccb-abd1-4e32-904f-030429b518e1&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T09:59:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/da41307a-5c40-4190-8d09-4bda982c72a3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "da41307a-5c40-4190-8d09-4bda982c72a3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T09:59:53+00:00",
      "updated_at": "2023-03-01T09:59:53+00:00",
      "number": "http://bqbl.it/da41307a-5c40-4190-8d09-4bda982c72a3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/89907b287f205316abf71ff67b837218/barcode/image/da41307a-5c40-4190-8d09-4bda982c72a3/b55f2de6-8fc8-452c-afdf-be1f72bb880e.svg",
      "owner_id": "de058289-06f7-4074-8cf4-94e311fbc041",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/de058289-06f7-4074-8cf4-94e311fbc041"
        },
        "data": {
          "type": "customers",
          "id": "de058289-06f7-4074-8cf4-94e311fbc041"
        }
      }
    }
  },
  "included": [
    {
      "id": "de058289-06f7-4074-8cf4-94e311fbc041",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-01T09:59:52+00:00",
        "updated_at": "2023-03-01T09:59:53+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=de058289-06f7-4074-8cf4-94e311fbc041&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=de058289-06f7-4074-8cf4-94e311fbc041&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=de058289-06f7-4074-8cf4-94e311fbc041&filter[owner_type]=customers"
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
          "owner_id": "5e04acde-d908-4986-bcef-e704f6404f47",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d2f8bff2-5d0e-455b-bcbf-04b112b384a8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T09:59:53+00:00",
      "updated_at": "2023-03-01T09:59:53+00:00",
      "number": "http://bqbl.it/d2f8bff2-5d0e-455b-bcbf-04b112b384a8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/3cd415d546726b5579184e61b26632fd/barcode/image/d2f8bff2-5d0e-455b-bcbf-04b112b384a8/efa50767-e2b8-40c5-9de2-729678fc9608.svg",
      "owner_id": "5e04acde-d908-4986-bcef-e704f6404f47",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/983129d2-82c7-4419-b73c-5e0af5801e06' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "983129d2-82c7-4419-b73c-5e0af5801e06",
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
    "id": "983129d2-82c7-4419-b73c-5e0af5801e06",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-01T09:59:54+00:00",
      "updated_at": "2023-03-01T09:59:54+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8edb12d82dbbaf2509178f9f049e02ea/barcode/image/983129d2-82c7-4419-b73c-5e0af5801e06/ae5e8562-d857-47a1-a15e-59604b64fc43.svg",
      "owner_id": "fb3a258e-8fbc-4b62-b04e-82468c5bdc92",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a56151ca-85a6-44c7-84a4-2e510eb351f3' \
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