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
      "id": "85859bba-c798-4ac7-919b-2e169845d5bd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T15:51:43+00:00",
        "updated_at": "2022-10-25T15:51:43+00:00",
        "number": "http://bqbl.it/85859bba-c798-4ac7-919b-2e169845d5bd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/36757dfa27cc4b1b9f62244163e5ed04/barcode/image/85859bba-c798-4ac7-919b-2e169845d5bd/0dc78585-fb3b-4f14-842a-a70572c4fd9e.svg",
        "owner_id": "8de31705-b576-4811-946f-5781dde30813",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8de31705-b576-4811-946f-5781dde30813"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F03878f70-b1f4-4219-8018-7efd351ade4c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "03878f70-b1f4-4219-8018-7efd351ade4c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T15:51:43+00:00",
        "updated_at": "2022-10-25T15:51:43+00:00",
        "number": "http://bqbl.it/03878f70-b1f4-4219-8018-7efd351ade4c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c16b07cbdc5cbf51406b2d4edb111a1b/barcode/image/03878f70-b1f4-4219-8018-7efd351ade4c/f6f6effd-ebf3-4f9c-ba01-2be61119119f.svg",
        "owner_id": "2905a05f-ab0a-4ba0-a5f2-fdf558c236ba",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2905a05f-ab0a-4ba0-a5f2-fdf558c236ba"
          },
          "data": {
            "type": "customers",
            "id": "2905a05f-ab0a-4ba0-a5f2-fdf558c236ba"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2905a05f-ab0a-4ba0-a5f2-fdf558c236ba",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T15:51:43+00:00",
        "updated_at": "2022-10-25T15:51:43+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2905a05f-ab0a-4ba0-a5f2-fdf558c236ba&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2905a05f-ab0a-4ba0-a5f2-fdf558c236ba&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2905a05f-ab0a-4ba0-a5f2-fdf558c236ba&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTg1YmVmMDctYWY0OS00YjQ3LWE5NjEtNWUzYjJmNjMyZTIz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e85bef07-af49-4b47-a961-5e3b2f632e23",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-10-25T15:51:44+00:00",
        "updated_at": "2022-10-25T15:51:44+00:00",
        "number": "http://bqbl.it/e85bef07-af49-4b47-a961-5e3b2f632e23",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1d345312014676a177eb6b149b422804/barcode/image/e85bef07-af49-4b47-a961-5e3b2f632e23/c19bc9c1-8862-4546-92ab-13b12d2eebc6.svg",
        "owner_id": "00c5b15e-a1b1-4397-bcc7-458123635a38",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/00c5b15e-a1b1-4397-bcc7-458123635a38"
          },
          "data": {
            "type": "customers",
            "id": "00c5b15e-a1b1-4397-bcc7-458123635a38"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "00c5b15e-a1b1-4397-bcc7-458123635a38",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T15:51:44+00:00",
        "updated_at": "2022-10-25T15:51:44+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=00c5b15e-a1b1-4397-bcc7-458123635a38&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=00c5b15e-a1b1-4397-bcc7-458123635a38&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=00c5b15e-a1b1-4397-bcc7-458123635a38&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T15:51:28Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ab096a1b-e434-4230-bc66-792eb72fdf39?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ab096a1b-e434-4230-bc66-792eb72fdf39",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T15:51:45+00:00",
      "updated_at": "2022-10-25T15:51:45+00:00",
      "number": "http://bqbl.it/ab096a1b-e434-4230-bc66-792eb72fdf39",
      "barcode_type": "qr_code",
      "image_url": "/uploads/2b4ac2db1b68393b2d85720805cde567/barcode/image/ab096a1b-e434-4230-bc66-792eb72fdf39/cc31b4a6-c809-4371-8667-f0045b1067ba.svg",
      "owner_id": "de8d5549-f873-4c33-bbbd-6adc158b6498",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/de8d5549-f873-4c33-bbbd-6adc158b6498"
        },
        "data": {
          "type": "customers",
          "id": "de8d5549-f873-4c33-bbbd-6adc158b6498"
        }
      }
    }
  },
  "included": [
    {
      "id": "de8d5549-f873-4c33-bbbd-6adc158b6498",
      "type": "customers",
      "attributes": {
        "created_at": "2022-10-25T15:51:44+00:00",
        "updated_at": "2022-10-25T15:51:45+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=de8d5549-f873-4c33-bbbd-6adc158b6498&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=de8d5549-f873-4c33-bbbd-6adc158b6498&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=de8d5549-f873-4c33-bbbd-6adc158b6498&filter[owner_type]=customers"
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
          "owner_id": "9533dc88-4b02-4a1c-ab46-684d05a78f19",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a9b4a8bf-16d5-4f90-97fb-a184470a6bb4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T15:51:45+00:00",
      "updated_at": "2022-10-25T15:51:45+00:00",
      "number": "http://bqbl.it/a9b4a8bf-16d5-4f90-97fb-a184470a6bb4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/81ac9ca612a22d7c409f1b5da476c30c/barcode/image/a9b4a8bf-16d5-4f90-97fb-a184470a6bb4/b57509ec-8703-415b-9a36-96f63dee25aa.svg",
      "owner_id": "9533dc88-4b02-4a1c-ab46-684d05a78f19",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7f5ccae3-3abc-4aa7-ba26-a957b921cca5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7f5ccae3-3abc-4aa7-ba26-a957b921cca5",
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
    "id": "7f5ccae3-3abc-4aa7-ba26-a957b921cca5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-10-25T15:51:45+00:00",
      "updated_at": "2022-10-25T15:51:46+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/0a95df7489064e12f95a482328c2a76f/barcode/image/7f5ccae3-3abc-4aa7-ba26-a957b921cca5/80a476e7-48a0-4e68-b63b-32fcc28bc21b.svg",
      "owner_id": "5770c84d-c829-4794-8793-09d5941e2edf",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/806c7b7c-6c66-4f6f-a30f-2e6ec21d3369' \
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