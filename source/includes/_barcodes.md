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
      "id": "cbf68de2-9daf-45b3-8d4d-b01d95f8f57b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-19T14:22:25+00:00",
        "updated_at": "2022-05-19T14:22:25+00:00",
        "number": "http://bqbl.it/cbf68de2-9daf-45b3-8d4d-b01d95f8f57b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8e6a55bf5bc82f904c925607079c621e/barcode/image/cbf68de2-9daf-45b3-8d4d-b01d95f8f57b/ced7b1d1-50f0-4c6c-a07a-3611b0e94607.svg",
        "owner_id": "11e212f9-1401-4227-99d1-f519b411a66b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/11e212f9-1401-4227-99d1-f519b411a66b"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F188bf233-c573-4bf9-9eea-76c6c60dfca5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "188bf233-c573-4bf9-9eea-76c6c60dfca5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-19T14:22:26+00:00",
        "updated_at": "2022-05-19T14:22:26+00:00",
        "number": "http://bqbl.it/188bf233-c573-4bf9-9eea-76c6c60dfca5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/67e3947bb78870cc46d6625977f08f9c/barcode/image/188bf233-c573-4bf9-9eea-76c6c60dfca5/f0b32ac7-2611-4b9d-8e46-a7a53c4d66e7.svg",
        "owner_id": "a29b2cb9-75dc-4278-9950-41bd6706efab",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a29b2cb9-75dc-4278-9950-41bd6706efab"
          },
          "data": {
            "type": "customers",
            "id": "a29b2cb9-75dc-4278-9950-41bd6706efab"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a29b2cb9-75dc-4278-9950-41bd6706efab",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-19T14:22:26+00:00",
        "updated_at": "2022-05-19T14:22:26+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Parker and Sons",
        "email": "and.sons.parker@barton-johnston.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=a29b2cb9-75dc-4278-9950-41bd6706efab&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a29b2cb9-75dc-4278-9950-41bd6706efab&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a29b2cb9-75dc-4278-9950-41bd6706efab&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZjhlOWY5MzUtNDk2Ni00MmU0LWFkZjUtMDIyOTA2NTM1MTgz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f8e9f935-4966-42e4-adf5-022906535183",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-19T14:22:26+00:00",
        "updated_at": "2022-05-19T14:22:26+00:00",
        "number": "http://bqbl.it/f8e9f935-4966-42e4-adf5-022906535183",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a9d1942b4bc6e5e678b0592d53663f9b/barcode/image/f8e9f935-4966-42e4-adf5-022906535183/0b9d38c6-c9fc-4350-a16a-5e08361bdc98.svg",
        "owner_id": "a55b5f33-8399-4003-8685-93bd2812a2de",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a55b5f33-8399-4003-8685-93bd2812a2de"
          },
          "data": {
            "type": "customers",
            "id": "a55b5f33-8399-4003-8685-93bd2812a2de"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a55b5f33-8399-4003-8685-93bd2812a2de",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-19T14:22:26+00:00",
        "updated_at": "2022-05-19T14:22:26+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Nikolaus-Emmerich",
        "email": "nikolaus_emmerich@streich.io",
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
            "related": "api/boomerang/properties?filter[owner_id]=a55b5f33-8399-4003-8685-93bd2812a2de&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a55b5f33-8399-4003-8685-93bd2812a2de&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a55b5f33-8399-4003-8685-93bd2812a2de&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T14:22:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/800935c2-2ad1-4ddd-9f15-63ed83f70582?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "800935c2-2ad1-4ddd-9f15-63ed83f70582",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-19T14:22:27+00:00",
      "updated_at": "2022-05-19T14:22:27+00:00",
      "number": "http://bqbl.it/800935c2-2ad1-4ddd-9f15-63ed83f70582",
      "barcode_type": "qr_code",
      "image_url": "/uploads/092af684b6276ae9108378e853c94877/barcode/image/800935c2-2ad1-4ddd-9f15-63ed83f70582/aac22457-69af-421d-ae1f-26e44d8b0e0f.svg",
      "owner_id": "0c8ebbd5-b9d8-4fa1-ae2d-98fa85b71082",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0c8ebbd5-b9d8-4fa1-ae2d-98fa85b71082"
        },
        "data": {
          "type": "customers",
          "id": "0c8ebbd5-b9d8-4fa1-ae2d-98fa85b71082"
        }
      }
    }
  },
  "included": [
    {
      "id": "0c8ebbd5-b9d8-4fa1-ae2d-98fa85b71082",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-19T14:22:27+00:00",
        "updated_at": "2022-05-19T14:22:27+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kuhic and Sons",
        "email": "and.kuhic.sons@doyle.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=0c8ebbd5-b9d8-4fa1-ae2d-98fa85b71082&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0c8ebbd5-b9d8-4fa1-ae2d-98fa85b71082&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0c8ebbd5-b9d8-4fa1-ae2d-98fa85b71082&filter[owner_type]=customers"
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
          "owner_id": "5487b742-d92c-4ef9-a8e4-35671fca1984",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d4a94dec-26af-491d-b673-b46c970330a6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-19T14:22:27+00:00",
      "updated_at": "2022-05-19T14:22:27+00:00",
      "number": "http://bqbl.it/d4a94dec-26af-491d-b673-b46c970330a6",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ed565fcf54bc4ceab216d99b88adc0eb/barcode/image/d4a94dec-26af-491d-b673-b46c970330a6/cb509843-0342-44af-b076-9dca06f91d78.svg",
      "owner_id": "5487b742-d92c-4ef9-a8e4-35671fca1984",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f09828af-c776-4433-aff0-55c726157bc7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f09828af-c776-4433-aff0-55c726157bc7",
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
    "id": "f09828af-c776-4433-aff0-55c726157bc7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-19T14:22:27+00:00",
      "updated_at": "2022-05-19T14:22:28+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4e0ea27d711600b2d759023d3e514c35/barcode/image/f09828af-c776-4433-aff0-55c726157bc7/22d9740f-31f2-491f-b1e2-23c4becc929f.svg",
      "owner_id": "7e126845-574c-4c6e-acea-ea9b654d9222",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/484910e1-429a-44b6-8fcf-617ade381c16' \
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