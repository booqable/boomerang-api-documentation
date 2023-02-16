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
      "id": "7cce0ad5-c069-4c75-87a7-c557b9779f0f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T10:58:58+00:00",
        "updated_at": "2023-02-16T10:58:58+00:00",
        "number": "http://bqbl.it/7cce0ad5-c069-4c75-87a7-c557b9779f0f",
        "barcode_type": "qr_code",
        "image_url": "/uploads/fc416516c569427a826ff8022033ddd2/barcode/image/7cce0ad5-c069-4c75-87a7-c557b9779f0f/5db4d454-1182-49d0-aeac-8e866a5b34b2.svg",
        "owner_id": "3baf810c-b497-4395-b4fd-778647f74c01",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3baf810c-b497-4395-b4fd-778647f74c01"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fd5375fa1-7060-4888-9f7b-906b37b9d1f6&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d5375fa1-7060-4888-9f7b-906b37b9d1f6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T10:58:59+00:00",
        "updated_at": "2023-02-16T10:58:59+00:00",
        "number": "http://bqbl.it/d5375fa1-7060-4888-9f7b-906b37b9d1f6",
        "barcode_type": "qr_code",
        "image_url": "/uploads/94af502b5e4a59fa3c83cc6361175937/barcode/image/d5375fa1-7060-4888-9f7b-906b37b9d1f6/2ad57577-76e5-425c-9491-210cd312c394.svg",
        "owner_id": "4337d158-9f9f-452e-90f0-329e9df2cce5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4337d158-9f9f-452e-90f0-329e9df2cce5"
          },
          "data": {
            "type": "customers",
            "id": "4337d158-9f9f-452e-90f0-329e9df2cce5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "4337d158-9f9f-452e-90f0-329e9df2cce5",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T10:58:59+00:00",
        "updated_at": "2023-02-16T10:58:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4337d158-9f9f-452e-90f0-329e9df2cce5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4337d158-9f9f-452e-90f0-329e9df2cce5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4337d158-9f9f-452e-90f0-329e9df2cce5&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMmFkNGJlNzMtZWFhMS00YmUwLWI3Y2MtY2UzYzEyYjI1OWQ0&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2ad4be73-eaa1-4be0-b7cc-ce3c12b259d4",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-16T10:58:59+00:00",
        "updated_at": "2023-02-16T10:58:59+00:00",
        "number": "http://bqbl.it/2ad4be73-eaa1-4be0-b7cc-ce3c12b259d4",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c239d7a991a8d46e16e62562f19fd227/barcode/image/2ad4be73-eaa1-4be0-b7cc-ce3c12b259d4/d3b07b9c-c5f5-4c97-9209-1d1847f6cdd2.svg",
        "owner_id": "57f5d41c-2f33-4569-9cc2-c37142a6f84b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/57f5d41c-2f33-4569-9cc2-c37142a6f84b"
          },
          "data": {
            "type": "customers",
            "id": "57f5d41c-2f33-4569-9cc2-c37142a6f84b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "57f5d41c-2f33-4569-9cc2-c37142a6f84b",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T10:58:59+00:00",
        "updated_at": "2023-02-16T10:58:59+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=57f5d41c-2f33-4569-9cc2-c37142a6f84b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=57f5d41c-2f33-4569-9cc2-c37142a6f84b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=57f5d41c-2f33-4569-9cc2-c37142a6f84b&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T10:58:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/429cf3f7-8b32-4375-a8a7-15cd78f9e6d3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "429cf3f7-8b32-4375-a8a7-15cd78f9e6d3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T10:59:00+00:00",
      "updated_at": "2023-02-16T10:59:00+00:00",
      "number": "http://bqbl.it/429cf3f7-8b32-4375-a8a7-15cd78f9e6d3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c4cb9dbe61a63122bfa32b67ab845b39/barcode/image/429cf3f7-8b32-4375-a8a7-15cd78f9e6d3/15225343-d180-4ab7-a121-127e3bd5487e.svg",
      "owner_id": "ce256e70-3dec-4e98-9059-8d82737d80f2",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ce256e70-3dec-4e98-9059-8d82737d80f2"
        },
        "data": {
          "type": "customers",
          "id": "ce256e70-3dec-4e98-9059-8d82737d80f2"
        }
      }
    }
  },
  "included": [
    {
      "id": "ce256e70-3dec-4e98-9059-8d82737d80f2",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-16T10:58:59+00:00",
        "updated_at": "2023-02-16T10:59:00+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ce256e70-3dec-4e98-9059-8d82737d80f2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ce256e70-3dec-4e98-9059-8d82737d80f2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ce256e70-3dec-4e98-9059-8d82737d80f2&filter[owner_type]=customers"
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
          "owner_id": "26e63a6f-3949-4871-b1dc-7c0c6025a96c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1e40f583-9f81-411b-9175-fabe104f0754",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T10:59:00+00:00",
      "updated_at": "2023-02-16T10:59:00+00:00",
      "number": "http://bqbl.it/1e40f583-9f81-411b-9175-fabe104f0754",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a42bcfd4dde317131029e9b19e352fdf/barcode/image/1e40f583-9f81-411b-9175-fabe104f0754/037af1f2-5ebe-4955-813f-498b03a38fd4.svg",
      "owner_id": "26e63a6f-3949-4871-b1dc-7c0c6025a96c",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/e3f6c1dd-6489-4e3e-a759-a3bad6665214' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e3f6c1dd-6489-4e3e-a759-a3bad6665214",
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
    "id": "e3f6c1dd-6489-4e3e-a759-a3bad6665214",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-16T10:59:01+00:00",
      "updated_at": "2023-02-16T10:59:01+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f696c37e0029b3ce4babdb0857e29154/barcode/image/e3f6c1dd-6489-4e3e-a759-a3bad6665214/c5e35cf4-e522-4069-b5bf-d1b08db2096c.svg",
      "owner_id": "06743e52-1277-47c3-ae92-1d675bb14f02",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/dd5c1baa-edd6-472e-a0e2-e16040b63d00' \
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