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
      "id": "25776419-eaac-4482-b587-2a3934f65fe8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-16T19:29:43+00:00",
        "updated_at": "2022-06-16T19:29:43+00:00",
        "number": "http://bqbl.it/25776419-eaac-4482-b587-2a3934f65fe8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/246911956a3aa20ba37295d7ee519e04/barcode/image/25776419-eaac-4482-b587-2a3934f65fe8/c5bf8871-49b2-4871-949e-e6cfabb3c612.svg",
        "owner_id": "0fcef145-bc21-40ad-bba2-c7ab76fdfec9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0fcef145-bc21-40ad-bba2-c7ab76fdfec9"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F81a6136a-baa0-4732-a5ad-47aeb4d738ab&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "81a6136a-baa0-4732-a5ad-47aeb4d738ab",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-16T19:29:43+00:00",
        "updated_at": "2022-06-16T19:29:43+00:00",
        "number": "http://bqbl.it/81a6136a-baa0-4732-a5ad-47aeb4d738ab",
        "barcode_type": "qr_code",
        "image_url": "/uploads/220fd90d85c0a84a64bbfd49b9ab2a2f/barcode/image/81a6136a-baa0-4732-a5ad-47aeb4d738ab/69d00433-0040-41cc-8a66-75b0e7c4ec77.svg",
        "owner_id": "7b98ef97-e49c-4b6e-9ba8-527a0269cb2c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7b98ef97-e49c-4b6e-9ba8-527a0269cb2c"
          },
          "data": {
            "type": "customers",
            "id": "7b98ef97-e49c-4b6e-9ba8-527a0269cb2c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7b98ef97-e49c-4b6e-9ba8-527a0269cb2c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-16T19:29:43+00:00",
        "updated_at": "2022-06-16T19:29:43+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Keeling, Koepp and Runolfsdottir",
        "email": "runolfsdottir.koepp.keeling.and@pfannerstill.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=7b98ef97-e49c-4b6e-9ba8-527a0269cb2c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7b98ef97-e49c-4b6e-9ba8-527a0269cb2c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7b98ef97-e49c-4b6e-9ba8-527a0269cb2c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvOGYxYTIyNzQtYzhlYi00MTMyLTk3NTMtN2NiNmVmNmVjMjRl&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8f1a2274-c8eb-4132-9753-7cb6ef6ec24e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-16T19:29:44+00:00",
        "updated_at": "2022-06-16T19:29:44+00:00",
        "number": "http://bqbl.it/8f1a2274-c8eb-4132-9753-7cb6ef6ec24e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1b9b8ae89d1c03bc862a57efea159fe4/barcode/image/8f1a2274-c8eb-4132-9753-7cb6ef6ec24e/a1fd1af5-e903-4e11-9367-402845f3b24b.svg",
        "owner_id": "c274c68b-0708-49f6-9b0c-ced2761966c7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c274c68b-0708-49f6-9b0c-ced2761966c7"
          },
          "data": {
            "type": "customers",
            "id": "c274c68b-0708-49f6-9b0c-ced2761966c7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c274c68b-0708-49f6-9b0c-ced2761966c7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-16T19:29:44+00:00",
        "updated_at": "2022-06-16T19:29:44+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Littel-McCullough",
        "email": "mccullough_littel@murazik.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=c274c68b-0708-49f6-9b0c-ced2761966c7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c274c68b-0708-49f6-9b0c-ced2761966c7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c274c68b-0708-49f6-9b0c-ced2761966c7&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-16T19:29:29Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/733765fc-38d3-40b4-8bce-ebd3b20e413d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "733765fc-38d3-40b4-8bce-ebd3b20e413d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-16T19:29:44+00:00",
      "updated_at": "2022-06-16T19:29:44+00:00",
      "number": "http://bqbl.it/733765fc-38d3-40b4-8bce-ebd3b20e413d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ecf8c707979c874672d69b5078a30925/barcode/image/733765fc-38d3-40b4-8bce-ebd3b20e413d/85a4dc6b-20dc-4b61-850e-3f15bde2cf7d.svg",
      "owner_id": "324037ac-82be-4354-b9e6-b7792c9172a8",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/324037ac-82be-4354-b9e6-b7792c9172a8"
        },
        "data": {
          "type": "customers",
          "id": "324037ac-82be-4354-b9e6-b7792c9172a8"
        }
      }
    }
  },
  "included": [
    {
      "id": "324037ac-82be-4354-b9e6-b7792c9172a8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-16T19:29:44+00:00",
        "updated_at": "2022-06-16T19:29:44+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Sawayn-Crist",
        "email": "crist.sawayn@ziemann-nader.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=324037ac-82be-4354-b9e6-b7792c9172a8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=324037ac-82be-4354-b9e6-b7792c9172a8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=324037ac-82be-4354-b9e6-b7792c9172a8&filter[owner_type]=customers"
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
          "owner_id": "eb3d3000-cd1e-4c9b-b68d-851cf1986fd1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c6c3aefc-0628-4dc0-b9b7-63438006ed22",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-16T19:29:46+00:00",
      "updated_at": "2022-06-16T19:29:46+00:00",
      "number": "http://bqbl.it/c6c3aefc-0628-4dc0-b9b7-63438006ed22",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b74f5f4b281b633bfbd9084f75710bf1/barcode/image/c6c3aefc-0628-4dc0-b9b7-63438006ed22/64838b7f-38f5-453d-97aa-930808e438b4.svg",
      "owner_id": "eb3d3000-cd1e-4c9b-b68d-851cf1986fd1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e2a0097e-21b7-4a57-9cff-354e417afd5b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e2a0097e-21b7-4a57-9cff-354e417afd5b",
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
    "id": "e2a0097e-21b7-4a57-9cff-354e417afd5b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-16T19:29:47+00:00",
      "updated_at": "2022-06-16T19:29:47+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/98456f973bd438d286f03258cb908414/barcode/image/e2a0097e-21b7-4a57-9cff-354e417afd5b/c4df22dd-8990-4e25-a20f-aecb5778d656.svg",
      "owner_id": "4ea7fcd5-54ca-47e5-b1d6-6282e53a0efc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/39209644-a4bf-4097-8164-bc64685e8171' \
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