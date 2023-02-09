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
      "id": "a95474d7-9a49-41eb-9abb-7ff73e3d080c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T15:54:37+00:00",
        "updated_at": "2023-02-09T15:54:37+00:00",
        "number": "http://bqbl.it/a95474d7-9a49-41eb-9abb-7ff73e3d080c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1dd893e21e2324389ffbb691cf5401af/barcode/image/a95474d7-9a49-41eb-9abb-7ff73e3d080c/91e2d813-0f1b-43f4-91ba-38b18b949a92.svg",
        "owner_id": "4fcbef36-e653-43a4-b299-4b3d83d37f87",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4fcbef36-e653-43a4-b299-4b3d83d37f87"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5061dcd2-38dc-4907-961b-61582715847c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5061dcd2-38dc-4907-961b-61582715847c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T15:54:37+00:00",
        "updated_at": "2023-02-09T15:54:37+00:00",
        "number": "http://bqbl.it/5061dcd2-38dc-4907-961b-61582715847c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/78f50b65d9de84bcf3535985ec1dd20d/barcode/image/5061dcd2-38dc-4907-961b-61582715847c/7a2a9353-00b1-4806-ae57-e9bf94630c94.svg",
        "owner_id": "3c75bb15-5e2f-4707-b45b-08ab4b8a8323",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3c75bb15-5e2f-4707-b45b-08ab4b8a8323"
          },
          "data": {
            "type": "customers",
            "id": "3c75bb15-5e2f-4707-b45b-08ab4b8a8323"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3c75bb15-5e2f-4707-b45b-08ab4b8a8323",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T15:54:37+00:00",
        "updated_at": "2023-02-09T15:54:37+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3c75bb15-5e2f-4707-b45b-08ab4b8a8323&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3c75bb15-5e2f-4707-b45b-08ab4b8a8323&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3c75bb15-5e2f-4707-b45b-08ab4b8a8323&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDlmN2NhYjEtMDc2NC00YzIwLWI0NTctZTk4NmNhM2I5ZDBm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d9f7cab1-0764-4c20-b457-e986ca3b9d0f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-09T15:54:38+00:00",
        "updated_at": "2023-02-09T15:54:38+00:00",
        "number": "http://bqbl.it/d9f7cab1-0764-4c20-b457-e986ca3b9d0f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/462b370defd645a4aea73be258984dd0/barcode/image/d9f7cab1-0764-4c20-b457-e986ca3b9d0f/28f3e8f2-9461-454c-9b63-adcd4cef4cda.svg",
        "owner_id": "cc1d098f-90b8-40cd-8bed-b8d8dc1e9a2a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cc1d098f-90b8-40cd-8bed-b8d8dc1e9a2a"
          },
          "data": {
            "type": "customers",
            "id": "cc1d098f-90b8-40cd-8bed-b8d8dc1e9a2a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cc1d098f-90b8-40cd-8bed-b8d8dc1e9a2a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T15:54:37+00:00",
        "updated_at": "2023-02-09T15:54:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=cc1d098f-90b8-40cd-8bed-b8d8dc1e9a2a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=cc1d098f-90b8-40cd-8bed-b8d8dc1e9a2a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=cc1d098f-90b8-40cd-8bed-b8d8dc1e9a2a&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T15:54:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d2aebcf7-396f-41a1-9735-fdd5a0e1d315?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d2aebcf7-396f-41a1-9735-fdd5a0e1d315",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T15:54:38+00:00",
      "updated_at": "2023-02-09T15:54:38+00:00",
      "number": "http://bqbl.it/d2aebcf7-396f-41a1-9735-fdd5a0e1d315",
      "barcode_type": "qr_code",
      "image_url": "/uploads/248fea8ac26e9d3a75241fa65b3b984d/barcode/image/d2aebcf7-396f-41a1-9735-fdd5a0e1d315/15db1d65-e33f-4cd7-839e-d10f105e387e.svg",
      "owner_id": "eb3dc426-d0b7-4707-8c36-7c5d814eef85",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/eb3dc426-d0b7-4707-8c36-7c5d814eef85"
        },
        "data": {
          "type": "customers",
          "id": "eb3dc426-d0b7-4707-8c36-7c5d814eef85"
        }
      }
    }
  },
  "included": [
    {
      "id": "eb3dc426-d0b7-4707-8c36-7c5d814eef85",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-09T15:54:38+00:00",
        "updated_at": "2023-02-09T15:54:38+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=eb3dc426-d0b7-4707-8c36-7c5d814eef85&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=eb3dc426-d0b7-4707-8c36-7c5d814eef85&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=eb3dc426-d0b7-4707-8c36-7c5d814eef85&filter[owner_type]=customers"
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
          "owner_id": "ab2a225e-26cb-49b6-bed0-76fdeedc7ea1",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0dfe020e-17f9-4432-b976-e24dd1c3b218",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T15:54:38+00:00",
      "updated_at": "2023-02-09T15:54:38+00:00",
      "number": "http://bqbl.it/0dfe020e-17f9-4432-b976-e24dd1c3b218",
      "barcode_type": "qr_code",
      "image_url": "/uploads/225e01bcf6c404d7440fab691a98996a/barcode/image/0dfe020e-17f9-4432-b976-e24dd1c3b218/4636d55d-365d-4e76-95f9-fa259df6d462.svg",
      "owner_id": "ab2a225e-26cb-49b6-bed0-76fdeedc7ea1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/23dcc3ab-84b9-4197-a205-0972115a865b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "23dcc3ab-84b9-4197-a205-0972115a865b",
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
    "id": "23dcc3ab-84b9-4197-a205-0972115a865b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-09T15:54:39+00:00",
      "updated_at": "2023-02-09T15:54:39+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/57e357d308f03371c3648d22499cce41/barcode/image/23dcc3ab-84b9-4197-a205-0972115a865b/23e5d29d-f37a-4081-be55-f9d0631962f7.svg",
      "owner_id": "dc167983-81f4-48f6-b18c-061874d66a6b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f8796521-98a5-4730-b573-1384a95d8b2e' \
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