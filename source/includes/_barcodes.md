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
      "id": "4b533bb5-451d-4e0d-98af-46d7e336bfe1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-07T06:50:50+00:00",
        "updated_at": "2022-06-07T06:50:50+00:00",
        "number": "http://bqbl.it/4b533bb5-451d-4e0d-98af-46d7e336bfe1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/48c5e97791029682094f1145f2189f5e/barcode/image/4b533bb5-451d-4e0d-98af-46d7e336bfe1/e2d25b74-1278-4075-b181-337f9dd2fd5f.svg",
        "owner_id": "3e5ea0b9-96b3-48ff-894c-b5f842a3474d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3e5ea0b9-96b3-48ff-894c-b5f842a3474d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F76d333d0-cf3f-485a-9162-3918df5beabf&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "76d333d0-cf3f-485a-9162-3918df5beabf",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-07T06:50:51+00:00",
        "updated_at": "2022-06-07T06:50:51+00:00",
        "number": "http://bqbl.it/76d333d0-cf3f-485a-9162-3918df5beabf",
        "barcode_type": "qr_code",
        "image_url": "/uploads/ce6c1b3b3f3bbe715b5f68b283d49bdb/barcode/image/76d333d0-cf3f-485a-9162-3918df5beabf/d03e5885-3bce-4f40-83fb-4ec90277a208.svg",
        "owner_id": "2cf58eb0-eef9-4050-aa8a-234981eeb5f8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2cf58eb0-eef9-4050-aa8a-234981eeb5f8"
          },
          "data": {
            "type": "customers",
            "id": "2cf58eb0-eef9-4050-aa8a-234981eeb5f8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "2cf58eb0-eef9-4050-aa8a-234981eeb5f8",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-07T06:50:51+00:00",
        "updated_at": "2022-06-07T06:50:51+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Crist and Sons",
        "email": "crist_and_sons@schneider.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=2cf58eb0-eef9-4050-aa8a-234981eeb5f8&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2cf58eb0-eef9-4050-aa8a-234981eeb5f8&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2cf58eb0-eef9-4050-aa8a-234981eeb5f8&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvM2UyZmZkZGUtZWY1Yy00OGQwLWIyYWItYzc1ZDE0MjQ1ZjZk&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3e2ffdde-ef5c-48d0-b2ab-c75d14245f6d",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-06-07T06:50:51+00:00",
        "updated_at": "2022-06-07T06:50:51+00:00",
        "number": "http://bqbl.it/3e2ffdde-ef5c-48d0-b2ab-c75d14245f6d",
        "barcode_type": "qr_code",
        "image_url": "/uploads/72a203c846b345a8c0d087fcfbd193ad/barcode/image/3e2ffdde-ef5c-48d0-b2ab-c75d14245f6d/9672e9c7-f92c-4eb7-a3c1-f95cd03a8dfe.svg",
        "owner_id": "f66cd9b7-d433-4448-8d73-009af78f8ac5",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f66cd9b7-d433-4448-8d73-009af78f8ac5"
          },
          "data": {
            "type": "customers",
            "id": "f66cd9b7-d433-4448-8d73-009af78f8ac5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "f66cd9b7-d433-4448-8d73-009af78f8ac5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-07T06:50:51+00:00",
        "updated_at": "2022-06-07T06:50:51+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Zboncak-Cummings",
        "email": "zboncak_cummings@waelchi.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=f66cd9b7-d433-4448-8d73-009af78f8ac5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f66cd9b7-d433-4448-8d73-009af78f8ac5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f66cd9b7-d433-4448-8d73-009af78f8ac5&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-07T06:50:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7c7237e8-2776-4802-a29f-c30f426cc67e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7c7237e8-2776-4802-a29f-c30f426cc67e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-07T06:50:51+00:00",
      "updated_at": "2022-06-07T06:50:51+00:00",
      "number": "http://bqbl.it/7c7237e8-2776-4802-a29f-c30f426cc67e",
      "barcode_type": "qr_code",
      "image_url": "/uploads/cffad56bbb4c3f5fabc440107539b94f/barcode/image/7c7237e8-2776-4802-a29f-c30f426cc67e/d0ef24ae-8b24-49c2-93cc-db18d521c6d4.svg",
      "owner_id": "ac1750d5-ddba-4c2c-bc60-f98db046de20",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ac1750d5-ddba-4c2c-bc60-f98db046de20"
        },
        "data": {
          "type": "customers",
          "id": "ac1750d5-ddba-4c2c-bc60-f98db046de20"
        }
      }
    }
  },
  "included": [
    {
      "id": "ac1750d5-ddba-4c2c-bc60-f98db046de20",
      "type": "customers",
      "attributes": {
        "created_at": "2022-06-07T06:50:51+00:00",
        "updated_at": "2022-06-07T06:50:51+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Oberbrunner and Sons",
        "email": "oberbrunner_sons_and@medhurst-goyette.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=ac1750d5-ddba-4c2c-bc60-f98db046de20&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ac1750d5-ddba-4c2c-bc60-f98db046de20&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ac1750d5-ddba-4c2c-bc60-f98db046de20&filter[owner_type]=customers"
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
          "owner_id": "7578905d-914b-46d6-9ae0-58ff542a5b72",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0e24b1db-b1c0-4915-9f43-8650816d6b78",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-07T06:50:52+00:00",
      "updated_at": "2022-06-07T06:50:52+00:00",
      "number": "http://bqbl.it/0e24b1db-b1c0-4915-9f43-8650816d6b78",
      "barcode_type": "qr_code",
      "image_url": "/uploads/93bc0d1191498f4ad4fbfe4b21b3eb82/barcode/image/0e24b1db-b1c0-4915-9f43-8650816d6b78/12f61cf3-61f8-4034-b7ad-d1c2714b2e54.svg",
      "owner_id": "7578905d-914b-46d6-9ae0-58ff542a5b72",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c362950f-75b5-488b-a027-c154d49ebb34' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c362950f-75b5-488b-a027-c154d49ebb34",
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
    "id": "c362950f-75b5-488b-a027-c154d49ebb34",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-06-07T06:50:52+00:00",
      "updated_at": "2022-06-07T06:50:52+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/a6424c41f4eea032a3c00b4c6646efcb/barcode/image/c362950f-75b5-488b-a027-c154d49ebb34/f3bd1bd7-eb32-4202-abdf-03dbe68dad9b.svg",
      "owner_id": "349d1300-15c9-4af1-8a70-07dd1070af5e",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/469c24c8-e677-4e67-a017-7afed7382c99' \
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