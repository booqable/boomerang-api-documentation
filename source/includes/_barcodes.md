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
      "id": "3a777921-d429-4ed5-940d-75423a8e0792",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-07T12:16:18+00:00",
        "updated_at": "2022-07-07T12:16:18+00:00",
        "number": "http://bqbl.it/3a777921-d429-4ed5-940d-75423a8e0792",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fe62a2e6a1dfeaad6211e10d0a1b6432/barcode/image/3a777921-d429-4ed5-940d-75423a8e0792/d911996f-d5a2-4fcb-a740-bb55f6a49546.svg",
        "owner_id": "cad9d1f1-aca7-409d-855d-273d09f100a0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cad9d1f1-aca7-409d-855d-273d09f100a0"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F38399bb3-f409-4301-b3a6-d63ebcd17498&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "38399bb3-f409-4301-b3a6-d63ebcd17498",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-07T12:16:18+00:00",
        "updated_at": "2022-07-07T12:16:18+00:00",
        "number": "http://bqbl.it/38399bb3-f409-4301-b3a6-d63ebcd17498",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b75be2a4b7c7144c6ae0de9c3dd07cdf/barcode/image/38399bb3-f409-4301-b3a6-d63ebcd17498/914a3d4b-d571-4fa4-bd34-aa2784c67f21.svg",
        "owner_id": "b285c65a-926e-489a-992c-6085d27ad20a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b285c65a-926e-489a-992c-6085d27ad20a"
          },
          "data": {
            "type": "customers",
            "id": "b285c65a-926e-489a-992c-6085d27ad20a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b285c65a-926e-489a-992c-6085d27ad20a",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-07T12:16:18+00:00",
        "updated_at": "2022-07-07T12:16:18+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Beahan and Sons",
        "email": "sons_beahan_and@gutkowski.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=b285c65a-926e-489a-992c-6085d27ad20a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b285c65a-926e-489a-992c-6085d27ad20a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b285c65a-926e-489a-992c-6085d27ad20a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNTY4ODI0MDUtNGI0OS00Y2NlLWJlMjMtMGIzOWQxMDkzYjgw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "56882405-4b49-4cce-be23-0b39d1093b80",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-07T12:16:19+00:00",
        "updated_at": "2022-07-07T12:16:19+00:00",
        "number": "http://bqbl.it/56882405-4b49-4cce-be23-0b39d1093b80",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1aebaaa18a535e8a2348994ed01e317f/barcode/image/56882405-4b49-4cce-be23-0b39d1093b80/79f3e08b-95d6-4927-bff2-007f41bf1fba.svg",
        "owner_id": "2224cf4d-dabf-4719-93f0-9e324ca7ec82",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2224cf4d-dabf-4719-93f0-9e324ca7ec82"
          },
          "data": {
            "type": "customers",
            "id": "2224cf4d-dabf-4719-93f0-9e324ca7ec82"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2224cf4d-dabf-4719-93f0-9e324ca7ec82",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-07T12:16:19+00:00",
        "updated_at": "2022-07-07T12:16:19+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Erdman, Cole and Zemlak",
        "email": "cole_erdman_zemlak_and@runolfsson.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=2224cf4d-dabf-4719-93f0-9e324ca7ec82&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2224cf4d-dabf-4719-93f0-9e324ca7ec82&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2224cf4d-dabf-4719-93f0-9e324ca7ec82&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-07T12:15:58Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/86bce3a6-5244-4289-9798-0a8a0654757b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "86bce3a6-5244-4289-9798-0a8a0654757b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-07T12:16:20+00:00",
      "updated_at": "2022-07-07T12:16:20+00:00",
      "number": "http://bqbl.it/86bce3a6-5244-4289-9798-0a8a0654757b",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ea80fed532567cdf655e3339f0d41a64/barcode/image/86bce3a6-5244-4289-9798-0a8a0654757b/854f16bc-158d-4df4-9481-4f876060c1ee.svg",
      "owner_id": "388860ad-2111-424d-804c-ffe71b8f46ae",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/388860ad-2111-424d-804c-ffe71b8f46ae"
        },
        "data": {
          "type": "customers",
          "id": "388860ad-2111-424d-804c-ffe71b8f46ae"
        }
      }
    }
  },
  "included": [
    {
      "id": "388860ad-2111-424d-804c-ffe71b8f46ae",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-07T12:16:20+00:00",
        "updated_at": "2022-07-07T12:16:20+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Weissnat-Marvin",
        "email": "marvin.weissnat@lebsack-schneider.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=388860ad-2111-424d-804c-ffe71b8f46ae&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=388860ad-2111-424d-804c-ffe71b8f46ae&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=388860ad-2111-424d-804c-ffe71b8f46ae&filter[owner_type]=customers"
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
          "owner_id": "c7222ad3-f58a-47d7-b2ad-006374c14c57",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "79e74f63-e464-404f-8e00-94ec4e539bf3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-07T12:16:21+00:00",
      "updated_at": "2022-07-07T12:16:21+00:00",
      "number": "http://bqbl.it/79e74f63-e464-404f-8e00-94ec4e539bf3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/dfb44de931e6c02a485bdfb8fd948a09/barcode/image/79e74f63-e464-404f-8e00-94ec4e539bf3/d883ef46-1314-44c5-b00f-09de1d49c8bc.svg",
      "owner_id": "c7222ad3-f58a-47d7-b2ad-006374c14c57",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/49d41f60-48b7-41c8-88e6-ec2884aa77fa' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "49d41f60-48b7-41c8-88e6-ec2884aa77fa",
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
    "id": "49d41f60-48b7-41c8-88e6-ec2884aa77fa",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-07T12:16:21+00:00",
      "updated_at": "2022-07-07T12:16:21+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6adeb1e426d5f5ad3981e6479d4b89bf/barcode/image/49d41f60-48b7-41c8-88e6-ec2884aa77fa/c45224cb-c876-4e8c-96d8-eb727164854d.svg",
      "owner_id": "8ee3c383-b720-4280-b94e-efdf0dec34c1",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a6a1e2a6-533b-45dd-b66b-1c45bebb3515' \
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