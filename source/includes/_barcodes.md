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

`PUT /api/boomerang/barcodes/{id}`

`GET /api/boomerang/barcodes/{id}`

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
      "id": "843c083f-6713-49f9-8683-572c154681cf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-07T13:56:07+00:00",
        "updated_at": "2023-12-07T13:56:07+00:00",
        "number": "http://bqbl.it/843c083f-6713-49f9-8683-572c154681cf",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-66.shop.lvh.me:/barcodes/843c083f-6713-49f9-8683-572c154681cf/image",
        "owner_id": "ec9ad4a6-1140-4e90-8f92-b11812b86787",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ec9ad4a6-1140-4e90-8f92-b11812b86787"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZWZhMzM1NTEtMzc0Yy00ZDU2LTliY2UtNTgwNjQ0NDNiMGRi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "efa33551-374c-4d56-9bce-58064443b0db",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-07T13:56:07+00:00",
        "updated_at": "2023-12-07T13:56:07+00:00",
        "number": "http://bqbl.it/efa33551-374c-4d56-9bce-58064443b0db",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-67.shop.lvh.me:/barcodes/efa33551-374c-4d56-9bce-58064443b0db/image",
        "owner_id": "484cef89-7994-4e66-ac85-2df0d4bafeeb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/484cef89-7994-4e66-ac85-2df0d4bafeeb"
          },
          "data": {
            "type": "customers",
            "id": "484cef89-7994-4e66-ac85-2df0d4bafeeb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "484cef89-7994-4e66-ac85-2df0d4bafeeb",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-07T13:56:07+00:00",
        "updated_at": "2023-12-07T13:56:07+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-16@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=484cef89-7994-4e66-ac85-2df0d4bafeeb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=484cef89-7994-4e66-ac85-2df0d4bafeeb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=484cef89-7994-4e66-ac85-2df0d4bafeeb&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb0b061fe-2419-43e0-b02b-af48f51eca09&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b0b061fe-2419-43e0-b02b-af48f51eca09",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-12-07T13:56:08+00:00",
        "updated_at": "2023-12-07T13:56:08+00:00",
        "number": "http://bqbl.it/b0b061fe-2419-43e0-b02b-af48f51eca09",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-68.shop.lvh.me:/barcodes/b0b061fe-2419-43e0-b02b-af48f51eca09/image",
        "owner_id": "d177d24c-4f92-403f-ae50-dbb259a8e138",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/d177d24c-4f92-403f-ae50-dbb259a8e138"
          },
          "data": {
            "type": "customers",
            "id": "d177d24c-4f92-403f-ae50-dbb259a8e138"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d177d24c-4f92-403f-ae50-dbb259a8e138",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-07T13:56:08+00:00",
        "updated_at": "2023-12-07T13:56:08+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-17@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=d177d24c-4f92-403f-ae50-dbb259a8e138&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d177d24c-4f92-403f-ae50-dbb259a8e138&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d177d24c-4f92-403f-ae50-dbb259a8e138&filter[owner_type]=customers"
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






## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e7bebd6d-350f-44f7-8119-f671e2bc22c3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e7bebd6d-350f-44f7-8119-f671e2bc22c3",
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
    "id": "e7bebd6d-350f-44f7-8119-f671e2bc22c3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-07T13:56:08+00:00",
      "updated_at": "2023-12-07T13:56:08+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-69.shop.lvh.me:/barcodes/e7bebd6d-350f-44f7-8119-f671e2bc22c3/image",
      "owner_id": "4dcd1ff3-8599-49ee-9c98-274b985c91bf",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ee17bb1a-0d3a-42f3-b1f5-7c912b4482bf?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ee17bb1a-0d3a-42f3-b1f5-7c912b4482bf",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-07T13:56:09+00:00",
      "updated_at": "2023-12-07T13:56:09+00:00",
      "number": "http://bqbl.it/ee17bb1a-0d3a-42f3-b1f5-7c912b4482bf",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-70.shop.lvh.me:/barcodes/ee17bb1a-0d3a-42f3-b1f5-7c912b4482bf/image",
      "owner_id": "160f5183-2c52-4aac-a9fd-57cb7f4bef39",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/160f5183-2c52-4aac-a9fd-57cb7f4bef39"
        },
        "data": {
          "type": "customers",
          "id": "160f5183-2c52-4aac-a9fd-57cb7f4bef39"
        }
      }
    }
  },
  "included": [
    {
      "id": "160f5183-2c52-4aac-a9fd-57cb7f4bef39",
      "type": "customers",
      "attributes": {
        "created_at": "2023-12-07T13:56:09+00:00",
        "updated_at": "2023-12-07T13:56:09+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-19@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=160f5183-2c52-4aac-a9fd-57cb7f4bef39&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=160f5183-2c52-4aac-a9fd-57cb7f4bef39&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=160f5183-2c52-4aac-a9fd-57cb7f4bef39&filter[owner_type]=customers"
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
          "owner_id": "e28e12de-470a-4a0c-8a18-9736c0485c92",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d7eea109-cdb7-4e63-858c-9c65c6c50b55",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-12-07T13:56:09+00:00",
      "updated_at": "2023-12-07T13:56:09+00:00",
      "number": "http://bqbl.it/d7eea109-cdb7-4e63-858c-9c65c6c50b55",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-71.shop.lvh.me:/barcodes/d7eea109-cdb7-4e63-858c-9c65c6c50b55/image",
      "owner_id": "e28e12de-470a-4a0c-8a18-9736c0485c92",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0783d2ce-822f-44fb-a7c8-cdfdc8fd96eb' \
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