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
`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes`

`POST /api/boomerang/barcodes`

`DELETE /api/boomerang/barcodes/{id}`

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


## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/cf025316-2457-44a5-83e3-9fb1a8f787c7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cf025316-2457-44a5-83e3-9fb1a8f787c7",
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
    "id": "cf025316-2457-44a5-83e3-9fb1a8f787c7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-25T09:13:41+00:00",
      "updated_at": "2023-12-25T09:13:41+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-27.shop.lvh.me:/barcodes/cf025316-2457-44a5-83e3-9fb1a8f787c7/image",
      "owner_id": "6d3a501a-8b76-4578-8719-ed7c53f34e73",
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






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/c1066bc8-91c6-4c67-84ff-036fad4789cf?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c1066bc8-91c6-4c67-84ff-036fad4789cf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-25T09:13:42+00:00",
      "updated_at": "2023-12-25T09:13:42+00:00",
      "number": "http://bqbl.it/c1066bc8-91c6-4c67-84ff-036fad4789cf",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-28.shop.lvh.me:/barcodes/c1066bc8-91c6-4c67-84ff-036fad4789cf/image",
      "owner_id": "9ce12b35-ed93-476c-8d63-a4fd25e09c38",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9ce12b35-ed93-476c-8d63-a4fd25e09c38"
        },
        "data": {
          "type": "customers",
          "id": "9ce12b35-ed93-476c-8d63-a4fd25e09c38"
        }
      }
    }
  },
  "included": [
    {
      "id": "9ce12b35-ed93-476c-8d63-a4fd25e09c38",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-25T09:13:42+00:00",
        "updated_at": "2023-12-25T09:13:42+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-18@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=9ce12b35-ed93-476c-8d63-a4fd25e09c38&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9ce12b35-ed93-476c-8d63-a4fd25e09c38&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9ce12b35-ed93-476c-8d63-a4fd25e09c38&filter[owner_type]=customers"
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






## Listing barcodes



> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNWUyZTNjZmEtOWRlZS00YzM1LTg3MzYtOTVkYzYyMDIxMTFi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5e2e3cfa-9dee-4c35-8736-95dc6202111b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-25T09:13:42+00:00",
        "updated_at": "2023-12-25T09:13:42+00:00",
        "number": "http://bqbl.it/5e2e3cfa-9dee-4c35-8736-95dc6202111b",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-29.shop.lvh.me:/barcodes/5e2e3cfa-9dee-4c35-8736-95dc6202111b/image",
        "owner_id": "53113a98-d0ae-4d0d-bbfe-798a13dbae2a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/53113a98-d0ae-4d0d-bbfe-798a13dbae2a"
          },
          "data": {
            "type": "customers",
            "id": "53113a98-d0ae-4d0d-bbfe-798a13dbae2a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "53113a98-d0ae-4d0d-bbfe-798a13dbae2a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-25T09:13:42+00:00",
        "updated_at": "2023-12-25T09:13:42+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-20@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=53113a98-d0ae-4d0d-bbfe-798a13dbae2a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=53113a98-d0ae-4d0d-bbfe-798a13dbae2a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=53113a98-d0ae-4d0d-bbfe-798a13dbae2a&filter[owner_type]=customers"
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
      "id": "3e04280f-1079-45e7-b77c-63563e7e22d6",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-25T09:13:43+00:00",
        "updated_at": "2023-12-25T09:13:43+00:00",
        "number": "http://bqbl.it/3e04280f-1079-45e7-b77c-63563e7e22d6",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-30.shop.lvh.me:/barcodes/3e04280f-1079-45e7-b77c-63563e7e22d6/image",
        "owner_id": "a0b59d31-67b2-4faf-8558-d874c908c779",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a0b59d31-67b2-4faf-8558-d874c908c779"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ffb390a0a-dfd5-42ac-9d34-f34dffb8787d&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fb390a0a-dfd5-42ac-9d34-f34dffb8787d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-25T09:13:44+00:00",
        "updated_at": "2023-12-25T09:13:44+00:00",
        "number": "http://bqbl.it/fb390a0a-dfd5-42ac-9d34-f34dffb8787d",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-31.shop.lvh.me:/barcodes/fb390a0a-dfd5-42ac-9d34-f34dffb8787d/image",
        "owner_id": "392b07e6-4da4-4436-be92-70432e67621a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/392b07e6-4da4-4436-be92-70432e67621a"
          },
          "data": {
            "type": "customers",
            "id": "392b07e6-4da4-4436-be92-70432e67621a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "392b07e6-4da4-4436-be92-70432e67621a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-25T09:13:44+00:00",
        "updated_at": "2023-12-25T09:13:44+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-22@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=392b07e6-4da4-4436-be92-70432e67621a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=392b07e6-4da4-4436-be92-70432e67621a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=392b07e6-4da4-4436-be92-70432e67621a&filter[owner_type]=customers"
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
          "owner_id": "68476f1a-c96b-483b-93ee-307d739e7782",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5a91a2f4-4d8a-4bae-bd33-b13747129b6b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-25T09:13:44+00:00",
      "updated_at": "2023-12-25T09:13:44+00:00",
      "number": "http://bqbl.it/5a91a2f4-4d8a-4bae-bd33-b13747129b6b",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-32.shop.lvh.me:/barcodes/5a91a2f4-4d8a-4bae-bd33-b13747129b6b/image",
      "owner_id": "68476f1a-c96b-483b-93ee-307d739e7782",
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






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/f7ad56c0-0828-48d6-bbd8-ac6df07b58df' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request does not accept any includes