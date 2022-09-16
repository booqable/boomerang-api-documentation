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
      "id": "6263bd5c-10fa-40ce-acdc-1e4e6f04d85c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T14:12:54+00:00",
        "updated_at": "2022-09-16T14:12:54+00:00",
        "number": "http://bqbl.it/6263bd5c-10fa-40ce-acdc-1e4e6f04d85c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3658f3724c46e101dc57d961e5117f6c/barcode/image/6263bd5c-10fa-40ce-acdc-1e4e6f04d85c/31704c59-28ee-49df-baf7-8517aaa00694.svg",
        "owner_id": "57673217-880a-4d4f-9243-aa86cce63857",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/57673217-880a-4d4f-9243-aa86cce63857"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff4abdc60-e36b-4b18-9535-09dbbd426703&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f4abdc60-e36b-4b18-9535-09dbbd426703",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T14:12:55+00:00",
        "updated_at": "2022-09-16T14:12:55+00:00",
        "number": "http://bqbl.it/f4abdc60-e36b-4b18-9535-09dbbd426703",
        "barcode_type": "qr_code",
        "image_url": "/uploads/eed21aa118c149ca85cf7b2893051702/barcode/image/f4abdc60-e36b-4b18-9535-09dbbd426703/e661c523-c18e-4047-993f-0cbff99110bc.svg",
        "owner_id": "06c68566-efaf-4d6e-b223-37b5fa024180",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/06c68566-efaf-4d6e-b223-37b5fa024180"
          },
          "data": {
            "type": "customers",
            "id": "06c68566-efaf-4d6e-b223-37b5fa024180"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "06c68566-efaf-4d6e-b223-37b5fa024180",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T14:12:55+00:00",
        "updated_at": "2022-09-16T14:12:55+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=06c68566-efaf-4d6e-b223-37b5fa024180&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=06c68566-efaf-4d6e-b223-37b5fa024180&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=06c68566-efaf-4d6e-b223-37b5fa024180&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZDkyYTNhYTAtMjIzZS00NTQ0LTg1ZjctMzAxNjE5ZTgxNmU4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d92a3aa0-223e-4544-85f7-301619e816e8",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-09-16T14:12:56+00:00",
        "updated_at": "2022-09-16T14:12:56+00:00",
        "number": "http://bqbl.it/d92a3aa0-223e-4544-85f7-301619e816e8",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4c0bcf2832ef5e1c392c1a42b17312ae/barcode/image/d92a3aa0-223e-4544-85f7-301619e816e8/bb0fb545-06c9-4ce3-838a-008603ddbc6b.svg",
        "owner_id": "2fd935c5-185c-4182-a3a1-069d2d9a5a5b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2fd935c5-185c-4182-a3a1-069d2d9a5a5b"
          },
          "data": {
            "type": "customers",
            "id": "2fd935c5-185c-4182-a3a1-069d2d9a5a5b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2fd935c5-185c-4182-a3a1-069d2d9a5a5b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T14:12:56+00:00",
        "updated_at": "2022-09-16T14:12:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2fd935c5-185c-4182-a3a1-069d2d9a5a5b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2fd935c5-185c-4182-a3a1-069d2d9a5a5b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2fd935c5-185c-4182-a3a1-069d2d9a5a5b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T14:12:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/fbace18e-c064-4aa2-9676-02f741cce5ed?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fbace18e-c064-4aa2-9676-02f741cce5ed",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T14:12:56+00:00",
      "updated_at": "2022-09-16T14:12:56+00:00",
      "number": "http://bqbl.it/fbace18e-c064-4aa2-9676-02f741cce5ed",
      "barcode_type": "qr_code",
      "image_url": "/uploads/db59af4fb6a6afcf3766eea595b2fd5e/barcode/image/fbace18e-c064-4aa2-9676-02f741cce5ed/fd0632ba-7324-4fef-993d-09b85b32eaaa.svg",
      "owner_id": "28c94a34-9ac5-43ce-8325-0b467eea092a",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/28c94a34-9ac5-43ce-8325-0b467eea092a"
        },
        "data": {
          "type": "customers",
          "id": "28c94a34-9ac5-43ce-8325-0b467eea092a"
        }
      }
    }
  },
  "included": [
    {
      "id": "28c94a34-9ac5-43ce-8325-0b467eea092a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-09-16T14:12:56+00:00",
        "updated_at": "2022-09-16T14:12:56+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=28c94a34-9ac5-43ce-8325-0b467eea092a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=28c94a34-9ac5-43ce-8325-0b467eea092a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=28c94a34-9ac5-43ce-8325-0b467eea092a&filter[owner_type]=customers"
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
          "owner_id": "cc7d4fc2-9ee2-4f5b-a8f5-514fe8c5e37c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b9e8a41b-cd3e-4b7d-b2c0-cf5c24bb24b5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T14:12:57+00:00",
      "updated_at": "2022-09-16T14:12:57+00:00",
      "number": "http://bqbl.it/b9e8a41b-cd3e-4b7d-b2c0-cf5c24bb24b5",
      "barcode_type": "qr_code",
      "image_url": "/uploads/84ef90f6c30b6ebda845615f418b0d9d/barcode/image/b9e8a41b-cd3e-4b7d-b2c0-cf5c24bb24b5/16ccaeac-3d53-48c4-8dcf-53dc68462588.svg",
      "owner_id": "cc7d4fc2-9ee2-4f5b-a8f5-514fe8c5e37c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/233ea5dd-8c70-47ff-8188-4d21b1b89c18' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "233ea5dd-8c70-47ff-8188-4d21b1b89c18",
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
    "id": "233ea5dd-8c70-47ff-8188-4d21b1b89c18",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-09-16T14:12:57+00:00",
      "updated_at": "2022-09-16T14:12:57+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a2bb9b7eb132cdcc52a73368735d4b1e/barcode/image/233ea5dd-8c70-47ff-8188-4d21b1b89c18/33dae345-49a1-4e8c-9492-333193b39a7c.svg",
      "owner_id": "5f2d2ed2-6a7c-4b3e-aa3f-2e86111a56c7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/1fc726ab-fb07-4dce-90ac-880c187ca87c' \
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