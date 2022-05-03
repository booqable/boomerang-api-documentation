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
      "id": "3eacb0e3-eda6-49d5-8f61-07c06ead44eb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-03T10:18:02+00:00",
        "updated_at": "2022-05-03T10:18:02+00:00",
        "number": "http://bqbl.it/3eacb0e3-eda6-49d5-8f61-07c06ead44eb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/63ca740acc12062fb3eb25b9c45696d5/barcode/image/3eacb0e3-eda6-49d5-8f61-07c06ead44eb/543df9b7-1bcb-40f5-aad7-ade681629215.svg",
        "owner_id": "1d3755b5-73d5-44e3-bb1c-c5ffff4b7fca",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1d3755b5-73d5-44e3-bb1c-c5ffff4b7fca"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F7ff2a7a0-de1c-46cb-a12f-192bb7ff8819&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7ff2a7a0-de1c-46cb-a12f-192bb7ff8819",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-03T10:18:02+00:00",
        "updated_at": "2022-05-03T10:18:02+00:00",
        "number": "http://bqbl.it/7ff2a7a0-de1c-46cb-a12f-192bb7ff8819",
        "barcode_type": "qr_code",
        "image_url": "/uploads/0568376bda726ba1467e8fbc8d16a761/barcode/image/7ff2a7a0-de1c-46cb-a12f-192bb7ff8819/01f93aff-22f1-4c50-b75a-3298c00da92d.svg",
        "owner_id": "52cbf088-05ab-4975-91af-135b1f870e76",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/52cbf088-05ab-4975-91af-135b1f870e76"
          },
          "data": {
            "type": "customers",
            "id": "52cbf088-05ab-4975-91af-135b1f870e76"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "52cbf088-05ab-4975-91af-135b1f870e76",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-03T10:18:02+00:00",
        "updated_at": "2022-05-03T10:18:02+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Brakus Group",
        "email": "brakus.group@parisian.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=52cbf088-05ab-4975-91af-135b1f870e76&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=52cbf088-05ab-4975-91af-135b1f870e76&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=52cbf088-05ab-4975-91af-135b1f870e76&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMWNiZWJjNGYtNmFiMy00M2Q4LWEwNjctMmVlZjVlZWNmOTY3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1cbebc4f-6ab3-43d8-a067-2eef5eecf967",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-05-03T10:18:03+00:00",
        "updated_at": "2022-05-03T10:18:03+00:00",
        "number": "http://bqbl.it/1cbebc4f-6ab3-43d8-a067-2eef5eecf967",
        "barcode_type": "qr_code",
        "image_url": "/uploads/86f70a1fc6f46007e66c4957597491f2/barcode/image/1cbebc4f-6ab3-43d8-a067-2eef5eecf967/c342e074-4831-4c33-89c8-8731d1512f5c.svg",
        "owner_id": "999ba43e-508c-4feb-9431-1e77b0eee432",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/999ba43e-508c-4feb-9431-1e77b0eee432"
          },
          "data": {
            "type": "customers",
            "id": "999ba43e-508c-4feb-9431-1e77b0eee432"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "999ba43e-508c-4feb-9431-1e77b0eee432",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-03T10:18:03+00:00",
        "updated_at": "2022-05-03T10:18:03+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Pfannerstill-Hand",
        "email": "pfannerstill.hand@ratke.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=999ba43e-508c-4feb-9431-1e77b0eee432&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=999ba43e-508c-4feb-9431-1e77b0eee432&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=999ba43e-508c-4feb-9431-1e77b0eee432&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-03T10:17:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/07ef9e7e-5c4f-4a5c-89c1-b183121d50eb?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "07ef9e7e-5c4f-4a5c-89c1-b183121d50eb",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-03T10:18:03+00:00",
      "updated_at": "2022-05-03T10:18:03+00:00",
      "number": "http://bqbl.it/07ef9e7e-5c4f-4a5c-89c1-b183121d50eb",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cbba74c68f6b821e09e78c087d6d11eb/barcode/image/07ef9e7e-5c4f-4a5c-89c1-b183121d50eb/8d74227b-36c1-493f-9267-b52db3201838.svg",
      "owner_id": "8e3bbc43-520e-42a9-b235-941514cce835",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8e3bbc43-520e-42a9-b235-941514cce835"
        },
        "data": {
          "type": "customers",
          "id": "8e3bbc43-520e-42a9-b235-941514cce835"
        }
      }
    }
  },
  "included": [
    {
      "id": "8e3bbc43-520e-42a9-b235-941514cce835",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-03T10:18:03+00:00",
        "updated_at": "2022-05-03T10:18:03+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Sawayn Group",
        "email": "group.sawayn@wilkinson-von.name",
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
            "related": "api/boomerang/properties?filter[owner_id]=8e3bbc43-520e-42a9-b235-941514cce835&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=8e3bbc43-520e-42a9-b235-941514cce835&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8e3bbc43-520e-42a9-b235-941514cce835&filter[owner_type]=customers"
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
          "owner_id": "2d93bf34-1b7b-4aaf-89f6-705c054084a7",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bdf9b66e-9dd9-4f86-814d-f8bdc8203dd3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-03T10:18:04+00:00",
      "updated_at": "2022-05-03T10:18:04+00:00",
      "number": "http://bqbl.it/bdf9b66e-9dd9-4f86-814d-f8bdc8203dd3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9b622540d76b60adb01f7cedb91e1aca/barcode/image/bdf9b66e-9dd9-4f86-814d-f8bdc8203dd3/5b21353d-958d-4d8e-81d4-6cfe2ba855bb.svg",
      "owner_id": "2d93bf34-1b7b-4aaf-89f6-705c054084a7",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/04c740d0-1526-4c15-9c12-5ae197dc3401' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "04c740d0-1526-4c15-9c12-5ae197dc3401",
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
    "id": "04c740d0-1526-4c15-9c12-5ae197dc3401",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-05-03T10:18:04+00:00",
      "updated_at": "2022-05-03T10:18:04+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/942120972d3956302d0f8d93d0e3b12e/barcode/image/04c740d0-1526-4c15-9c12-5ae197dc3401/e35786b8-c92c-41a5-85cb-abbc7d9158f6.svg",
      "owner_id": "a7f31497-78f4-487d-b01e-0153ca4d63f6",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/414b0914-9f31-4870-a6e4-dddb0eef628a' \
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