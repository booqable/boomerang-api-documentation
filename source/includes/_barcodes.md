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
`POST /api/boomerang/barcodes`

`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

`DELETE /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

## Fields
Every barcode has the following fields:

Name | Description
-- | --
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
-- | --
`owner` | **Customer, Product, Order, Stock item**<br>Associated Owner


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
          "owner_id": "afd21e7c-4530-428a-bf50-23460126fa8a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "eed0ac09-fa12-421e-b837-db0f7ff470c0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-13T09:27:44+00:00",
      "updated_at": "2024-05-13T09:27:44+00:00",
      "number": "http://bqbl.it/eed0ac09-fa12-421e-b837-db0f7ff470c0",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-184.lvh.me:/barcodes/eed0ac09-fa12-421e-b837-db0f7ff470c0/image",
      "owner_id": "afd21e7c-4530-428a-bf50-23460126fa8a",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f86ca0f3-a087-47bd-9bf8-7f2af1d9a7d6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f86ca0f3-a087-47bd-9bf8-7f2af1d9a7d6",
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
    "id": "f86ca0f3-a087-47bd-9bf8-7f2af1d9a7d6",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-13T09:27:44+00:00",
      "updated_at": "2024-05-13T09:27:45+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-185.lvh.me:/barcodes/f86ca0f3-a087-47bd-9bf8-7f2af1d9a7d6/image",
      "owner_id": "4f510317-988a-4884-9dca-451d17f4d276",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][number]` | **String** <br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one. When using a URL, it's advised to base64 encode the number before filtering.
`data[attributes][barcode_type]` | **String** <br>One of `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Listing barcodes



> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F4fd59734-d63d-4fac-b4ad-466c3c77a96a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4fd59734-d63d-4fac-b4ad-466c3c77a96a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-05-13T09:27:45+00:00",
        "updated_at": "2024-05-13T09:27:45+00:00",
        "number": "http://bqbl.it/4fd59734-d63d-4fac-b4ad-466c3c77a96a",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-186.lvh.me:/barcodes/4fd59734-d63d-4fac-b4ad-466c3c77a96a/image",
        "owner_id": "a8f8fe83-69a4-412d-9e1b-51cec88966e0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a8f8fe83-69a4-412d-9e1b-51cec88966e0"
          },
          "data": {
            "type": "customers",
            "id": "a8f8fe83-69a4-412d-9e1b-51cec88966e0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a8f8fe83-69a4-412d-9e1b-51cec88966e0",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-13T09:27:45+00:00",
        "updated_at": "2024-05-13T09:27:45+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-57@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=a8f8fe83-69a4-412d-9e1b-51cec88966e0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a8f8fe83-69a4-412d-9e1b-51cec88966e0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a8f8fe83-69a4-412d-9e1b-51cec88966e0&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


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
      "id": "af3910b8-46c9-4fb9-bdc2-7481b36843a6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-05-13T09:27:46+00:00",
        "updated_at": "2024-05-13T09:27:46+00:00",
        "number": "http://bqbl.it/af3910b8-46c9-4fb9-bdc2-7481b36843a6",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-187.lvh.me:/barcodes/af3910b8-46c9-4fb9-bdc2-7481b36843a6/image",
        "owner_id": "a72fdcaf-4374-4b84-a72d-7a6cc9b2336c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a72fdcaf-4374-4b84-a72d-7a6cc9b2336c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjNlMzA5ZWYtZjU2My00MGU4LTk4MWMtZWM5MjUzM2Q2NzBi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "63e309ef-f563-40e8-981c-ec92533d670b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-05-13T09:27:48+00:00",
        "updated_at": "2024-05-13T09:27:48+00:00",
        "number": "http://bqbl.it/63e309ef-f563-40e8-981c-ec92533d670b",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-188.lvh.me:/barcodes/63e309ef-f563-40e8-981c-ec92533d670b/image",
        "owner_id": "9be9497d-80a9-42d4-98d3-0ab24441f55c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9be9497d-80a9-42d4-98d3-0ab24441f55c"
          },
          "data": {
            "type": "customers",
            "id": "9be9497d-80a9-42d4-98d3-0ab24441f55c"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "9be9497d-80a9-42d4-98d3-0ab24441f55c",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-13T09:27:48+00:00",
        "updated_at": "2024-05-13T09:27:48+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-60@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=9be9497d-80a9-42d4-98d3-0ab24441f55c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9be9497d-80a9-42d4-98d3-0ab24441f55c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9be9497d-80a9-42d4-98d3-0ab24441f55c&filter[owner_type]=customers"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
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
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/aa120d52-e6f6-429d-ad48-c774a80cff41' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aa120d52-e6f6-429d-ad48-c774a80cff41",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-13T09:27:49+00:00",
      "updated_at": "2024-05-13T09:27:49+00:00",
      "number": "http://bqbl.it/aa120d52-e6f6-429d-ad48-c774a80cff41",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-189.lvh.me:/barcodes/aa120d52-e6f6-429d-ad48-c774a80cff41/image",
      "owner_id": "698db507-52f2-43d3-9e50-2f100fdad43b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/698db507-52f2-43d3-9e50-2f100fdad43b"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner`






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/7c575c1e-ae35-48d6-a4da-ba56eb2851a0?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7c575c1e-ae35-48d6-a4da-ba56eb2851a0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-05-13T09:27:50+00:00",
      "updated_at": "2024-05-13T09:27:50+00:00",
      "number": "http://bqbl.it/7c575c1e-ae35-48d6-a4da-ba56eb2851a0",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-190.lvh.me:/barcodes/7c575c1e-ae35-48d6-a4da-ba56eb2851a0/image",
      "owner_id": "1d495e83-1587-44d0-b757-24b8189be606",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1d495e83-1587-44d0-b757-24b8189be606"
        },
        "data": {
          "type": "customers",
          "id": "1d495e83-1587-44d0-b757-24b8189be606"
        }
      }
    }
  },
  "included": [
    {
      "id": "1d495e83-1587-44d0-b757-24b8189be606",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-13T09:27:50+00:00",
        "updated_at": "2024-05-13T09:27:50+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-62@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=1d495e83-1587-44d0-b757-24b8189be606&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1d495e83-1587-44d0-b757-24b8189be606&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1d495e83-1587-44d0-b757-24b8189be606&filter[owner_type]=customers"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner`





