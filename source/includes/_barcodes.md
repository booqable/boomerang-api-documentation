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
      "id": "1b53c3b5-4018-4231-8349-9f309d59775b",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-27T10:45:31+00:00",
        "updated_at": "2023-02-27T10:45:31+00:00",
        "number": "http://bqbl.it/1b53c3b5-4018-4231-8349-9f309d59775b",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d0efbee26c2549cd1c71c07d5db00deb/barcode/image/1b53c3b5-4018-4231-8349-9f309d59775b/24df31a2-e632-4218-8a12-10dcb312b330.svg",
        "owner_id": "659cb07a-47a9-437f-9861-b5ddce5400ce",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/659cb07a-47a9-437f-9861-b5ddce5400ce"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F0893a046-0b93-470c-a005-bfdfd15b77fc&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0893a046-0b93-470c-a005-bfdfd15b77fc",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-27T10:45:31+00:00",
        "updated_at": "2023-02-27T10:45:31+00:00",
        "number": "http://bqbl.it/0893a046-0b93-470c-a005-bfdfd15b77fc",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f79a30972924638ea06088684bb7e4bf/barcode/image/0893a046-0b93-470c-a005-bfdfd15b77fc/c93fda6f-19c6-46a7-a8a8-106a852beae0.svg",
        "owner_id": "068ee4e2-0578-4faf-add8-bbfe49bc5113",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/068ee4e2-0578-4faf-add8-bbfe49bc5113"
          },
          "data": {
            "type": "customers",
            "id": "068ee4e2-0578-4faf-add8-bbfe49bc5113"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "068ee4e2-0578-4faf-add8-bbfe49bc5113",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-27T10:45:31+00:00",
        "updated_at": "2023-02-27T10:45:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=068ee4e2-0578-4faf-add8-bbfe49bc5113&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=068ee4e2-0578-4faf-add8-bbfe49bc5113&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=068ee4e2-0578-4faf-add8-bbfe49bc5113&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZGU5ZDZiYmItN2ZmNC00OTQ1LTg5ZTMtNGVhYzEyYjMxMWI5&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "de9d6bbb-7ff4-4945-89e3-4eac12b311b9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-27T10:45:31+00:00",
        "updated_at": "2023-02-27T10:45:31+00:00",
        "number": "http://bqbl.it/de9d6bbb-7ff4-4945-89e3-4eac12b311b9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/c44ce33f0462b5a9db0f382c10ebc982/barcode/image/de9d6bbb-7ff4-4945-89e3-4eac12b311b9/1b0ef0a8-92b9-4664-bc09-8202bb285e31.svg",
        "owner_id": "188517ec-5e28-43bc-866e-d79c4dbf16b7",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/188517ec-5e28-43bc-866e-d79c4dbf16b7"
          },
          "data": {
            "type": "customers",
            "id": "188517ec-5e28-43bc-866e-d79c4dbf16b7"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "188517ec-5e28-43bc-866e-d79c4dbf16b7",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-27T10:45:31+00:00",
        "updated_at": "2023-02-27T10:45:31+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=188517ec-5e28-43bc-866e-d79c4dbf16b7&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=188517ec-5e28-43bc-866e-d79c4dbf16b7&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=188517ec-5e28-43bc-866e-d79c4dbf16b7&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-27T10:45:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/2875a894-6664-43b1-ae7b-eceeb3fd8e46?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2875a894-6664-43b1-ae7b-eceeb3fd8e46",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-27T10:45:32+00:00",
      "updated_at": "2023-02-27T10:45:32+00:00",
      "number": "http://bqbl.it/2875a894-6664-43b1-ae7b-eceeb3fd8e46",
      "barcode_type": "qr_code",
      "image_url": "/uploads/94d47848871b9476d5d5981002f164df/barcode/image/2875a894-6664-43b1-ae7b-eceeb3fd8e46/7a3ff953-9750-4ec5-acfc-68e0c8b00c94.svg",
      "owner_id": "b299d2de-0100-4eff-ad66-e448134e6aa9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b299d2de-0100-4eff-ad66-e448134e6aa9"
        },
        "data": {
          "type": "customers",
          "id": "b299d2de-0100-4eff-ad66-e448134e6aa9"
        }
      }
    }
  },
  "included": [
    {
      "id": "b299d2de-0100-4eff-ad66-e448134e6aa9",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-27T10:45:32+00:00",
        "updated_at": "2023-02-27T10:45:32+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b299d2de-0100-4eff-ad66-e448134e6aa9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b299d2de-0100-4eff-ad66-e448134e6aa9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b299d2de-0100-4eff-ad66-e448134e6aa9&filter[owner_type]=customers"
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
          "owner_id": "94981496-0197-4ad4-8dca-3adf83f0cbdc",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "481c6ab1-9aec-4f86-9785-646129ffb2a1",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-27T10:45:33+00:00",
      "updated_at": "2023-02-27T10:45:33+00:00",
      "number": "http://bqbl.it/481c6ab1-9aec-4f86-9785-646129ffb2a1",
      "barcode_type": "qr_code",
      "image_url": "/uploads/afa928937fcdf114903522121cce79fa/barcode/image/481c6ab1-9aec-4f86-9785-646129ffb2a1/cc6e5d55-9ed7-4113-8bca-a05dc3ce0b21.svg",
      "owner_id": "94981496-0197-4ad4-8dca-3adf83f0cbdc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/bd315dfa-bc04-4e35-8077-5280aec7936a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bd315dfa-bc04-4e35-8077-5280aec7936a",
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
    "id": "bd315dfa-bc04-4e35-8077-5280aec7936a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-27T10:45:33+00:00",
      "updated_at": "2023-02-27T10:45:33+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/c7c7f8028f9bbbdc73ab7d453e7d17fa/barcode/image/bd315dfa-bc04-4e35-8077-5280aec7936a/27a55841-f8dc-4361-93db-f28688704c9e.svg",
      "owner_id": "adf5b722-9bea-4ff6-ace0-dfe2066ed311",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a1668ef0-dc34-4b49-a4ea-b0a7e1d735a7' \
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