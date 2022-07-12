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
      "id": "bd1060b1-27d3-4923-a096-f8b9a99994d7",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-12T14:11:25+00:00",
        "updated_at": "2022-07-12T14:11:25+00:00",
        "number": "http://bqbl.it/bd1060b1-27d3-4923-a096-f8b9a99994d7",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8d4c077f43099a3a4d0a45866e9128da/barcode/image/bd1060b1-27d3-4923-a096-f8b9a99994d7/2dd44af6-3f74-4b23-8639-9de21ff481b2.svg",
        "owner_id": "7fec55be-e4f7-4251-84b9-2ca4cc7f984a",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7fec55be-e4f7-4251-84b9-2ca4cc7f984a"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F28912d9e-e450-42cf-91da-4277f95e45bd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "28912d9e-e450-42cf-91da-4277f95e45bd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-12T14:11:25+00:00",
        "updated_at": "2022-07-12T14:11:25+00:00",
        "number": "http://bqbl.it/28912d9e-e450-42cf-91da-4277f95e45bd",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d47d147852ae9a284837975fa3216e96/barcode/image/28912d9e-e450-42cf-91da-4277f95e45bd/a87b5ffe-edb7-4de2-9e3d-f9c7c3aa36ee.svg",
        "owner_id": "21cca82a-c092-4a91-ad29-059b001904cb",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/21cca82a-c092-4a91-ad29-059b001904cb"
          },
          "data": {
            "type": "customers",
            "id": "21cca82a-c092-4a91-ad29-059b001904cb"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "21cca82a-c092-4a91-ad29-059b001904cb",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-12T14:11:25+00:00",
        "updated_at": "2022-07-12T14:11:25+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Kunde-Metz",
        "email": "kunde_metz@jones.net",
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
            "related": "api/boomerang/properties?filter[owner_id]=21cca82a-c092-4a91-ad29-059b001904cb&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=21cca82a-c092-4a91-ad29-059b001904cb&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=21cca82a-c092-4a91-ad29-059b001904cb&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNzQxYzZkYzMtN2IwYS00NWRkLTlmNWItMzM4NDViYTQyZWQ1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "741c6dc3-7b0a-45dd-9f5b-33845ba42ed5",
      "type": "barcodes",
      "attributes": {
        "created_at": "2022-07-12T14:11:26+00:00",
        "updated_at": "2022-07-12T14:11:26+00:00",
        "number": "http://bqbl.it/741c6dc3-7b0a-45dd-9f5b-33845ba42ed5",
        "barcode_type": "qr_code",
        "image_url": "/uploads/29bf9a8a8843a2e30d347077c47babb2/barcode/image/741c6dc3-7b0a-45dd-9f5b-33845ba42ed5/a9e44511-8e97-42ea-a838-104e28e95442.svg",
        "owner_id": "88e8e856-64dc-4f97-8eb0-b65b19042b7b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/88e8e856-64dc-4f97-8eb0-b65b19042b7b"
          },
          "data": {
            "type": "customers",
            "id": "88e8e856-64dc-4f97-8eb0-b65b19042b7b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "88e8e856-64dc-4f97-8eb0-b65b19042b7b",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-12T14:11:26+00:00",
        "updated_at": "2022-07-12T14:11:26+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Mueller-Sawayn",
        "email": "sawayn_mueller@braun.com",
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
            "related": "api/boomerang/properties?filter[owner_id]=88e8e856-64dc-4f97-8eb0-b65b19042b7b&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=88e8e856-64dc-4f97-8eb0-b65b19042b7b&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=88e8e856-64dc-4f97-8eb0-b65b19042b7b&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T14:11:09Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/5fb3b8cc-44c0-48ec-a5c6-219a5e5c9d93?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5fb3b8cc-44c0-48ec-a5c6-219a5e5c9d93",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-12T14:11:26+00:00",
      "updated_at": "2022-07-12T14:11:26+00:00",
      "number": "http://bqbl.it/5fb3b8cc-44c0-48ec-a5c6-219a5e5c9d93",
      "barcode_type": "qr_code",
      "image_url": "/uploads/699643093bfdcb99da94fd3b978232e0/barcode/image/5fb3b8cc-44c0-48ec-a5c6-219a5e5c9d93/c2d6a2e6-c43f-4d84-a2fc-2d29f65587ad.svg",
      "owner_id": "0a5062db-2fc8-4429-8842-1e5d3c5b0347",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/0a5062db-2fc8-4429-8842-1e5d3c5b0347"
        },
        "data": {
          "type": "customers",
          "id": "0a5062db-2fc8-4429-8842-1e5d3c5b0347"
        }
      }
    }
  },
  "included": [
    {
      "id": "0a5062db-2fc8-4429-8842-1e5d3c5b0347",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-12T14:11:26+00:00",
        "updated_at": "2022-07-12T14:11:26+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Baumbach-Donnelly",
        "email": "donnelly_baumbach@mclaughlin.co",
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
            "related": "api/boomerang/properties?filter[owner_id]=0a5062db-2fc8-4429-8842-1e5d3c5b0347&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0a5062db-2fc8-4429-8842-1e5d3c5b0347&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0a5062db-2fc8-4429-8842-1e5d3c5b0347&filter[owner_type]=customers"
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
          "owner_id": "887a0149-8365-4a99-87a2-d7bffa31ff72",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b69e59cc-5e4e-42fa-8224-9a3ee9ad0b60",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-12T14:11:28+00:00",
      "updated_at": "2022-07-12T14:11:28+00:00",
      "number": "http://bqbl.it/b69e59cc-5e4e-42fa-8224-9a3ee9ad0b60",
      "barcode_type": "qr_code",
      "image_url": "/uploads/9234180b19b1d1a83edcc421d1936b16/barcode/image/b69e59cc-5e4e-42fa-8224-9a3ee9ad0b60/55700f4f-b697-41e0-bd25-e0fa6e03d92e.svg",
      "owner_id": "887a0149-8365-4a99-87a2-d7bffa31ff72",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2d25d0c0-f3f2-4d0b-8c8e-3ec54e7823e7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2d25d0c0-f3f2-4d0b-8c8e-3ec54e7823e7",
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
    "id": "2d25d0c0-f3f2-4d0b-8c8e-3ec54e7823e7",
    "type": "barcodes",
    "attributes": {
      "created_at": "2022-07-12T14:11:29+00:00",
      "updated_at": "2022-07-12T14:11:29+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/f27895dde5efee63e2d62159d585c97f/barcode/image/2d25d0c0-f3f2-4d0b-8c8e-3ec54e7823e7/0e5770d2-38b4-4e08-9bf4-94409cab35f7.svg",
      "owner_id": "db704d3f-dba0-4b04-a866-58a7785b0038",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/9f155c75-3fa5-47ff-ab58-2dea7909c0a3' \
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