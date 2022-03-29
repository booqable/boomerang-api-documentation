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
      "id": "c11431a5-43f2-4bfe-8046-f71cd1e117a7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-29T09:19:27+00:00",
        "updated_at": "2022-03-29T09:19:27+00:00",
        "number": "http://bqbl.it/c11431a5-43f2-4bfe-8046-f71cd1e117a7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1b4165fd7bdcb0f92bbd47ed438855e4/barcode/image/c11431a5-43f2-4bfe-8046-f71cd1e117a7/bfdec90b-0a26-4c59-805d-0cfa2ab6abe8.svg",
        "owner_id": "2cb75799-b32f-4eda-9e72-ed2c8733da32",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2cb75799-b32f-4eda-9e72-ed2c8733da32"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4431d42e-1a4c-451f-91d8-a659eb91d92c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4431d42e-1a4c-451f-91d8-a659eb91d92c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-29T09:19:28+00:00",
        "updated_at": "2022-03-29T09:19:28+00:00",
        "number": "http://bqbl.it/4431d42e-1a4c-451f-91d8-a659eb91d92c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c85e8c3ee01ff5e31dbdb6053a4c6bf5/barcode/image/4431d42e-1a4c-451f-91d8-a659eb91d92c/e1885d3f-6c37-4f3f-8e45-7c94adfb536b.svg",
        "owner_id": "5052db64-0ef2-4dc7-8e44-2946a201067d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5052db64-0ef2-4dc7-8e44-2946a201067d"
          },
          "data": {
            "type": "customers",
            "id": "5052db64-0ef2-4dc7-8e44-2946a201067d"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5052db64-0ef2-4dc7-8e44-2946a201067d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-29T09:19:28+00:00",
        "updated_at": "2022-03-29T09:19:28+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Schuppe, Bartell and Quigley",
        "email": "bartell_quigley_schuppe_and@douglas-hayes.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=5052db64-0ef2-4dc7-8e44-2946a201067d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5052db64-0ef2-4dc7-8e44-2946a201067d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5052db64-0ef2-4dc7-8e44-2946a201067d&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmY1ODI4YTMtYjJlNS00NWJkLWJiNTItOTA4YzNkY2YxMGRj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2f5828a3-b2e5-45bd-bb52-908c3dcf10dc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-29T09:19:29+00:00",
        "updated_at": "2022-03-29T09:19:29+00:00",
        "number": "http://bqbl.it/2f5828a3-b2e5-45bd-bb52-908c3dcf10dc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/54b7bc4f2087d1191c38e463bf4ac2da/barcode/image/2f5828a3-b2e5-45bd-bb52-908c3dcf10dc/9e76a28f-d88b-4edc-8a6d-90c7122430e5.svg",
        "owner_id": "d17ce381-ea09-4530-82ae-62269c3253a0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d17ce381-ea09-4530-82ae-62269c3253a0"
          },
          "data": {
            "type": "customers",
            "id": "d17ce381-ea09-4530-82ae-62269c3253a0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d17ce381-ea09-4530-82ae-62269c3253a0",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-29T09:19:28+00:00",
        "updated_at": "2022-03-29T09:19:29+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Bartell, Raynor and Thiel",
        "email": "raynor.and.bartell.thiel@kerluke-hintz.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=d17ce381-ea09-4530-82ae-62269c3253a0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d17ce381-ea09-4530-82ae-62269c3253a0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d17ce381-ea09-4530-82ae-62269c3253a0&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-29T09:19:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/50497f0a-194b-43ce-8fdf-fc036fd9fff2?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "50497f0a-194b-43ce-8fdf-fc036fd9fff2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-29T09:19:29+00:00",
      "updated_at": "2022-03-29T09:19:29+00:00",
      "number": "http://bqbl.it/50497f0a-194b-43ce-8fdf-fc036fd9fff2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/16532aa4b6d9a90b9b0f4197d27b1e30/barcode/image/50497f0a-194b-43ce-8fdf-fc036fd9fff2/1457d0a4-0835-4c98-8940-cb79aec53709.svg",
      "owner_id": "db147498-09fc-4a26-9dd2-c82550b8f5a7",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/db147498-09fc-4a26-9dd2-c82550b8f5a7"
        },
        "data": {
          "type": "customers",
          "id": "db147498-09fc-4a26-9dd2-c82550b8f5a7"
        }
      }
    }
  },
  "included": [
    {
      "id": "db147498-09fc-4a26-9dd2-c82550b8f5a7",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-29T09:19:29+00:00",
        "updated_at": "2022-03-29T09:19:29+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Armstrong-Nienow",
        "email": "armstrong_nienow@kulas-pfeffer.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=db147498-09fc-4a26-9dd2-c82550b8f5a7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=db147498-09fc-4a26-9dd2-c82550b8f5a7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=db147498-09fc-4a26-9dd2-c82550b8f5a7&filter[owner_type]=customers"
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
          "owner_id": "2f1d6f0e-7cbd-4900-be9a-61f86f5bba7c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "efa4d5f6-33c5-450c-a72a-be68f5bbe9d2",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-29T09:19:29+00:00",
      "updated_at": "2022-03-29T09:19:29+00:00",
      "number": "http://bqbl.it/efa4d5f6-33c5-450c-a72a-be68f5bbe9d2",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c12ab0ba854485842d5bcee7e1960aee/barcode/image/efa4d5f6-33c5-450c-a72a-be68f5bbe9d2/847ac9b6-6baf-4f15-88f8-69a0ceb31711.svg",
      "owner_id": "2f1d6f0e-7cbd-4900-be9a-61f86f5bba7c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d5d3b590-b10d-4dfa-a98e-68b564f9ada1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d5d3b590-b10d-4dfa-a98e-68b564f9ada1",
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
    "id": "d5d3b590-b10d-4dfa-a98e-68b564f9ada1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-29T09:19:30+00:00",
      "updated_at": "2022-03-29T09:19:30+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/722613bf48acc55da0726915a91caf26/barcode/image/d5d3b590-b10d-4dfa-a98e-68b564f9ada1/4d794e56-bef5-4c05-969c-3aaa533f8e91.svg",
      "owner_id": "70c38385-ad8a-483e-9aa6-3417d96540f5",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1a6c7a64-c051-45df-9abb-ad0477e404cc' \
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