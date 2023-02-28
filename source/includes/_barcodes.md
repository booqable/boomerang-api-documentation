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
      "id": "ca352c05-7662-4e83-a0fa-a33b0443d0ab",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T08:10:40+00:00",
        "updated_at": "2023-02-28T08:10:40+00:00",
        "number": "http://bqbl.it/ca352c05-7662-4e83-a0fa-a33b0443d0ab",
        "barcode_type": "qr_code",
        "image_url": "/uploads/862b9e818f589b48ad0dece5f5c929a0/barcode/image/ca352c05-7662-4e83-a0fa-a33b0443d0ab/fa388fcf-5520-46e6-b331-4316b19ee767.svg",
        "owner_id": "6f3d7dc8-50b8-440c-8a03-c0f1ec4f8d0d",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/6f3d7dc8-50b8-440c-8a03-c0f1ec4f8d0d"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff790c6f7-9605-4727-aaa8-25ca727791c1&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f790c6f7-9605-4727-aaa8-25ca727791c1",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T08:10:40+00:00",
        "updated_at": "2023-02-28T08:10:40+00:00",
        "number": "http://bqbl.it/f790c6f7-9605-4727-aaa8-25ca727791c1",
        "barcode_type": "qr_code",
        "image_url": "/uploads/01296f2f6da64f3e814d7f7a6a88db6c/barcode/image/f790c6f7-9605-4727-aaa8-25ca727791c1/045ec0d0-b06c-477d-ac63-e9fe9fa7551c.svg",
        "owner_id": "19f3c7e2-8dd4-47a8-9602-32fca5b72156",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/19f3c7e2-8dd4-47a8-9602-32fca5b72156"
          },
          "data": {
            "type": "customers",
            "id": "19f3c7e2-8dd4-47a8-9602-32fca5b72156"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "19f3c7e2-8dd4-47a8-9602-32fca5b72156",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T08:10:40+00:00",
        "updated_at": "2023-02-28T08:10:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=19f3c7e2-8dd4-47a8-9602-32fca5b72156&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=19f3c7e2-8dd4-47a8-9602-32fca5b72156&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=19f3c7e2-8dd4-47a8-9602-32fca5b72156&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvMDcwOGFhZmEtNWQ3Mi00ODgyLTk1NWMtZmM5ZmRmYTU2NGZi&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0708aafa-5d72-4882-955c-fc9fdfa564fb",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-28T08:10:40+00:00",
        "updated_at": "2023-02-28T08:10:40+00:00",
        "number": "http://bqbl.it/0708aafa-5d72-4882-955c-fc9fdfa564fb",
        "barcode_type": "qr_code",
        "image_url": "/uploads/4fb7b6d1ce24d0c984fdc87dccd2c26c/barcode/image/0708aafa-5d72-4882-955c-fc9fdfa564fb/ee5f33dd-fd08-4dd6-8033-022249acf21d.svg",
        "owner_id": "64da98d7-3e2a-4ba0-a899-88b616bfd354",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/64da98d7-3e2a-4ba0-a899-88b616bfd354"
          },
          "data": {
            "type": "customers",
            "id": "64da98d7-3e2a-4ba0-a899-88b616bfd354"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "64da98d7-3e2a-4ba0-a899-88b616bfd354",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T08:10:40+00:00",
        "updated_at": "2023-02-28T08:10:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=64da98d7-3e2a-4ba0-a899-88b616bfd354&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=64da98d7-3e2a-4ba0-a899-88b616bfd354&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=64da98d7-3e2a-4ba0-a899-88b616bfd354&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T08:10:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/530bbd62-4f6a-4acb-aa13-d1bb5df50afa?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "530bbd62-4f6a-4acb-aa13-d1bb5df50afa",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T08:10:41+00:00",
      "updated_at": "2023-02-28T08:10:41+00:00",
      "number": "http://bqbl.it/530bbd62-4f6a-4acb-aa13-d1bb5df50afa",
      "barcode_type": "qr_code",
      "image_url": "/uploads/06b35f615aefc86f6b17a1d6f0b4dbd2/barcode/image/530bbd62-4f6a-4acb-aa13-d1bb5df50afa/5d0288ce-0a23-4933-9d70-6d7ed86232b4.svg",
      "owner_id": "b3eb4d0c-3908-4136-9b12-0d41803a8a85",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b3eb4d0c-3908-4136-9b12-0d41803a8a85"
        },
        "data": {
          "type": "customers",
          "id": "b3eb4d0c-3908-4136-9b12-0d41803a8a85"
        }
      }
    }
  },
  "included": [
    {
      "id": "b3eb4d0c-3908-4136-9b12-0d41803a8a85",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-28T08:10:41+00:00",
        "updated_at": "2023-02-28T08:10:41+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=b3eb4d0c-3908-4136-9b12-0d41803a8a85&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b3eb4d0c-3908-4136-9b12-0d41803a8a85&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b3eb4d0c-3908-4136-9b12-0d41803a8a85&filter[owner_type]=customers"
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
          "owner_id": "f07f4799-1f02-44a1-89cf-1ad678ebdbfc",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fd50e2f1-59ca-447d-b8e5-d55c8e714843",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T08:10:42+00:00",
      "updated_at": "2023-02-28T08:10:42+00:00",
      "number": "http://bqbl.it/fd50e2f1-59ca-447d-b8e5-d55c8e714843",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8e6ef031b08887cbfd69e81eaef599c6/barcode/image/fd50e2f1-59ca-447d-b8e5-d55c8e714843/635cb570-f6fb-4dbe-a630-f8293aac0ef1.svg",
      "owner_id": "f07f4799-1f02-44a1-89cf-1ad678ebdbfc",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/92ec6d4e-0f8c-41e9-be4c-f2c9d23739bd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "92ec6d4e-0f8c-41e9-be4c-f2c9d23739bd",
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
    "id": "92ec6d4e-0f8c-41e9-be4c-f2c9d23739bd",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-28T08:10:42+00:00",
      "updated_at": "2023-02-28T08:10:42+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/d4c5fefcb45ea4f9c3bdff6f75a13e8f/barcode/image/92ec6d4e-0f8c-41e9-be4c-f2c9d23739bd/07cfd73b-56b6-4e56-9157-03633026af23.svg",
      "owner_id": "162a13e4-af2f-4ff9-b285-1884e96f2202",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/516b434a-420a-4967-b968-547b506f1431' \
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