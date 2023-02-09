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
      "id": "260e30ef-ffdf-4952-b45f-5c8226f8787e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T12:59:27+00:00",
        "updated_at": "2023-02-09T12:59:27+00:00",
        "number": "http://bqbl.it/260e30ef-ffdf-4952-b45f-5c8226f8787e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9a3ccaf922bb63d5e8832822b673b0e6/barcode/image/260e30ef-ffdf-4952-b45f-5c8226f8787e/e386846d-5f7f-4399-99f0-59c67d42bd73.svg",
        "owner_id": "ce6338ce-35c9-4fbb-8ddf-7c5505d19237",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ce6338ce-35c9-4fbb-8ddf-7c5505d19237"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F1494d7fe-bb20-4b18-b60c-9aa92ac4c62c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1494d7fe-bb20-4b18-b60c-9aa92ac4c62c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T12:59:27+00:00",
        "updated_at": "2023-02-09T12:59:27+00:00",
        "number": "http://bqbl.it/1494d7fe-bb20-4b18-b60c-9aa92ac4c62c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9dd5dee88d81255c04f8ce0b0dab3f92/barcode/image/1494d7fe-bb20-4b18-b60c-9aa92ac4c62c/ada68c1d-ef5c-49fe-897f-26a1f0ce8dbc.svg",
        "owner_id": "368f2588-eb5d-4362-b425-e16f59f5f1ec",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/368f2588-eb5d-4362-b425-e16f59f5f1ec"
          },
          "data": {
            "type": "customers",
            "id": "368f2588-eb5d-4362-b425-e16f59f5f1ec"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "368f2588-eb5d-4362-b425-e16f59f5f1ec",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T12:59:27+00:00",
        "updated_at": "2023-02-09T12:59:27+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=368f2588-eb5d-4362-b425-e16f59f5f1ec&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=368f2588-eb5d-4362-b425-e16f59f5f1ec&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=368f2588-eb5d-4362-b425-e16f59f5f1ec&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMjY5ZDE3ZTMtOTJkZS00MDBlLTgyMTctODI1NWMwYzFkYjYy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "269d17e3-92de-400e-8217-8255c0c1db62",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T12:59:28+00:00",
        "updated_at": "2023-02-09T12:59:28+00:00",
        "number": "http://bqbl.it/269d17e3-92de-400e-8217-8255c0c1db62",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9e2934a0bc674c6bb5e22ee358275247/barcode/image/269d17e3-92de-400e-8217-8255c0c1db62/5c8da7ae-20f2-49aa-98b8-7c9fafdc0554.svg",
        "owner_id": "776c06b9-62a8-4a85-aef9-d188d85df2da",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/776c06b9-62a8-4a85-aef9-d188d85df2da"
          },
          "data": {
            "type": "customers",
            "id": "776c06b9-62a8-4a85-aef9-d188d85df2da"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "776c06b9-62a8-4a85-aef9-d188d85df2da",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T12:59:28+00:00",
        "updated_at": "2023-02-09T12:59:28+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=776c06b9-62a8-4a85-aef9-d188d85df2da&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=776c06b9-62a8-4a85-aef9-d188d85df2da&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=776c06b9-62a8-4a85-aef9-d188d85df2da&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T12:59:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f6ae58db-3660-478d-aab4-4731146431d4?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f6ae58db-3660-478d-aab4-4731146431d4",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T12:59:28+00:00",
      "updated_at": "2023-02-09T12:59:28+00:00",
      "number": "http://bqbl.it/f6ae58db-3660-478d-aab4-4731146431d4",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8319c995399cfbdc716aa70b9421120a/barcode/image/f6ae58db-3660-478d-aab4-4731146431d4/53f2a542-4595-4fcb-9bae-7b64777ac306.svg",
      "owner_id": "9b11969f-6619-470f-8e09-af1fee073337",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9b11969f-6619-470f-8e09-af1fee073337"
        },
        "data": {
          "type": "customers",
          "id": "9b11969f-6619-470f-8e09-af1fee073337"
        }
      }
    }
  },
  "included": [
    {
      "id": "9b11969f-6619-470f-8e09-af1fee073337",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T12:59:28+00:00",
        "updated_at": "2023-02-09T12:59:28+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9b11969f-6619-470f-8e09-af1fee073337&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9b11969f-6619-470f-8e09-af1fee073337&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9b11969f-6619-470f-8e09-af1fee073337&filter[owner_type]=customers"
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
          "owner_id": "ad13a1f7-d2a9-4f26-a167-9240510457a7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "71ab57b5-ae40-49f3-a417-1b71156ecc9e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T12:59:29+00:00",
      "updated_at": "2023-02-09T12:59:29+00:00",
      "number": "http://bqbl.it/71ab57b5-ae40-49f3-a417-1b71156ecc9e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5b694229ead185aed969a46ba922467c/barcode/image/71ab57b5-ae40-49f3-a417-1b71156ecc9e/36d2b33c-1ffe-4276-8a3f-6155bf25bbc3.svg",
      "owner_id": "ad13a1f7-d2a9-4f26-a167-9240510457a7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9bd9baf6-384f-4150-a845-57097bcd4c73' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9bd9baf6-384f-4150-a845-57097bcd4c73",
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
    "id": "9bd9baf6-384f-4150-a845-57097bcd4c73",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T12:59:29+00:00",
      "updated_at": "2023-02-09T12:59:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/5d37f5fbeb8dbf522c80130c9a120762/barcode/image/9bd9baf6-384f-4150-a845-57097bcd4c73/79a2fb5f-23bc-4f8d-8234-b47ad87c7127.svg",
      "owner_id": "22a230b6-e72e-4500-b0a8-a66ecaa81e08",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5a4d12ad-7a49-4dac-b676-9087d23a1d4b' \
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