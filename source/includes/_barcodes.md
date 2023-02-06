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
      "id": "0c325a71-4f28-43df-b2ca-2ed74dd9ffec",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T08:47:10+00:00",
        "updated_at": "2023-02-06T08:47:10+00:00",
        "number": "http://bqbl.it/0c325a71-4f28-43df-b2ca-2ed74dd9ffec",
        "barcode_type": "qr_code",
        "image_url": "/uploads/697616f466d047f775a3fc6a1ae0561d/barcode/image/0c325a71-4f28-43df-b2ca-2ed74dd9ffec/8597f919-37f7-49b8-aa9f-911539483894.svg",
        "owner_id": "0a25cd68-5be0-4e37-b2ae-c9d0329303ac",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0a25cd68-5be0-4e37-b2ae-c9d0329303ac"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fba156299-70f4-4271-b6e6-85e5b6abbeb4&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ba156299-70f4-4271-b6e6-85e5b6abbeb4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T08:47:10+00:00",
        "updated_at": "2023-02-06T08:47:10+00:00",
        "number": "http://bqbl.it/ba156299-70f4-4271-b6e6-85e5b6abbeb4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/181fc2f191c42eabee01d32430d6ddb1/barcode/image/ba156299-70f4-4271-b6e6-85e5b6abbeb4/3ee76959-a94d-4e0d-ba9d-094eb0cac3ed.svg",
        "owner_id": "57b16524-cd7d-40b4-a05a-4f83f2d74360",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/57b16524-cd7d-40b4-a05a-4f83f2d74360"
          },
          "data": {
            "type": "customers",
            "id": "57b16524-cd7d-40b4-a05a-4f83f2d74360"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "57b16524-cd7d-40b4-a05a-4f83f2d74360",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T08:47:10+00:00",
        "updated_at": "2023-02-06T08:47:10+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=57b16524-cd7d-40b4-a05a-4f83f2d74360&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=57b16524-cd7d-40b4-a05a-4f83f2d74360&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=57b16524-cd7d-40b4-a05a-4f83f2d74360&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYTBlNTU2YzQtNWNhNC00MTY2LTgzZjAtOWNlNDBmZWNkM2Ri&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a0e556c4-5ca4-4166-83f0-9ce40fecd3db",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-06T08:47:11+00:00",
        "updated_at": "2023-02-06T08:47:11+00:00",
        "number": "http://bqbl.it/a0e556c4-5ca4-4166-83f0-9ce40fecd3db",
        "barcode_type": "qr_code",
        "image_url": "/uploads/e6a809622fa100800eebf2cd5d376666/barcode/image/a0e556c4-5ca4-4166-83f0-9ce40fecd3db/97ec28fa-d086-4fa6-8ef9-9a740421c185.svg",
        "owner_id": "2106f81b-fdfd-4d8f-9867-c34221de0fca",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2106f81b-fdfd-4d8f-9867-c34221de0fca"
          },
          "data": {
            "type": "customers",
            "id": "2106f81b-fdfd-4d8f-9867-c34221de0fca"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2106f81b-fdfd-4d8f-9867-c34221de0fca",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T08:47:11+00:00",
        "updated_at": "2023-02-06T08:47:11+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2106f81b-fdfd-4d8f-9867-c34221de0fca&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2106f81b-fdfd-4d8f-9867-c34221de0fca&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2106f81b-fdfd-4d8f-9867-c34221de0fca&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T08:46:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/77adb125-53a6-4d5d-9895-29daeaef7b15?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "77adb125-53a6-4d5d-9895-29daeaef7b15",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T08:47:12+00:00",
      "updated_at": "2023-02-06T08:47:12+00:00",
      "number": "http://bqbl.it/77adb125-53a6-4d5d-9895-29daeaef7b15",
      "barcode_type": "qr_code",
      "image_url": "/uploads/b90c36e842a9da2765e264d57c856f22/barcode/image/77adb125-53a6-4d5d-9895-29daeaef7b15/206ab8ca-d0a6-4d18-8ae5-994e2fb8ab40.svg",
      "owner_id": "af1de8fe-98c3-4d37-bd6d-05182655ce82",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/af1de8fe-98c3-4d37-bd6d-05182655ce82"
        },
        "data": {
          "type": "customers",
          "id": "af1de8fe-98c3-4d37-bd6d-05182655ce82"
        }
      }
    }
  },
  "included": [
    {
      "id": "af1de8fe-98c3-4d37-bd6d-05182655ce82",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-06T08:47:11+00:00",
        "updated_at": "2023-02-06T08:47:12+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=af1de8fe-98c3-4d37-bd6d-05182655ce82&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=af1de8fe-98c3-4d37-bd6d-05182655ce82&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=af1de8fe-98c3-4d37-bd6d-05182655ce82&filter[owner_type]=customers"
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
          "owner_id": "220ccc9a-0cd1-4c55-aecc-512efd481363",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e7baa005-b1df-4c4c-ab71-bb4ba18d7c03",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T08:47:12+00:00",
      "updated_at": "2023-02-06T08:47:12+00:00",
      "number": "http://bqbl.it/e7baa005-b1df-4c4c-ab71-bb4ba18d7c03",
      "barcode_type": "qr_code",
      "image_url": "/uploads/69f960ec6011c714262b36ac898e9a53/barcode/image/e7baa005-b1df-4c4c-ab71-bb4ba18d7c03/a374dcef-c0ba-42a6-b2ee-94315f813b79.svg",
      "owner_id": "220ccc9a-0cd1-4c55-aecc-512efd481363",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/30bfed5e-237b-40b0-ab7b-ac76caa8980c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "30bfed5e-237b-40b0-ab7b-ac76caa8980c",
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
    "id": "30bfed5e-237b-40b0-ab7b-ac76caa8980c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-06T08:47:12+00:00",
      "updated_at": "2023-02-06T08:47:13+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/13f833fb1ec3c4c943eb15a1f2d8d66c/barcode/image/30bfed5e-237b-40b0-ab7b-ac76caa8980c/c8372a70-1bdc-4657-9df9-d63ce19cd972.svg",
      "owner_id": "f7f83810-2907-474d-95d8-4ca214d8258d",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a8c81eb1-d111-4d9d-9db8-f5de28dad09e' \
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