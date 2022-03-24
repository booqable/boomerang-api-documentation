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
      "id": "8a3df77c-19ea-4947-a7b0-ae1fb4e31779",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-24T12:36:00+00:00",
        "updated_at": "2022-03-24T12:36:00+00:00",
        "number": "http://bqbl.it/8a3df77c-19ea-4947-a7b0-ae1fb4e31779",
        "barcode_type": "qr_code",
        "image_url": "/uploads/9306db61e50adbc36b0227033f605bf2/barcode/image/8a3df77c-19ea-4947-a7b0-ae1fb4e31779/0848f041-a8b5-4710-b7be-d4e9ba410096.svg",
        "owner_id": "fa35f1fa-dd89-4302-bc83-63d644ebb87e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fa35f1fa-dd89-4302-bc83-63d644ebb87e"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0a69f77b-2637-4f5b-8b92-4f37800fb02e&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0a69f77b-2637-4f5b-8b92-4f37800fb02e",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-24T12:36:00+00:00",
        "updated_at": "2022-03-24T12:36:00+00:00",
        "number": "http://bqbl.it/0a69f77b-2637-4f5b-8b92-4f37800fb02e",
        "barcode_type": "qr_code",
        "image_url": "/uploads/1b9d98c0e8b53c401bcac79743971e2f/barcode/image/0a69f77b-2637-4f5b-8b92-4f37800fb02e/b42b9580-c053-4b28-aa41-8976d9b05e0f.svg",
        "owner_id": "5f05f3d7-bc50-4fad-bec7-b7e5ed933ba9",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5f05f3d7-bc50-4fad-bec7-b7e5ed933ba9"
          },
          "data": {
            "type": "customers",
            "id": "5f05f3d7-bc50-4fad-bec7-b7e5ed933ba9"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5f05f3d7-bc50-4fad-bec7-b7e5ed933ba9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-24T12:36:00+00:00",
        "updated_at": "2022-03-24T12:36:00+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Farrell-Runolfsson",
        "email": "runolfsson.farrell@raynor.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=5f05f3d7-bc50-4fad-bec7-b7e5ed933ba9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5f05f3d7-bc50-4fad-bec7-b7e5ed933ba9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5f05f3d7-bc50-4fad-bec7-b7e5ed933ba9&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvN2M5MTE3NTAtYzBmZi00MTIwLThlZjQtZGUxMzIyNDE0NWQx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7c911750-c0ff-4120-8ef4-de13224145d1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-03-24T12:36:01+00:00",
        "updated_at": "2022-03-24T12:36:01+00:00",
        "number": "http://bqbl.it/7c911750-c0ff-4120-8ef4-de13224145d1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d30dc0e2340547b979527a1a2e057dfb/barcode/image/7c911750-c0ff-4120-8ef4-de13224145d1/32dc0d97-6660-44ce-889a-be3f921ef0fa.svg",
        "owner_id": "517b3a6b-b393-4638-a2e0-c28287ff1b30",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/517b3a6b-b393-4638-a2e0-c28287ff1b30"
          },
          "data": {
            "type": "customers",
            "id": "517b3a6b-b393-4638-a2e0-c28287ff1b30"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "517b3a6b-b393-4638-a2e0-c28287ff1b30",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-24T12:36:01+00:00",
        "updated_at": "2022-03-24T12:36:01+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Goldner and Sons",
        "email": "sons.and.goldner@mante.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=517b3a6b-b393-4638-a2e0-c28287ff1b30&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=517b3a6b-b393-4638-a2e0-c28287ff1b30&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=517b3a6b-b393-4638-a2e0-c28287ff1b30&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-24T12:35:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/88f1243e-9e59-4b70-a439-cf109091ecb1?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "88f1243e-9e59-4b70-a439-cf109091ecb1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-24T12:36:01+00:00",
      "updated_at": "2022-03-24T12:36:01+00:00",
      "number": "http://bqbl.it/88f1243e-9e59-4b70-a439-cf109091ecb1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/83f9d6ee4b8991a4029a8eecca77b980/barcode/image/88f1243e-9e59-4b70-a439-cf109091ecb1/786c1c51-5e51-445a-b509-e705d2d1c8b0.svg",
      "owner_id": "ac7a8ebe-9d5f-4bfb-8a18-42eb42eb2694",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ac7a8ebe-9d5f-4bfb-8a18-42eb42eb2694"
        },
        "data": {
          "type": "customers",
          "id": "ac7a8ebe-9d5f-4bfb-8a18-42eb42eb2694"
        }
      }
    }
  },
  "included": [
    {
      "id": "ac7a8ebe-9d5f-4bfb-8a18-42eb42eb2694",
      "type": "customers",
      "attributes": {
        "created_at": "2022-03-24T12:36:01+00:00",
        "updated_at": "2022-03-24T12:36:01+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Walter, Ankunding and Willms",
        "email": "and_walter_willms_ankunding@damore.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=ac7a8ebe-9d5f-4bfb-8a18-42eb42eb2694&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=ac7a8ebe-9d5f-4bfb-8a18-42eb42eb2694&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ac7a8ebe-9d5f-4bfb-8a18-42eb42eb2694&filter[owner_type]=customers"
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
          "owner_id": "a06f9190-3697-4aca-9b31-8be4746ac518",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2bb8525a-7ff7-44c9-93e5-3a1c6bd5cc60",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-24T12:36:02+00:00",
      "updated_at": "2022-03-24T12:36:02+00:00",
      "number": "http://bqbl.it/2bb8525a-7ff7-44c9-93e5-3a1c6bd5cc60",
      "barcode_type": "qr_code",
      "image_url": "/uploads/e12b2da242a31764693e5e9771fe3aa0/barcode/image/2bb8525a-7ff7-44c9-93e5-3a1c6bd5cc60/d120a65e-8398-491b-a14c-92a901ec0d75.svg",
      "owner_id": "a06f9190-3697-4aca-9b31-8be4746ac518",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a144e987-e2de-4769-8b56-097c509e78af' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a144e987-e2de-4769-8b56-097c509e78af",
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
    "id": "a144e987-e2de-4769-8b56-097c509e78af",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-03-24T12:36:03+00:00",
      "updated_at": "2022-03-24T12:36:03+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/80edc8543bb71b1bcf36bce1b5ad6ee0/barcode/image/a144e987-e2de-4769-8b56-097c509e78af/69a8e5bc-9593-4726-870a-9e6df553ca76.svg",
      "owner_id": "eb413112-5b6b-4ce1-b87e-224ee969110b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/ca183550-2889-4480-be7f-15401a422fae' \
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