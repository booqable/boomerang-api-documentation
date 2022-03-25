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
      "id": "902de912-166d-45ac-a040-cbfc215e853d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-25T08:52:30+00:00",
        "updated_at": "2022-03-25T08:52:30+00:00",
        "number": "http://bqbl.it/902de912-166d-45ac-a040-cbfc215e853d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/726949370e1cf620046e82fdf56806b8/barcode/image/902de912-166d-45ac-a040-cbfc215e853d/918c3650-9944-41e1-9c50-57c62d912b63.svg",
        "owner_id": "12122a74-053c-4b7c-888f-a464d28eb549",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/12122a74-053c-4b7c-888f-a464d28eb549"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F51266b2a-153f-470e-9d6e-6c9f8f2b41c7&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "51266b2a-153f-470e-9d6e-6c9f8f2b41c7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-25T08:52:31+00:00",
        "updated_at": "2022-03-25T08:52:31+00:00",
        "number": "http://bqbl.it/51266b2a-153f-470e-9d6e-6c9f8f2b41c7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1c0843189349704148a541cbc975906d/barcode/image/51266b2a-153f-470e-9d6e-6c9f8f2b41c7/8f62838d-2e89-4329-9acb-46a7b8650aa9.svg",
        "owner_id": "dd4c4b98-3e2c-4720-a521-3d0bcae110d5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dd4c4b98-3e2c-4720-a521-3d0bcae110d5"
          },
          "data": {
            "type": "customers",
            "id": "dd4c4b98-3e2c-4720-a521-3d0bcae110d5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "dd4c4b98-3e2c-4720-a521-3d0bcae110d5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-25T08:52:31+00:00",
        "updated_at": "2022-03-25T08:52:31+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Abernathy-Gerhold",
        "email": "gerhold_abernathy@zulauf.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=dd4c4b98-3e2c-4720-a521-3d0bcae110d5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=dd4c4b98-3e2c-4720-a521-3d0bcae110d5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=dd4c4b98-3e2c-4720-a521-3d0bcae110d5&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYjRiMjE5NDEtMmY4OC00NmQ0LWEyOGMtMWNlNjdhZGYwMWE1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b4b21941-2f88-46d4-a28c-1ce67adf01a5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-25T08:52:31+00:00",
        "updated_at": "2022-03-25T08:52:31+00:00",
        "number": "http://bqbl.it/b4b21941-2f88-46d4-a28c-1ce67adf01a5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6394ef10cc3b671e8d12187ab0b68051/barcode/image/b4b21941-2f88-46d4-a28c-1ce67adf01a5/b9ecb2fe-49a9-4486-8844-6486fc4e8bca.svg",
        "owner_id": "d6b6fea2-d893-47f7-a43c-b8ec7367ae76",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d6b6fea2-d893-47f7-a43c-b8ec7367ae76"
          },
          "data": {
            "type": "customers",
            "id": "d6b6fea2-d893-47f7-a43c-b8ec7367ae76"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d6b6fea2-d893-47f7-a43c-b8ec7367ae76",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-25T08:52:31+00:00",
        "updated_at": "2022-03-25T08:52:31+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Flatley, Stroman and Boyer",
        "email": "stroman.and.flatley.boyer@schiller-blanda.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=d6b6fea2-d893-47f7-a43c-b8ec7367ae76&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d6b6fea2-d893-47f7-a43c-b8ec7367ae76&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d6b6fea2-d893-47f7-a43c-b8ec7367ae76&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-25T08:52:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/844dcef5-bc0a-49af-9681-0949bd36ec03?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "844dcef5-bc0a-49af-9681-0949bd36ec03",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-25T08:52:32+00:00",
      "updated_at": "2022-03-25T08:52:32+00:00",
      "number": "http://bqbl.it/844dcef5-bc0a-49af-9681-0949bd36ec03",
      "barcode_type": "qr_code",
      "image_url": "/uploads/af69fee0074675947a2eaceb72eec6b5/barcode/image/844dcef5-bc0a-49af-9681-0949bd36ec03/cef08b72-ca85-46d6-9636-c3b204d78632.svg",
      "owner_id": "f93a0c3c-03ba-4711-b61d-b0f8e8ff5a6a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f93a0c3c-03ba-4711-b61d-b0f8e8ff5a6a"
        },
        "data": {
          "type": "customers",
          "id": "f93a0c3c-03ba-4711-b61d-b0f8e8ff5a6a"
        }
      }
    }
  },
  "included": [
    {
      "id": "f93a0c3c-03ba-4711-b61d-b0f8e8ff5a6a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-25T08:52:32+00:00",
        "updated_at": "2022-03-25T08:52:32+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Bruen, Steuber and Volkman",
        "email": "volkman_and_bruen_steuber@lubowitz-connelly.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=f93a0c3c-03ba-4711-b61d-b0f8e8ff5a6a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f93a0c3c-03ba-4711-b61d-b0f8e8ff5a6a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f93a0c3c-03ba-4711-b61d-b0f8e8ff5a6a&filter[owner_type]=customers"
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
          "owner_id": "67ec9d23-09ef-48a3-b548-12e13bce08e0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e640631e-13ee-4f92-8aa9-61796f66e2cc",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-25T08:52:32+00:00",
      "updated_at": "2022-03-25T08:52:32+00:00",
      "number": "http://bqbl.it/e640631e-13ee-4f92-8aa9-61796f66e2cc",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6a2417a5c91159050d227704edb395d6/barcode/image/e640631e-13ee-4f92-8aa9-61796f66e2cc/ea3d67a6-65d8-478a-a9f5-7b1bf1ac5c48.svg",
      "owner_id": "67ec9d23-09ef-48a3-b548-12e13bce08e0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/17c0d1b7-641e-4e0e-9246-71842984dfce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "17c0d1b7-641e-4e0e-9246-71842984dfce",
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
    "id": "17c0d1b7-641e-4e0e-9246-71842984dfce",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-25T08:52:33+00:00",
      "updated_at": "2022-03-25T08:52:33+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1936c39be21806f1b6aad1a6146bf5a3/barcode/image/17c0d1b7-641e-4e0e-9246-71842984dfce/c6267c94-c5d4-4590-9d3c-b41a88fb8b98.svg",
      "owner_id": "ed261b51-1a46-41ec-a245-9da61b37eed4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d0ad8d73-98a5-4118-a5ab-9ce54c34d3e6' \
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