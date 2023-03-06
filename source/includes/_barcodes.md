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
      "id": "7b3f4522-1f64-4ffb-b2e2-62901abc8c60",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-06T08:22:35+00:00",
        "updated_at": "2023-03-06T08:22:35+00:00",
        "number": "http://bqbl.it/7b3f4522-1f64-4ffb-b2e2-62901abc8c60",
        "barcode_type": "qr_code",
        "image_url": "/uploads/62a5226c61732167c8425aace840e0e3/barcode/image/7b3f4522-1f64-4ffb-b2e2-62901abc8c60/29b9d5ce-b464-4cbe-82b9-f4fad7bc9f15.svg",
        "owner_id": "c2bb6645-eeda-4819-8765-32d4bea11c72",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c2bb6645-eeda-4819-8765-32d4bea11c72"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F29aeac74-4c42-4eae-bbab-b61ba728270f&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "29aeac74-4c42-4eae-bbab-b61ba728270f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-06T08:22:36+00:00",
        "updated_at": "2023-03-06T08:22:36+00:00",
        "number": "http://bqbl.it/29aeac74-4c42-4eae-bbab-b61ba728270f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/92c54d67c42ee58e3fd7982bfb21ff5a/barcode/image/29aeac74-4c42-4eae-bbab-b61ba728270f/d578cd15-4981-48e3-ab32-905e66fed0a4.svg",
        "owner_id": "a9d6a0a1-80c8-4d83-bb3c-82c007d4048c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a9d6a0a1-80c8-4d83-bb3c-82c007d4048c"
          },
          "data": {
            "type": "customers",
            "id": "a9d6a0a1-80c8-4d83-bb3c-82c007d4048c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a9d6a0a1-80c8-4d83-bb3c-82c007d4048c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-06T08:22:35+00:00",
        "updated_at": "2023-03-06T08:22:36+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=a9d6a0a1-80c8-4d83-bb3c-82c007d4048c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a9d6a0a1-80c8-4d83-bb3c-82c007d4048c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a9d6a0a1-80c8-4d83-bb3c-82c007d4048c&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDgwZDc1OTQtNTg0YS00YjFmLWFkMDEtM2E2ZWM4MWI5NTEw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d80d7594-584a-4b1f-ad01-3a6ec81b9510",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-03-06T08:22:36+00:00",
        "updated_at": "2023-03-06T08:22:36+00:00",
        "number": "http://bqbl.it/d80d7594-584a-4b1f-ad01-3a6ec81b9510",
        "barcode_type": "qr_code",
        "image_url": "/uploads/de054308a4118520baa09e7cbdb831c0/barcode/image/d80d7594-584a-4b1f-ad01-3a6ec81b9510/1373169d-1e3d-4ab2-9005-7a1d5c61ed8d.svg",
        "owner_id": "0f088210-b590-40b6-8b45-2dbb1090e38e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0f088210-b590-40b6-8b45-2dbb1090e38e"
          },
          "data": {
            "type": "customers",
            "id": "0f088210-b590-40b6-8b45-2dbb1090e38e"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0f088210-b590-40b6-8b45-2dbb1090e38e",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-06T08:22:36+00:00",
        "updated_at": "2023-03-06T08:22:36+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=0f088210-b590-40b6-8b45-2dbb1090e38e&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0f088210-b590-40b6-8b45-2dbb1090e38e&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0f088210-b590-40b6-8b45-2dbb1090e38e&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-06T08:22:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/abf225c1-6b81-4c02-b462-f1db8167df0d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "abf225c1-6b81-4c02-b462-f1db8167df0d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-06T08:22:36+00:00",
      "updated_at": "2023-03-06T08:22:36+00:00",
      "number": "http://bqbl.it/abf225c1-6b81-4c02-b462-f1db8167df0d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f0a139e9a36c13e4304fb56b41b1a044/barcode/image/abf225c1-6b81-4c02-b462-f1db8167df0d/2d916449-920a-4e34-b47d-556c63f02d3f.svg",
      "owner_id": "ea5ba368-7c09-46dc-9171-ca27bc18b9f4",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ea5ba368-7c09-46dc-9171-ca27bc18b9f4"
        },
        "data": {
          "type": "customers",
          "id": "ea5ba368-7c09-46dc-9171-ca27bc18b9f4"
        }
      }
    }
  },
  "included": [
    {
      "id": "ea5ba368-7c09-46dc-9171-ca27bc18b9f4",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-06T08:22:36+00:00",
        "updated_at": "2023-03-06T08:22:36+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ea5ba368-7c09-46dc-9171-ca27bc18b9f4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ea5ba368-7c09-46dc-9171-ca27bc18b9f4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ea5ba368-7c09-46dc-9171-ca27bc18b9f4&filter[owner_type]=customers"
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
          "owner_id": "ec46fe91-b0d4-4378-9096-d92893732306",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "037db897-c679-4a45-ac13-5179028c7fd0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-06T08:22:37+00:00",
      "updated_at": "2023-03-06T08:22:37+00:00",
      "number": "http://bqbl.it/037db897-c679-4a45-ac13-5179028c7fd0",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d7f3bf63b57c6b72b6c159a24a9c9f89/barcode/image/037db897-c679-4a45-ac13-5179028c7fd0/76f20079-6e27-40cb-8234-22045a9f1a63.svg",
      "owner_id": "ec46fe91-b0d4-4378-9096-d92893732306",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/cfc9fffc-b90c-4ef5-b520-b7ad6d6eedc6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cfc9fffc-b90c-4ef5-b520-b7ad6d6eedc6",
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
    "id": "cfc9fffc-b90c-4ef5-b520-b7ad6d6eedc6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-03-06T08:22:37+00:00",
      "updated_at": "2023-03-06T08:22:37+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/72695ede46dd4357b0f7f5563ba2c11a/barcode/image/cfc9fffc-b90c-4ef5-b520-b7ad6d6eedc6/a2b5e394-c405-4c38-996d-f49be5be476e.svg",
      "owner_id": "8d9ff87d-05bb-42db-953e-a76e60594348",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/81f2015a-e2e3-44fa-b648-f3a18ef7877e' \
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