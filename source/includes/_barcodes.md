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
      "id": "4140a6f6-cc08-4cb3-a7a2-19b718345677",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T14:49:59+00:00",
        "updated_at": "2023-02-07T14:49:59+00:00",
        "number": "http://bqbl.it/4140a6f6-cc08-4cb3-a7a2-19b718345677",
        "barcode_type": "qr_code",
        "image_url": "/uploads/80c94b1a88f6ddab9c358d71b3387d68/barcode/image/4140a6f6-cc08-4cb3-a7a2-19b718345677/e105183b-2291-4854-ba6c-c81d4c27d810.svg",
        "owner_id": "30700189-5760-411b-b8c0-5e8247118554",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/30700189-5760-411b-b8c0-5e8247118554"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F51e45a9e-9287-4f62-b926-17558555b037&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "51e45a9e-9287-4f62-b926-17558555b037",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T14:49:59+00:00",
        "updated_at": "2023-02-07T14:49:59+00:00",
        "number": "http://bqbl.it/51e45a9e-9287-4f62-b926-17558555b037",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f847e8efd0160ef99c4746574b18a225/barcode/image/51e45a9e-9287-4f62-b926-17558555b037/ec3fcddf-5798-46d1-8a81-96d02839e34b.svg",
        "owner_id": "c45ca29d-33c6-4219-b5d2-25991ded62e7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c45ca29d-33c6-4219-b5d2-25991ded62e7"
          },
          "data": {
            "type": "customers",
            "id": "c45ca29d-33c6-4219-b5d2-25991ded62e7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c45ca29d-33c6-4219-b5d2-25991ded62e7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T14:49:59+00:00",
        "updated_at": "2023-02-07T14:49:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=c45ca29d-33c6-4219-b5d2-25991ded62e7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c45ca29d-33c6-4219-b5d2-25991ded62e7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c45ca29d-33c6-4219-b5d2-25991ded62e7&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODNhODM0YWItM2UzZi00Yzk5LWE2MzktOTU3NzdmM2ZlZTUx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "83a834ab-3e3f-4c99-a639-95777f3fee51",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T14:50:00+00:00",
        "updated_at": "2023-02-07T14:50:00+00:00",
        "number": "http://bqbl.it/83a834ab-3e3f-4c99-a639-95777f3fee51",
        "barcode_type": "qr_code",
        "image_url": "/uploads/5c608a2e4306f9c1811b7144c5f8df02/barcode/image/83a834ab-3e3f-4c99-a639-95777f3fee51/4b041d7a-d3a4-412f-a4f6-9e9fb26a9147.svg",
        "owner_id": "4ea84e20-de05-4b4c-aada-c068d1cb5670",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4ea84e20-de05-4b4c-aada-c068d1cb5670"
          },
          "data": {
            "type": "customers",
            "id": "4ea84e20-de05-4b4c-aada-c068d1cb5670"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4ea84e20-de05-4b4c-aada-c068d1cb5670",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T14:50:00+00:00",
        "updated_at": "2023-02-07T14:50:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4ea84e20-de05-4b4c-aada-c068d1cb5670&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4ea84e20-de05-4b4c-aada-c068d1cb5670&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4ea84e20-de05-4b4c-aada-c068d1cb5670&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:49:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/318f0b87-e9ef-4fa0-a56d-ee8f27d08f46?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "318f0b87-e9ef-4fa0-a56d-ee8f27d08f46",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T14:50:00+00:00",
      "updated_at": "2023-02-07T14:50:00+00:00",
      "number": "http://bqbl.it/318f0b87-e9ef-4fa0-a56d-ee8f27d08f46",
      "barcode_type": "qr_code",
      "image_url": "/uploads/20e72c1500293dbfd2e6c7494cf3b648/barcode/image/318f0b87-e9ef-4fa0-a56d-ee8f27d08f46/5984e9ac-4852-4c0a-a4d4-f32662be4bfa.svg",
      "owner_id": "05b0c0cf-dcbe-4689-a890-9501f4350823",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/05b0c0cf-dcbe-4689-a890-9501f4350823"
        },
        "data": {
          "type": "customers",
          "id": "05b0c0cf-dcbe-4689-a890-9501f4350823"
        }
      }
    }
  },
  "included": [
    {
      "id": "05b0c0cf-dcbe-4689-a890-9501f4350823",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T14:50:00+00:00",
        "updated_at": "2023-02-07T14:50:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=05b0c0cf-dcbe-4689-a890-9501f4350823&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=05b0c0cf-dcbe-4689-a890-9501f4350823&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=05b0c0cf-dcbe-4689-a890-9501f4350823&filter[owner_type]=customers"
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
          "owner_id": "30a5ee52-eb8e-46c7-bc86-59434d6b29f6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "185fd5e9-1d55-49c7-9087-b7241b80d28b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T14:50:01+00:00",
      "updated_at": "2023-02-07T14:50:01+00:00",
      "number": "http://bqbl.it/185fd5e9-1d55-49c7-9087-b7241b80d28b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b85400065862c6347f6d97c20b7883e4/barcode/image/185fd5e9-1d55-49c7-9087-b7241b80d28b/5b820b0e-c462-4855-9050-1d79aea702cd.svg",
      "owner_id": "30a5ee52-eb8e-46c7-bc86-59434d6b29f6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d61de466-2d46-4ea4-bee7-f478e5bfffca' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d61de466-2d46-4ea4-bee7-f478e5bfffca",
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
    "id": "d61de466-2d46-4ea4-bee7-f478e5bfffca",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T14:50:01+00:00",
      "updated_at": "2023-02-07T14:50:02+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9800784ba763669c034566e6f088918b/barcode/image/d61de466-2d46-4ea4-bee7-f478e5bfffca/36f9c7b4-6317-42e9-b301-7a9c9f662f83.svg",
      "owner_id": "34b7f56a-87e9-4775-afe2-dd678f1939dd",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b3f0ef9f-341f-4694-a6ff-e4547aed08aa' \
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