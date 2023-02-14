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
      "id": "85a233e7-84c3-43d6-aebf-2386c60357ed",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T15:26:19+00:00",
        "updated_at": "2023-02-14T15:26:19+00:00",
        "number": "http://bqbl.it/85a233e7-84c3-43d6-aebf-2386c60357ed",
        "barcode_type": "qr_code",
        "image_url": "/uploads/057cf7710e2983a7d7146e70182ce51f/barcode/image/85a233e7-84c3-43d6-aebf-2386c60357ed/ad67de88-b130-4c61-a9af-ac77afb88676.svg",
        "owner_id": "990e6efb-8a24-4b16-97e5-6f3827e4de7c",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/990e6efb-8a24-4b16-97e5-6f3827e4de7c"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fe19ec97c-e867-49ad-8e6b-593dd7a8a31b&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e19ec97c-e867-49ad-8e6b-593dd7a8a31b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T15:26:19+00:00",
        "updated_at": "2023-02-14T15:26:19+00:00",
        "number": "http://bqbl.it/e19ec97c-e867-49ad-8e6b-593dd7a8a31b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/be7aac564ec5cc08eaafe81670521e91/barcode/image/e19ec97c-e867-49ad-8e6b-593dd7a8a31b/96ee4266-261a-42aa-8fcd-68921c85e950.svg",
        "owner_id": "59112406-2343-4c21-b532-eaec6a3d395a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/59112406-2343-4c21-b532-eaec6a3d395a"
          },
          "data": {
            "type": "customers",
            "id": "59112406-2343-4c21-b532-eaec6a3d395a"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "59112406-2343-4c21-b532-eaec6a3d395a",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T15:26:19+00:00",
        "updated_at": "2023-02-14T15:26:19+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=59112406-2343-4c21-b532-eaec6a3d395a&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=59112406-2343-4c21-b532-eaec6a3d395a&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=59112406-2343-4c21-b532-eaec6a3d395a&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTE5YTQxYzItMDEzNC00ZjM1LWFkODYtNzNhYTlkODIzMDkx&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e19a41c2-0134-4f35-ad86-73aa9d823091",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-14T15:26:20+00:00",
        "updated_at": "2023-02-14T15:26:20+00:00",
        "number": "http://bqbl.it/e19a41c2-0134-4f35-ad86-73aa9d823091",
        "barcode_type": "qr_code",
        "image_url": "/uploads/3742deaca0d550eead92357208c2b67f/barcode/image/e19a41c2-0134-4f35-ad86-73aa9d823091/a39bc500-a6de-48be-8d5d-6d1945e59687.svg",
        "owner_id": "924ab79e-4eab-4120-9161-0ea8b1b3cc07",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/924ab79e-4eab-4120-9161-0ea8b1b3cc07"
          },
          "data": {
            "type": "customers",
            "id": "924ab79e-4eab-4120-9161-0ea8b1b3cc07"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "924ab79e-4eab-4120-9161-0ea8b1b3cc07",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T15:26:20+00:00",
        "updated_at": "2023-02-14T15:26:20+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=924ab79e-4eab-4120-9161-0ea8b1b3cc07&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=924ab79e-4eab-4120-9161-0ea8b1b3cc07&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=924ab79e-4eab-4120-9161-0ea8b1b3cc07&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T15:25:58Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/7fda7eaa-7f2d-42b2-8e87-484c98470358?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7fda7eaa-7f2d-42b2-8e87-484c98470358",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T15:26:21+00:00",
      "updated_at": "2023-02-14T15:26:21+00:00",
      "number": "http://bqbl.it/7fda7eaa-7f2d-42b2-8e87-484c98470358",
      "barcode_type": "qr_code",
      "image_url": "/uploads/76c9a52a9389b1fc32c58221f05af092/barcode/image/7fda7eaa-7f2d-42b2-8e87-484c98470358/14a788d4-490e-40d5-88ca-e2b22a71c564.svg",
      "owner_id": "2cc48239-eb93-4046-9c63-34d6eb4b49fa",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/2cc48239-eb93-4046-9c63-34d6eb4b49fa"
        },
        "data": {
          "type": "customers",
          "id": "2cc48239-eb93-4046-9c63-34d6eb4b49fa"
        }
      }
    }
  },
  "included": [
    {
      "id": "2cc48239-eb93-4046-9c63-34d6eb4b49fa",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-14T15:26:20+00:00",
        "updated_at": "2023-02-14T15:26:21+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=2cc48239-eb93-4046-9c63-34d6eb4b49fa&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=2cc48239-eb93-4046-9c63-34d6eb4b49fa&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2cc48239-eb93-4046-9c63-34d6eb4b49fa&filter[owner_type]=customers"
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
          "owner_id": "a65bdb2e-c34c-4602-aa55-3bdf67bdecda",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0d8b4a35-fda4-4eb8-9b41-0f91a3fa12f9",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T15:26:21+00:00",
      "updated_at": "2023-02-14T15:26:21+00:00",
      "number": "http://bqbl.it/0d8b4a35-fda4-4eb8-9b41-0f91a3fa12f9",
      "barcode_type": "qr_code",
      "image_url": "/uploads/116d3f3761c215de673a39b08215a5f1/barcode/image/0d8b4a35-fda4-4eb8-9b41-0f91a3fa12f9/1e039334-2c9e-4105-be7c-98536fa8a9aa.svg",
      "owner_id": "a65bdb2e-c34c-4602-aa55-3bdf67bdecda",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/81ba8852-9272-4aca-9be8-760a3d73ccb5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "81ba8852-9272-4aca-9be8-760a3d73ccb5",
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
    "id": "81ba8852-9272-4aca-9be8-760a3d73ccb5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-14T15:26:22+00:00",
      "updated_at": "2023-02-14T15:26:22+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/82817e000da91d4a8fd17a034f96a743/barcode/image/81ba8852-9272-4aca-9be8-760a3d73ccb5/f6bd6f5b-ded6-493f-b975-52e5adb28fe4.svg",
      "owner_id": "8cd25fe2-ff01-4039-9195-49289727e6f8",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/346bd152-abbb-4a36-9e12-ea5c4360f466' \
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