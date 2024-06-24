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
      "id": "e9a55844-de79-4ee4-b61a-471c523a6948",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-24T09:22:55.186296+00:00",
        "updated_at": "2024-06-24T09:22:55.186296+00:00",
        "number": "http://bqbl.it/e9a55844-de79-4ee4-b61a-471c523a6948",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-14.lvh.me:/barcodes/e9a55844-de79-4ee4-b61a-471c523a6948/image",
        "owner_id": "3e3ff56a-0ec8-41c7-b8f1-141dfe1adee3",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3e3ff56a-0ec8-41c7-b8f1-141dfe1adee3"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0c6c3a53-ebc7-455e-a6da-ff5f50e392f1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0c6c3a53-ebc7-455e-a6da-ff5f50e392f1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-24T09:22:53.417441+00:00",
        "updated_at": "2024-06-24T09:22:53.417441+00:00",
        "number": "http://bqbl.it/0c6c3a53-ebc7-455e-a6da-ff5f50e392f1",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-12.lvh.me:/barcodes/0c6c3a53-ebc7-455e-a6da-ff5f50e392f1/image",
        "owner_id": "c6d92efe-1c72-4146-bd13-73667bae62a0",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c6d92efe-1c72-4146-bd13-73667bae62a0"
          },
          "data": {
            "type": "customers",
            "id": "c6d92efe-1c72-4146-bd13-73667bae62a0"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "c6d92efe-1c72-4146-bd13-73667bae62a0",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-24T09:22:53.379818+00:00",
        "updated_at": "2024-06-24T09:22:53.423006+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-10@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=c6d92efe-1c72-4146-bd13-73667bae62a0&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=c6d92efe-1c72-4146-bd13-73667bae62a0&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c6d92efe-1c72-4146-bd13-73667bae62a0&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZmNiMDRhYTUtZjg1ZC00MzYxLTlmYzAtY2FiMDA5NjJlNDAw&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fcb04aa5-f85d-4361-9fc0-cab00962e400",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-24T09:22:54.460343+00:00",
        "updated_at": "2024-06-24T09:22:54.460343+00:00",
        "number": "http://bqbl.it/fcb04aa5-f85d-4361-9fc0-cab00962e400",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-13.lvh.me:/barcodes/fcb04aa5-f85d-4361-9fc0-cab00962e400/image",
        "owner_id": "608d9c74-5604-4f7f-a0e4-c49b70e97b89",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/608d9c74-5604-4f7f-a0e4-c49b70e97b89"
          },
          "data": {
            "type": "customers",
            "id": "608d9c74-5604-4f7f-a0e4-c49b70e97b89"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "608d9c74-5604-4f7f-a0e4-c49b70e97b89",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-24T09:22:54.422285+00:00",
        "updated_at": "2024-06-24T09:22:54.465471+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-12@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=608d9c74-5604-4f7f-a0e4-c49b70e97b89&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=608d9c74-5604-4f7f-a0e4-c49b70e97b89&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=608d9c74-5604-4f7f-a0e4-c49b70e97b89&filter[owner_type]=customers"
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

`owner` => 
`photo`


`product` => 
`photo`










## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e5b97438-65b5-4bf7-85b8-c464b1277a80?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e5b97438-65b5-4bf7-85b8-c464b1277a80",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-24T09:22:52.587362+00:00",
      "updated_at": "2024-06-24T09:22:52.587362+00:00",
      "number": "http://bqbl.it/e5b97438-65b5-4bf7-85b8-c464b1277a80",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-11.lvh.me:/barcodes/e5b97438-65b5-4bf7-85b8-c464b1277a80/image",
      "owner_id": "69c078b5-25ad-403e-94f7-51f08b2fd98b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/69c078b5-25ad-403e-94f7-51f08b2fd98b"
        },
        "data": {
          "type": "customers",
          "id": "69c078b5-25ad-403e-94f7-51f08b2fd98b"
        }
      }
    }
  },
  "included": [
    {
      "id": "69c078b5-25ad-403e-94f7-51f08b2fd98b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-24T09:22:52.531078+00:00",
        "updated_at": "2024-06-24T09:22:52.591940+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-9@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=69c078b5-25ad-403e-94f7-51f08b2fd98b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=69c078b5-25ad-403e-94f7-51f08b2fd98b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=69c078b5-25ad-403e-94f7-51f08b2fd98b&filter[owner_type]=customers"
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

`owner` => 
`photo`


`product` => 
`photo`










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
          "owner_id": "3fbaecad-ad2c-4616-b94c-a2fece13fc4c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "48fc99f2-9e2c-4657-aa23-2599b148a41d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-24T09:22:56.878242+00:00",
      "updated_at": "2024-06-24T09:22:56.878242+00:00",
      "number": "http://bqbl.it/48fc99f2-9e2c-4657-aa23-2599b148a41d",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-16.lvh.me:/barcodes/48fc99f2-9e2c-4657-aa23-2599b148a41d/image",
      "owner_id": "3fbaecad-ad2c-4616-b94c-a2fece13fc4c",
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

`owner` => 
`photo`


`product` => 
`photo`










## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/8fae1bed-3750-476a-af71-1453a9333a76' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8fae1bed-3750-476a-af71-1453a9333a76",
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
    "id": "8fae1bed-3750-476a-af71-1453a9333a76",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-24T09:22:57.807371+00:00",
      "updated_at": "2024-06-24T09:22:57.889097+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-17.lvh.me:/barcodes/8fae1bed-3750-476a-af71-1453a9333a76/image",
      "owner_id": "73617c80-cda5-46f4-bd75-6d13c0a56cf1",
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

`owner` => 
`photo`


`product` => 
`photo`










## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/ce9753c4-24f9-4228-a2b0-352a6805664b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ce9753c4-24f9-4228-a2b0-352a6805664b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-24T09:22:55.919881+00:00",
      "updated_at": "2024-06-24T09:22:55.919881+00:00",
      "number": "http://bqbl.it/ce9753c4-24f9-4228-a2b0-352a6805664b",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-15.lvh.me:/barcodes/ce9753c4-24f9-4228-a2b0-352a6805664b/image",
      "owner_id": "dd54ff30-e4df-4da9-9b31-b9fb29a67805",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/dd54ff30-e4df-4da9-9b31-b9fb29a67805"
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

`owner` => 
`photo`


`product` => 
`photo`









