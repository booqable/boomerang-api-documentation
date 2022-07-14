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
      "id": "ab720c5a-b0d3-4d20-a993-87e89df8689c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T10:33:33+00:00",
        "updated_at": "2022-07-14T10:33:33+00:00",
        "number": "http://bqbl.it/ab720c5a-b0d3-4d20-a993-87e89df8689c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bd6912b569768a046a17d01e86e96240/barcode/image/ab720c5a-b0d3-4d20-a993-87e89df8689c/ba465b17-01cc-4fbc-8a15-9d5db9131cf4.svg",
        "owner_id": "4bb025b5-26b2-4ae2-a6a9-bd2f9323fdfd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4bb025b5-26b2-4ae2-a6a9-bd2f9323fdfd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff046e482-23dc-4ab6-8a71-0e652203b7b0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f046e482-23dc-4ab6-8a71-0e652203b7b0",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T10:33:33+00:00",
        "updated_at": "2022-07-14T10:33:33+00:00",
        "number": "http://bqbl.it/f046e482-23dc-4ab6-8a71-0e652203b7b0",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1e201650e6152352549fdba101829c7c/barcode/image/f046e482-23dc-4ab6-8a71-0e652203b7b0/be317f6e-4bed-4dd9-9b1f-0c85ee769582.svg",
        "owner_id": "840746ee-3263-421f-926b-7eaedd6e7fe4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/840746ee-3263-421f-926b-7eaedd6e7fe4"
          },
          "data": {
            "type": "customers",
            "id": "840746ee-3263-421f-926b-7eaedd6e7fe4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "840746ee-3263-421f-926b-7eaedd6e7fe4",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:33:33+00:00",
        "updated_at": "2022-07-14T10:33:33+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Schinner Inc",
        "email": "schinner.inc@bosco.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=840746ee-3263-421f-926b-7eaedd6e7fe4&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=840746ee-3263-421f-926b-7eaedd6e7fe4&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=840746ee-3263-421f-926b-7eaedd6e7fe4&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTkxMzlkOTQtNjU2My00YjMxLWIzY2MtNzRhYjBkYjljNDA3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "59139d94-6563-4b31-b3cc-74ab0db9c407",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-14T10:33:33+00:00",
        "updated_at": "2022-07-14T10:33:33+00:00",
        "number": "http://bqbl.it/59139d94-6563-4b31-b3cc-74ab0db9c407",
        "barcode_type": "qr_code",
        "image_url": "/uploads/14f1dc53ad19f9733582b52350b8c4b7/barcode/image/59139d94-6563-4b31-b3cc-74ab0db9c407/39c1f554-4e1b-4d16-9014-fa011642f6ab.svg",
        "owner_id": "5bd1153d-b86b-4c23-99ef-bee3c99a4613",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5bd1153d-b86b-4c23-99ef-bee3c99a4613"
          },
          "data": {
            "type": "customers",
            "id": "5bd1153d-b86b-4c23-99ef-bee3c99a4613"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5bd1153d-b86b-4c23-99ef-bee3c99a4613",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:33:33+00:00",
        "updated_at": "2022-07-14T10:33:33+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Stamm-Durgan",
        "email": "durgan.stamm@gerlach.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=5bd1153d-b86b-4c23-99ef-bee3c99a4613&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5bd1153d-b86b-4c23-99ef-bee3c99a4613&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5bd1153d-b86b-4c23-99ef-bee3c99a4613&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:33:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/00bfbee9-1d03-4bd7-a545-d05a4e260f8c?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "00bfbee9-1d03-4bd7-a545-d05a4e260f8c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T10:33:34+00:00",
      "updated_at": "2022-07-14T10:33:34+00:00",
      "number": "http://bqbl.it/00bfbee9-1d03-4bd7-a545-d05a4e260f8c",
      "barcode_type": "qr_code",
      "image_url": "/uploads/22b926cc232aa495c3e6d5794afa4e4b/barcode/image/00bfbee9-1d03-4bd7-a545-d05a4e260f8c/4bdf994a-1eaf-4a59-b6cb-55e7f1ae2e0b.svg",
      "owner_id": "b9a208e4-8908-4dee-a5e8-c4cfdd527031",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b9a208e4-8908-4dee-a5e8-c4cfdd527031"
        },
        "data": {
          "type": "customers",
          "id": "b9a208e4-8908-4dee-a5e8-c4cfdd527031"
        }
      }
    }
  },
  "included": [
    {
      "id": "b9a208e4-8908-4dee-a5e8-c4cfdd527031",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:33:34+00:00",
        "updated_at": "2022-07-14T10:33:34+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Schmeler Group",
        "email": "schmeler.group@rippin-tillman.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=b9a208e4-8908-4dee-a5e8-c4cfdd527031&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b9a208e4-8908-4dee-a5e8-c4cfdd527031&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b9a208e4-8908-4dee-a5e8-c4cfdd527031&filter[owner_type]=customers"
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
          "owner_id": "909c6f68-40dc-40e5-a634-55d6250451ee",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e80118f6-17bc-4e2f-84f0-5dab24c80dc8",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T10:33:34+00:00",
      "updated_at": "2022-07-14T10:33:34+00:00",
      "number": "http://bqbl.it/e80118f6-17bc-4e2f-84f0-5dab24c80dc8",
      "barcode_type": "qr_code",
      "image_url": "/uploads/830c63b9d3a5b25da1f473ec4df22292/barcode/image/e80118f6-17bc-4e2f-84f0-5dab24c80dc8/6a50cf14-404d-44c5-baf2-80f397118b87.svg",
      "owner_id": "909c6f68-40dc-40e5-a634-55d6250451ee",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7af7ebcb-4751-4dd1-80a6-6a54b1bfbf5a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7af7ebcb-4751-4dd1-80a6-6a54b1bfbf5a",
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
    "id": "7af7ebcb-4751-4dd1-80a6-6a54b1bfbf5a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-14T10:33:35+00:00",
      "updated_at": "2022-07-14T10:33:35+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/aea4af77c1559f59215e6a299b4a23cc/barcode/image/7af7ebcb-4751-4dd1-80a6-6a54b1bfbf5a/73cedd96-9668-4d25-a84a-5643ddf6bcbf.svg",
      "owner_id": "d5959570-03bd-44eb-a6d5-c5e6d88faf7f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4e3e51d6-75aa-455c-8ea4-a36b4766eae1' \
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