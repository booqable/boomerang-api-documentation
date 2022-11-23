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
      "id": "fd46a6cd-8735-4abe-afb6-58fa59aca59a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-23T11:33:24+00:00",
        "updated_at": "2022-11-23T11:33:24+00:00",
        "number": "http://bqbl.it/fd46a6cd-8735-4abe-afb6-58fa59aca59a",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4b4542c5d9dad6b9f0ba406e81157396/barcode/image/fd46a6cd-8735-4abe-afb6-58fa59aca59a/2eaf08b1-1406-4fbd-a758-a59da90fd357.svg",
        "owner_id": "501847a9-2343-4c2c-9f27-40c7d776e8bf",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/501847a9-2343-4c2c-9f27-40c7d776e8bf"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F634569dd-5393-4267-9376-1d261a660da6&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "634569dd-5393-4267-9376-1d261a660da6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-23T11:33:24+00:00",
        "updated_at": "2022-11-23T11:33:24+00:00",
        "number": "http://bqbl.it/634569dd-5393-4267-9376-1d261a660da6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/daf7b57843d2a2a9a63e727fa9693895/barcode/image/634569dd-5393-4267-9376-1d261a660da6/659b30ab-5a36-47f0-bab5-2dfb7ae0e5ad.svg",
        "owner_id": "aae57abf-1724-45c2-a596-13c8dd26e8e3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/aae57abf-1724-45c2-a596-13c8dd26e8e3"
          },
          "data": {
            "type": "customers",
            "id": "aae57abf-1724-45c2-a596-13c8dd26e8e3"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "aae57abf-1724-45c2-a596-13c8dd26e8e3",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-23T11:33:24+00:00",
        "updated_at": "2022-11-23T11:33:24+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=aae57abf-1724-45c2-a596-13c8dd26e8e3&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=aae57abf-1724-45c2-a596-13c8dd26e8e3&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=aae57abf-1724-45c2-a596-13c8dd26e8e3&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmFjZmJjNDAtMzY5NC00ODI0LWJmZjgtNDdiYzE3M2NkOWQ1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2acfbc40-3694-4824-bff8-47bc173cd9d5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-11-23T11:33:25+00:00",
        "updated_at": "2022-11-23T11:33:25+00:00",
        "number": "http://bqbl.it/2acfbc40-3694-4824-bff8-47bc173cd9d5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/63eceea16f3ccb4157c5d3c882e84ad4/barcode/image/2acfbc40-3694-4824-bff8-47bc173cd9d5/c4dcb4ca-84fe-4b95-aec4-56f0686039e3.svg",
        "owner_id": "54260117-19b4-4fd1-a427-775035383005",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/54260117-19b4-4fd1-a427-775035383005"
          },
          "data": {
            "type": "customers",
            "id": "54260117-19b4-4fd1-a427-775035383005"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "54260117-19b4-4fd1-a427-775035383005",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-23T11:33:24+00:00",
        "updated_at": "2022-11-23T11:33:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=54260117-19b4-4fd1-a427-775035383005&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=54260117-19b4-4fd1-a427-775035383005&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=54260117-19b4-4fd1-a427-775035383005&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-23T11:33:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f2d10555-6a39-4393-bf1b-990c5faafc69?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f2d10555-6a39-4393-bf1b-990c5faafc69",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-23T11:33:25+00:00",
      "updated_at": "2022-11-23T11:33:25+00:00",
      "number": "http://bqbl.it/f2d10555-6a39-4393-bf1b-990c5faafc69",
      "barcode_type": "qr_code",
      "image_url": "/uploads/046e081735f5f5aae5c7c8a3699de954/barcode/image/f2d10555-6a39-4393-bf1b-990c5faafc69/abdaa487-9db1-409b-8777-e52adc85a09e.svg",
      "owner_id": "c5351943-fccd-4025-a2ec-6963290b7656",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c5351943-fccd-4025-a2ec-6963290b7656"
        },
        "data": {
          "type": "customers",
          "id": "c5351943-fccd-4025-a2ec-6963290b7656"
        }
      }
    }
  },
  "included": [
    {
      "id": "c5351943-fccd-4025-a2ec-6963290b7656",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-23T11:33:25+00:00",
        "updated_at": "2022-11-23T11:33:25+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c5351943-fccd-4025-a2ec-6963290b7656&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c5351943-fccd-4025-a2ec-6963290b7656&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c5351943-fccd-4025-a2ec-6963290b7656&filter[owner_type]=customers"
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
          "owner_id": "2682448c-bc4a-4b3d-b87b-0e25860ec8b0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "14bb0d89-d7f6-46fd-a60d-f39739291d96",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-23T11:33:25+00:00",
      "updated_at": "2022-11-23T11:33:25+00:00",
      "number": "http://bqbl.it/14bb0d89-d7f6-46fd-a60d-f39739291d96",
      "barcode_type": "qr_code",
      "image_url": "/uploads/73e0cbea34dec4879cab8a78dfa93947/barcode/image/14bb0d89-d7f6-46fd-a60d-f39739291d96/fa3f6f25-a0ce-4db1-97a2-0b156c291c74.svg",
      "owner_id": "2682448c-bc4a-4b3d-b87b-0e25860ec8b0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ce2b1795-3c6f-4a24-959a-73a6ca340790' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ce2b1795-3c6f-4a24-959a-73a6ca340790",
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
    "id": "ce2b1795-3c6f-4a24-959a-73a6ca340790",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-11-23T11:33:26+00:00",
      "updated_at": "2022-11-23T11:33:26+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/337599865e78451a6697192ec4d3d4e3/barcode/image/ce2b1795-3c6f-4a24-959a-73a6ca340790/be2703a3-d3c0-49c0-bb62-827641aa7f28.svg",
      "owner_id": "0ddf69d6-93e4-421f-8cf3-52e1de1ffeb0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1c828899-6609-41b6-af32-2d511e871882' \
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