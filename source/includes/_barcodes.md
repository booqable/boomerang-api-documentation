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
      "id": "1653c707-6af5-43c1-ba0f-e9039509f947",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-08T11:02:22+00:00",
        "updated_at": "2022-12-08T11:02:22+00:00",
        "number": "http://bqbl.it/1653c707-6af5-43c1-ba0f-e9039509f947",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c9987bb0b3696a65d093ed95fcc0fc45/barcode/image/1653c707-6af5-43c1-ba0f-e9039509f947/e824ce43-d04b-4df6-acb8-17fc846b132b.svg",
        "owner_id": "59ca944d-843f-4f05-a75c-2fdbc3e63646",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/59ca944d-843f-4f05-a75c-2fdbc3e63646"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F5994455c-4b6a-4700-bbc0-dbe6e7fdd27b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5994455c-4b6a-4700-bbc0-dbe6e7fdd27b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-08T11:02:22+00:00",
        "updated_at": "2022-12-08T11:02:22+00:00",
        "number": "http://bqbl.it/5994455c-4b6a-4700-bbc0-dbe6e7fdd27b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/b1220ac2e5ee180d5602ce1ed665c4eb/barcode/image/5994455c-4b6a-4700-bbc0-dbe6e7fdd27b/85b0224d-b5ad-4ce5-83b4-1e4b5edc746d.svg",
        "owner_id": "1557f19d-e3aa-471d-96da-cb9003234182",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/1557f19d-e3aa-471d-96da-cb9003234182"
          },
          "data": {
            "type": "customers",
            "id": "1557f19d-e3aa-471d-96da-cb9003234182"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1557f19d-e3aa-471d-96da-cb9003234182",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-08T11:02:22+00:00",
        "updated_at": "2022-12-08T11:02:22+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=1557f19d-e3aa-471d-96da-cb9003234182&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=1557f19d-e3aa-471d-96da-cb9003234182&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1557f19d-e3aa-471d-96da-cb9003234182&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMWIzYzMxZWYtYjVmZC00YjQ2LTgwODktNzQ3NDY0NGY5ZWQ3&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1b3c31ef-b5fd-4b46-8089-7474644f9ed7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-12-08T11:02:23+00:00",
        "updated_at": "2022-12-08T11:02:23+00:00",
        "number": "http://bqbl.it/1b3c31ef-b5fd-4b46-8089-7474644f9ed7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/cebd7b3e75586dc09bd8cfca4b1be197/barcode/image/1b3c31ef-b5fd-4b46-8089-7474644f9ed7/c92da48d-4471-4ace-ab46-cf656e17abb2.svg",
        "owner_id": "34cda9a7-76d3-476b-9b3e-02f40201b083",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/34cda9a7-76d3-476b-9b3e-02f40201b083"
          },
          "data": {
            "type": "customers",
            "id": "34cda9a7-76d3-476b-9b3e-02f40201b083"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "34cda9a7-76d3-476b-9b3e-02f40201b083",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-08T11:02:23+00:00",
        "updated_at": "2022-12-08T11:02:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=34cda9a7-76d3-476b-9b3e-02f40201b083&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=34cda9a7-76d3-476b-9b3e-02f40201b083&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=34cda9a7-76d3-476b-9b3e-02f40201b083&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-08T11:02:05Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2c3b9c25-3a92-401b-8306-26fae3b68347?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2c3b9c25-3a92-401b-8306-26fae3b68347",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-08T11:02:23+00:00",
      "updated_at": "2022-12-08T11:02:23+00:00",
      "number": "http://bqbl.it/2c3b9c25-3a92-401b-8306-26fae3b68347",
      "barcode_type": "qr_code",
      "image_url": "/uploads/dd0a8b6bff32dcb150e209d7f0b6e5d7/barcode/image/2c3b9c25-3a92-401b-8306-26fae3b68347/4921352c-6dac-4f74-9319-fd0e0e89218e.svg",
      "owner_id": "9c0977db-44f0-4868-8751-347578ef33b6",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/9c0977db-44f0-4868-8751-347578ef33b6"
        },
        "data": {
          "type": "customers",
          "id": "9c0977db-44f0-4868-8751-347578ef33b6"
        }
      }
    }
  },
  "included": [
    {
      "id": "9c0977db-44f0-4868-8751-347578ef33b6",
      "type": "customers",
      "attributes": {
        "created_at": "2022-12-08T11:02:23+00:00",
        "updated_at": "2022-12-08T11:02:23+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=9c0977db-44f0-4868-8751-347578ef33b6&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=9c0977db-44f0-4868-8751-347578ef33b6&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=9c0977db-44f0-4868-8751-347578ef33b6&filter[owner_type]=customers"
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
          "owner_id": "3ac2e98b-4618-4b2e-a82a-70234ef3a8ff",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ca1e04d7-e6b2-488b-b62b-b29efb79e474",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-08T11:02:24+00:00",
      "updated_at": "2022-12-08T11:02:24+00:00",
      "number": "http://bqbl.it/ca1e04d7-e6b2-488b-b62b-b29efb79e474",
      "barcode_type": "qr_code",
      "image_url": "/uploads/598ae24a8ea79cf49c2b24ddd552a0ef/barcode/image/ca1e04d7-e6b2-488b-b62b-b29efb79e474/e4e9f591-eb6c-4b46-b08b-fc0985fccae6.svg",
      "owner_id": "3ac2e98b-4618-4b2e-a82a-70234ef3a8ff",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/c6805a82-246d-461a-b40e-fd10de57cdfa' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c6805a82-246d-461a-b40e-fd10de57cdfa",
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
    "id": "c6805a82-246d-461a-b40e-fd10de57cdfa",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-12-08T11:02:24+00:00",
      "updated_at": "2022-12-08T11:02:24+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/30e211ccf917cb829066b66c1d14ae6a/barcode/image/c6805a82-246d-461a-b40e-fd10de57cdfa/b3ea7490-fbb5-4706-a25e-5d490a7fda66.svg",
      "owner_id": "07d1f8c3-d843-45e7-a598-a74288594230",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/f930f9bf-d018-424a-8a9f-a35cf4096b65' \
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