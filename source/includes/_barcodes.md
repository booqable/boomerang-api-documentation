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
      "id": "f2b175a9-a35b-492a-8968-18a1b78aed3c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-07-10T09:15:48+00:00",
        "updated_at": "2023-07-10T09:15:48+00:00",
        "number": "http://bqbl.it/f2b175a9-a35b-492a-8968-18a1b78aed3c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3549eebfe93ac876b8b74592a480c698/barcode/image/f2b175a9-a35b-492a-8968-18a1b78aed3c/cad1d028-f8d6-453d-9c3d-2fc7c3d55530.svg",
        "owner_id": "810376d5-ca33-43b1-b315-389bb1d43310",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/810376d5-ca33-43b1-b315-389bb1d43310"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F240c9093-9629-4e20-b639-064c3846bfb2&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "240c9093-9629-4e20-b639-064c3846bfb2",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-07-10T09:15:48+00:00",
        "updated_at": "2023-07-10T09:15:48+00:00",
        "number": "http://bqbl.it/240c9093-9629-4e20-b639-064c3846bfb2",
        "barcode_type": "qr_code",
        "image_url": "/uploads/a45e345872c214e44d7a90738e8781f0/barcode/image/240c9093-9629-4e20-b639-064c3846bfb2/02acd323-cea4-4842-a957-1c232d914e6e.svg",
        "owner_id": "58ee18fe-2a61-4278-9ebd-321f14866bc8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/58ee18fe-2a61-4278-9ebd-321f14866bc8"
          },
          "data": {
            "type": "customers",
            "id": "58ee18fe-2a61-4278-9ebd-321f14866bc8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "58ee18fe-2a61-4278-9ebd-321f14866bc8",
      "type": "customers",
      "attributes": {
        "created_at": "2023-07-10T09:15:48+00:00",
        "updated_at": "2023-07-10T09:15:48+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=58ee18fe-2a61-4278-9ebd-321f14866bc8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=58ee18fe-2a61-4278-9ebd-321f14866bc8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=58ee18fe-2a61-4278-9ebd-321f14866bc8&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvODRjYzE5ZmMtOWM3My00NmE1LWE0ZGItYzU3NTE0MGU1YmRh&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "84cc19fc-9c73-46a5-a4db-c575140e5bda",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-07-10T09:15:49+00:00",
        "updated_at": "2023-07-10T09:15:49+00:00",
        "number": "http://bqbl.it/84cc19fc-9c73-46a5-a4db-c575140e5bda",
        "barcode_type": "qr_code",
        "image_url": "/uploads/776dafd1be30f84208712326431306ea/barcode/image/84cc19fc-9c73-46a5-a4db-c575140e5bda/3bbcb7ad-a1cf-49eb-a08e-ebe6f9cf1a23.svg",
        "owner_id": "1fe996a6-7016-4778-94c2-44f97950f982",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1fe996a6-7016-4778-94c2-44f97950f982"
          },
          "data": {
            "type": "customers",
            "id": "1fe996a6-7016-4778-94c2-44f97950f982"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1fe996a6-7016-4778-94c2-44f97950f982",
      "type": "customers",
      "attributes": {
        "created_at": "2023-07-10T09:15:49+00:00",
        "updated_at": "2023-07-10T09:15:49+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1fe996a6-7016-4778-94c2-44f97950f982&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1fe996a6-7016-4778-94c2-44f97950f982&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1fe996a6-7016-4778-94c2-44f97950f982&filter[owner_type]=customers"
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






## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e107a4e7-d555-4e8f-a6c6-bb4ee16fd51e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e107a4e7-d555-4e8f-a6c6-bb4ee16fd51e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-07-10T09:15:49+00:00",
      "updated_at": "2023-07-10T09:15:49+00:00",
      "number": "http://bqbl.it/e107a4e7-d555-4e8f-a6c6-bb4ee16fd51e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/54efad5787dbfc3d4e5ca904b95ee34c/barcode/image/e107a4e7-d555-4e8f-a6c6-bb4ee16fd51e/b57c0770-bd83-43c3-a57e-8c4fcb42d09f.svg",
      "owner_id": "854a827a-a1b8-45e2-a94e-0389ec2584bf",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/854a827a-a1b8-45e2-a94e-0389ec2584bf"
        },
        "data": {
          "type": "customers",
          "id": "854a827a-a1b8-45e2-a94e-0389ec2584bf"
        }
      }
    }
  },
  "included": [
    {
      "id": "854a827a-a1b8-45e2-a94e-0389ec2584bf",
      "type": "customers",
      "attributes": {
        "created_at": "2023-07-10T09:15:49+00:00",
        "updated_at": "2023-07-10T09:15:49+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=854a827a-a1b8-45e2-a94e-0389ec2584bf&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=854a827a-a1b8-45e2-a94e-0389ec2584bf&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=854a827a-a1b8-45e2-a94e-0389ec2584bf&filter[owner_type]=customers"
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
          "owner_id": "a1a59488-5a72-4628-9ef6-4b7b23478bb2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e2daa9cd-846f-445b-8a0b-3943bf87b62f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-07-10T09:15:50+00:00",
      "updated_at": "2023-07-10T09:15:50+00:00",
      "number": "http://bqbl.it/e2daa9cd-846f-445b-8a0b-3943bf87b62f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e8d52c729904f8b0985524f06ef3e011/barcode/image/e2daa9cd-846f-445b-8a0b-3943bf87b62f/541e09e4-f860-4e90-8bc4-996f1f63141b.svg",
      "owner_id": "a1a59488-5a72-4628-9ef6-4b7b23478bb2",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/20022617-0d9d-4b60-b587-82feabcc6a22' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "20022617-0d9d-4b60-b587-82feabcc6a22",
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
    "id": "20022617-0d9d-4b60-b587-82feabcc6a22",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-07-10T09:15:50+00:00",
      "updated_at": "2023-07-10T09:15:50+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/1dff87d7e48a1a6b719516fa4706e572/barcode/image/20022617-0d9d-4b60-b587-82feabcc6a22/8ba489b7-c953-48e1-8c56-fc19336fbd4f.svg",
      "owner_id": "3b390827-11d5-45e2-abcd-4b1b320a4044",
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






## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/e13b0fa5-0159-4eeb-9002-e8e34aef9f1b' \
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