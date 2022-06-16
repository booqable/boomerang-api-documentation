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
      "id": "b4bb4923-06cf-4ecd-ae4a-e3bd45d81942",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-16T15:44:37+00:00",
        "updated_at": "2022-06-16T15:44:37+00:00",
        "number": "http://bqbl.it/b4bb4923-06cf-4ecd-ae4a-e3bd45d81942",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1b07f7d4db30fcd61ccffff1e7b88d3c/barcode/image/b4bb4923-06cf-4ecd-ae4a-e3bd45d81942/15252389-ca91-4576-bfcd-306b43bd358c.svg",
        "owner_id": "0bd905bf-53ec-45bb-b9e4-784359235955",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0bd905bf-53ec-45bb-b9e4-784359235955"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd78550c6-7ca6-4375-bca5-1b72e2155732&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d78550c6-7ca6-4375-bca5-1b72e2155732",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-16T15:44:38+00:00",
        "updated_at": "2022-06-16T15:44:38+00:00",
        "number": "http://bqbl.it/d78550c6-7ca6-4375-bca5-1b72e2155732",
        "barcode_type": "qr_code",
        "image_url": "/uploads/2b1830546d41b3f805b80544aca9dbe4/barcode/image/d78550c6-7ca6-4375-bca5-1b72e2155732/e65d4bbb-b04c-42ed-8125-28d0a9669072.svg",
        "owner_id": "8f189c82-8726-4c47-8c19-afb69b5cd5ed",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8f189c82-8726-4c47-8c19-afb69b5cd5ed"
          },
          "data": {
            "type": "customers",
            "id": "8f189c82-8726-4c47-8c19-afb69b5cd5ed"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "8f189c82-8726-4c47-8c19-afb69b5cd5ed",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-16T15:44:38+00:00",
        "updated_at": "2022-06-16T15:44:38+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Grady-Jenkins",
        "email": "grady.jenkins@brown.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=8f189c82-8726-4c47-8c19-afb69b5cd5ed&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8f189c82-8726-4c47-8c19-afb69b5cd5ed&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8f189c82-8726-4c47-8c19-afb69b5cd5ed&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYmJkODhmMDctZGQ5Yy00NTc2LThlODQtNjMwNTgyNDAwYmQx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bbd88f07-dd9c-4576-8e84-630582400bd1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-16T15:44:38+00:00",
        "updated_at": "2022-06-16T15:44:38+00:00",
        "number": "http://bqbl.it/bbd88f07-dd9c-4576-8e84-630582400bd1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b15a869c5250c175e593d2e46ba957d6/barcode/image/bbd88f07-dd9c-4576-8e84-630582400bd1/8443dc15-7155-451c-8573-fcea4373878f.svg",
        "owner_id": "d1ea0714-f514-4e7e-bce4-9f76ac2ac80c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d1ea0714-f514-4e7e-bce4-9f76ac2ac80c"
          },
          "data": {
            "type": "customers",
            "id": "d1ea0714-f514-4e7e-bce4-9f76ac2ac80c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d1ea0714-f514-4e7e-bce4-9f76ac2ac80c",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-16T15:44:38+00:00",
        "updated_at": "2022-06-16T15:44:38+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "White and Sons",
        "email": "sons_and_white@kuhlman-homenick.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=d1ea0714-f514-4e7e-bce4-9f76ac2ac80c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d1ea0714-f514-4e7e-bce4-9f76ac2ac80c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d1ea0714-f514-4e7e-bce4-9f76ac2ac80c&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-16T15:44:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5f3a5ef1-0318-4080-aaa1-a4a4a932beba?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5f3a5ef1-0318-4080-aaa1-a4a4a932beba",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-16T15:44:39+00:00",
      "updated_at": "2022-06-16T15:44:39+00:00",
      "number": "http://bqbl.it/5f3a5ef1-0318-4080-aaa1-a4a4a932beba",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b61a303864118b00d48c9a6e02281c0c/barcode/image/5f3a5ef1-0318-4080-aaa1-a4a4a932beba/dfdf5620-9228-416c-99c0-74b727ec41c8.svg",
      "owner_id": "1e632c85-db52-4195-936f-6e3425077428",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1e632c85-db52-4195-936f-6e3425077428"
        },
        "data": {
          "type": "customers",
          "id": "1e632c85-db52-4195-936f-6e3425077428"
        }
      }
    }
  },
  "included": [
    {
      "id": "1e632c85-db52-4195-936f-6e3425077428",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-16T15:44:39+00:00",
        "updated_at": "2022-06-16T15:44:39+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Sauer, Collier and Davis",
        "email": "davis_sauer_and_collier@wisoky.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=1e632c85-db52-4195-936f-6e3425077428&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1e632c85-db52-4195-936f-6e3425077428&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1e632c85-db52-4195-936f-6e3425077428&filter[owner_type]=customers"
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
          "owner_id": "e0e7c9e9-b037-4d38-94ed-60509a0e2ed0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "aa78672e-4ea6-4cd4-8387-5502a66e0e2a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-16T15:44:39+00:00",
      "updated_at": "2022-06-16T15:44:39+00:00",
      "number": "http://bqbl.it/aa78672e-4ea6-4cd4-8387-5502a66e0e2a",
      "barcode_type": "qr_code",
      "image_url": "/uploads/425b12c208f17480deaa98202ebd871d/barcode/image/aa78672e-4ea6-4cd4-8387-5502a66e0e2a/561aace4-f90d-4560-8a29-392b78cde578.svg",
      "owner_id": "e0e7c9e9-b037-4d38-94ed-60509a0e2ed0",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f70ef237-9a20-4326-8ca8-21165577c4c7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f70ef237-9a20-4326-8ca8-21165577c4c7",
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
    "id": "f70ef237-9a20-4326-8ca8-21165577c4c7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-16T15:44:40+00:00",
      "updated_at": "2022-06-16T15:44:40+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/48e7c663f0b0dcb873b48ee808a8fb46/barcode/image/f70ef237-9a20-4326-8ca8-21165577c4c7/7261e1fd-0064-4fa8-a715-a8c17d78e063.svg",
      "owner_id": "f60aa87c-9152-438d-a0f1-557f557883e7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/b495b952-f4ed-4382-abfc-af4a96b84e8e' \
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