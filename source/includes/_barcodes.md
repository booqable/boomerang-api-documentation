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
      "id": "b8ff0410-b24c-4bd0-9547-4fc0d37904bd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-15T11:20:28+00:00",
        "updated_at": "2022-07-15T11:20:28+00:00",
        "number": "http://bqbl.it/b8ff0410-b24c-4bd0-9547-4fc0d37904bd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ce6d3aa8431a4b11d1bf1e34d4e8d0c9/barcode/image/b8ff0410-b24c-4bd0-9547-4fc0d37904bd/f6db4409-5412-44fb-8a86-f050d58521eb.svg",
        "owner_id": "8a23ed76-352b-43a0-8104-b70e938199b2",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8a23ed76-352b-43a0-8104-b70e938199b2"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0ccb0fa7-dc5a-468e-9331-c0530e3c8c10&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0ccb0fa7-dc5a-468e-9331-c0530e3c8c10",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-15T11:20:28+00:00",
        "updated_at": "2022-07-15T11:20:28+00:00",
        "number": "http://bqbl.it/0ccb0fa7-dc5a-468e-9331-c0530e3c8c10",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3fba465944f4f00abaf098e0de424f0f/barcode/image/0ccb0fa7-dc5a-468e-9331-c0530e3c8c10/d2d622c4-517d-42cb-9e4a-739ebbad988c.svg",
        "owner_id": "6cee6cd0-7c7d-4fab-b257-4d7940009e13",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6cee6cd0-7c7d-4fab-b257-4d7940009e13"
          },
          "data": {
            "type": "customers",
            "id": "6cee6cd0-7c7d-4fab-b257-4d7940009e13"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6cee6cd0-7c7d-4fab-b257-4d7940009e13",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-15T11:20:28+00:00",
        "updated_at": "2022-07-15T11:20:28+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Hyatt LLC",
        "email": "hyatt_llc@schaden-kovacek.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=6cee6cd0-7c7d-4fab-b257-4d7940009e13&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6cee6cd0-7c7d-4fab-b257-4d7940009e13&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6cee6cd0-7c7d-4fab-b257-4d7940009e13&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvY2MzNGQwZDktZGMzMS00YmEzLWJiZjItMDFiNzVlMjI1MjFj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cc34d0d9-dc31-4ba3-bbf2-01b75e22521c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-15T11:20:29+00:00",
        "updated_at": "2022-07-15T11:20:29+00:00",
        "number": "http://bqbl.it/cc34d0d9-dc31-4ba3-bbf2-01b75e22521c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/51be665912c8ce2db9e6d985ff420f94/barcode/image/cc34d0d9-dc31-4ba3-bbf2-01b75e22521c/4c98b01e-1528-47bf-a051-fd61a4d7d6e6.svg",
        "owner_id": "6e593760-187c-482a-ba8b-31bd445540f9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6e593760-187c-482a-ba8b-31bd445540f9"
          },
          "data": {
            "type": "customers",
            "id": "6e593760-187c-482a-ba8b-31bd445540f9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "6e593760-187c-482a-ba8b-31bd445540f9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-15T11:20:29+00:00",
        "updated_at": "2022-07-15T11:20:29+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Mosciski-O'Conner",
        "email": "conner.o.mosciski@connelly.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=6e593760-187c-482a-ba8b-31bd445540f9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6e593760-187c-482a-ba8b-31bd445540f9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6e593760-187c-482a-ba8b-31bd445540f9&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T11:20:13Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f6a4e201-82d8-4a8c-9516-5bd930f1e5fa?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f6a4e201-82d8-4a8c-9516-5bd930f1e5fa",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-15T11:20:30+00:00",
      "updated_at": "2022-07-15T11:20:30+00:00",
      "number": "http://bqbl.it/f6a4e201-82d8-4a8c-9516-5bd930f1e5fa",
      "barcode_type": "qr_code",
      "image_url": "/uploads/4fafd27ae08af7c3e45b7332a540b959/barcode/image/f6a4e201-82d8-4a8c-9516-5bd930f1e5fa/aed4019a-e709-46ad-ad8b-f3bf30ced505.svg",
      "owner_id": "243644eb-73e0-4c1c-86a6-f2b0c4078abf",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/243644eb-73e0-4c1c-86a6-f2b0c4078abf"
        },
        "data": {
          "type": "customers",
          "id": "243644eb-73e0-4c1c-86a6-f2b0c4078abf"
        }
      }
    }
  },
  "included": [
    {
      "id": "243644eb-73e0-4c1c-86a6-f2b0c4078abf",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-15T11:20:30+00:00",
        "updated_at": "2022-07-15T11:20:30+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Feil, Olson and Parker",
        "email": "olson.feil.and.parker@graham.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=243644eb-73e0-4c1c-86a6-f2b0c4078abf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=243644eb-73e0-4c1c-86a6-f2b0c4078abf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=243644eb-73e0-4c1c-86a6-f2b0c4078abf&filter[owner_type]=customers"
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
          "owner_id": "a919cdbe-af98-48a3-895c-7c7af309bdac",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "000b5b43-add4-4f13-b04d-a008b942c439",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-15T11:20:30+00:00",
      "updated_at": "2022-07-15T11:20:30+00:00",
      "number": "http://bqbl.it/000b5b43-add4-4f13-b04d-a008b942c439",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9c4c157eedde9101257d58c07b1468a7/barcode/image/000b5b43-add4-4f13-b04d-a008b942c439/f3a75064-818e-4078-a325-6cb3492d0a96.svg",
      "owner_id": "a919cdbe-af98-48a3-895c-7c7af309bdac",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a8a260b2-4253-4578-b1bc-f665d6aca854' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a8a260b2-4253-4578-b1bc-f665d6aca854",
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
    "id": "a8a260b2-4253-4578-b1bc-f665d6aca854",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-15T11:20:31+00:00",
      "updated_at": "2022-07-15T11:20:31+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8d893580bd02acba551a9db7b094fcf5/barcode/image/a8a260b2-4253-4578-b1bc-f665d6aca854/5ab29cf0-0619-49b1-9041-0a6b57e1b270.svg",
      "owner_id": "f4892182-f58d-4cb0-a7e4-5fed6e8c79a7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4425ab8e-c159-4ebb-8e1e-56af36d031e2' \
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