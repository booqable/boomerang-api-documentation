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
      "id": "377e3a88-f8f4-433d-b16d-2e76c390fb2d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T14:59:21+00:00",
        "updated_at": "2023-02-08T14:59:21+00:00",
        "number": "http://bqbl.it/377e3a88-f8f4-433d-b16d-2e76c390fb2d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1726c9f8ce0bdb55cd1954356e140df8/barcode/image/377e3a88-f8f4-433d-b16d-2e76c390fb2d/f24c4861-96d2-43b3-9333-820f02ea5203.svg",
        "owner_id": "8df3bc7a-de95-468f-8cfd-13eeab431dcd",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8df3bc7a-de95-468f-8cfd-13eeab431dcd"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F86ff0334-af75-40c3-9fdd-069e7f5de0ec&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "86ff0334-af75-40c3-9fdd-069e7f5de0ec",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T14:59:21+00:00",
        "updated_at": "2023-02-08T14:59:21+00:00",
        "number": "http://bqbl.it/86ff0334-af75-40c3-9fdd-069e7f5de0ec",
        "barcode_type": "qr_code",
        "image_url": "/uploads/6ddc696907baa78ad40d47dd57b02ad7/barcode/image/86ff0334-af75-40c3-9fdd-069e7f5de0ec/0e62745b-9e9b-4a3e-93f4-bbdb41437b1d.svg",
        "owner_id": "ce6900e8-f1a3-40bf-be85-69715fccd228",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ce6900e8-f1a3-40bf-be85-69715fccd228"
          },
          "data": {
            "type": "customers",
            "id": "ce6900e8-f1a3-40bf-be85-69715fccd228"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "ce6900e8-f1a3-40bf-be85-69715fccd228",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T14:59:21+00:00",
        "updated_at": "2023-02-08T14:59:21+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=ce6900e8-f1a3-40bf-be85-69715fccd228&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ce6900e8-f1a3-40bf-be85-69715fccd228&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ce6900e8-f1a3-40bf-be85-69715fccd228&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvYjIzY2FkNTItYTk0Yy00ZDJiLTgxNTgtNDZhMmFmODliZDcy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b23cad52-a94c-4d2b-8158-46a2af89bd72",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-08T14:59:22+00:00",
        "updated_at": "2023-02-08T14:59:22+00:00",
        "number": "http://bqbl.it/b23cad52-a94c-4d2b-8158-46a2af89bd72",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bbab8c92b37e3852848ad47ae6519f04/barcode/image/b23cad52-a94c-4d2b-8158-46a2af89bd72/9f161589-2968-4fa8-a13f-cc9488222ada.svg",
        "owner_id": "69cf4b53-a569-4b89-935a-179861c0e9e7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/69cf4b53-a569-4b89-935a-179861c0e9e7"
          },
          "data": {
            "type": "customers",
            "id": "69cf4b53-a569-4b89-935a-179861c0e9e7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "69cf4b53-a569-4b89-935a-179861c0e9e7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T14:59:22+00:00",
        "updated_at": "2023-02-08T14:59:22+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=69cf4b53-a569-4b89-935a-179861c0e9e7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=69cf4b53-a569-4b89-935a-179861c0e9e7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=69cf4b53-a569-4b89-935a-179861c0e9e7&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:59:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5dd027a9-34c8-4dfa-9a0d-4ff6b07d6587?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5dd027a9-34c8-4dfa-9a0d-4ff6b07d6587",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T14:59:22+00:00",
      "updated_at": "2023-02-08T14:59:22+00:00",
      "number": "http://bqbl.it/5dd027a9-34c8-4dfa-9a0d-4ff6b07d6587",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c66081c685f9bf0c6b6513e49a0fce55/barcode/image/5dd027a9-34c8-4dfa-9a0d-4ff6b07d6587/de10a0c3-0ee9-4168-b37c-db2fb3b20ac7.svg",
      "owner_id": "9e767ea6-b88b-460c-9ecc-50f1ada1015c",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9e767ea6-b88b-460c-9ecc-50f1ada1015c"
        },
        "data": {
          "type": "customers",
          "id": "9e767ea6-b88b-460c-9ecc-50f1ada1015c"
        }
      }
    }
  },
  "included": [
    {
      "id": "9e767ea6-b88b-460c-9ecc-50f1ada1015c",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-08T14:59:22+00:00",
        "updated_at": "2023-02-08T14:59:22+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9e767ea6-b88b-460c-9ecc-50f1ada1015c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9e767ea6-b88b-460c-9ecc-50f1ada1015c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9e767ea6-b88b-460c-9ecc-50f1ada1015c&filter[owner_type]=customers"
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
          "owner_id": "683a5223-4322-44ca-887d-f89c86bd70a9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "94ca4359-feb8-43e5-96d3-209ae0d84996",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T14:59:22+00:00",
      "updated_at": "2023-02-08T14:59:22+00:00",
      "number": "http://bqbl.it/94ca4359-feb8-43e5-96d3-209ae0d84996",
      "barcode_type": "qr_code",
      "image_url": "/uploads/6cbddd7cc5bab7b5576e80e3cce4b762/barcode/image/94ca4359-feb8-43e5-96d3-209ae0d84996/0f53a847-fdb6-43f7-8020-b3b0d25fbe79.svg",
      "owner_id": "683a5223-4322-44ca-887d-f89c86bd70a9",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/49576052-5076-4bd0-8e07-8f4521faf19c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "49576052-5076-4bd0-8e07-8f4521faf19c",
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
    "id": "49576052-5076-4bd0-8e07-8f4521faf19c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-08T14:59:23+00:00",
      "updated_at": "2023-02-08T14:59:23+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/bbe6c2a1cf2c7176b69956991a2d67ad/barcode/image/49576052-5076-4bd0-8e07-8f4521faf19c/5b2fdf67-3153-4b22-a3a5-7ea2a4031125.svg",
      "owner_id": "6458e938-e450-49ea-99ba-b6d7155526a4",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/610b6945-83ad-4c91-a8a5-ed1099a01883' \
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