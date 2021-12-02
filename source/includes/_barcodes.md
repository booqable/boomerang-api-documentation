# Barcodes

You can assign barcodes to products (or their variations), individually tracked stock items, and customers (for use on a customer card, for example).

Booqable supports the following barcode formats:

- **QR code:** QR codes are flexible in size, have high fault tolerance, and fast readability.
- **EAN-8:** Ideal for identifying small items, stores eight digits.
- **EAN-13:** Can store a relatively large amount of data (13 digits) in a small area.
- **Code 39:** Stores both digits and characters. The size of the barcode makes them unsuitable to use on small items.
- **Code 93**: A more compact alternative to Code 39 (about 25% shorter).
- **Code 128**: A high-density barcode that can store any character of the ASCII 128 character set.

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
`number` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
      "id": "7762d9e4-239a-47d1-91d4-3beefd1a2fad",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T14:36:53+00:00",
        "updated_at": "2021-12-02T14:36:53+00:00",
        "number": "http://bqbl.it/7762d9e4-239a-47d1-91d4-3beefd1a2fad",
        "barcode_type": "qr_code",
        "image_url": "/uploads/8a94fab3d70e15ea52523f4dae2b5b86/barcode/image/7762d9e4-239a-47d1-91d4-3beefd1a2fad/0e89a1fe-7e49-42c8-b48a-178d71cef32e.svg",
        "owner_id": "88477c51-1a70-4c07-9b32-fb3abfca9244",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/88477c51-1a70-4c07-9b32-fb3abfca9244"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fad975f9b-c50f-4273-a038-6c68fcf12330&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ad975f9b-c50f-4273-a038-6c68fcf12330",
      "type": "barcodes",
      "attributes": {
        "created_at": "2021-12-02T14:36:54+00:00",
        "updated_at": "2021-12-02T14:36:54+00:00",
        "number": "http://bqbl.it/ad975f9b-c50f-4273-a038-6c68fcf12330",
        "barcode_type": "qr_code",
        "image_url": "/uploads/bb65742a9dc433fabcf9a5d48d7467cf/barcode/image/ad975f9b-c50f-4273-a038-6c68fcf12330/737dd0fa-5246-4fa0-ad23-b94400c16f68.svg",
        "owner_id": "7bece2d0-4341-4c87-9f62-796560e299a1",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7bece2d0-4341-4c87-9f62-796560e299a1"
          },
          "data": {
            "type": "customers",
            "id": "7bece2d0-4341-4c87-9f62-796560e299a1"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "7bece2d0-4341-4c87-9f62-796560e299a1",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T14:36:54+00:00",
        "updated_at": "2021-12-02T14:36:54+00:00",
        "number": 1,
        "name": "Bernier-Terry",
        "email": "terry_bernier@jacobs.name",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=7bece2d0-4341-4c87-9f62-796560e299a1&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7bece2d0-4341-4c87-9f62-796560e299a1&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7bece2d0-4341-4c87-9f62-796560e299a1&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fad975f9b-c50f-4273-a038-6c68fcf12330&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fad975f9b-c50f-4273-a038-6c68fcf12330&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fad975f9b-c50f-4273-a038-6c68fcf12330&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-02T14:36:39Z`
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
`number` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/4f3aa1d3-fec9-45a7-b300-de4f2992e5f3?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4f3aa1d3-fec9-45a7-b300-de4f2992e5f3",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T14:36:54+00:00",
      "updated_at": "2021-12-02T14:36:54+00:00",
      "number": "http://bqbl.it/4f3aa1d3-fec9-45a7-b300-de4f2992e5f3",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ad973e6770703a24a408ca46a2e5b581/barcode/image/4f3aa1d3-fec9-45a7-b300-de4f2992e5f3/4261b639-a260-4224-a10a-5fdb237307c2.svg",
      "owner_id": "f1e69b3c-1d6a-45ad-b375-8528eed9e19d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f1e69b3c-1d6a-45ad-b375-8528eed9e19d"
        },
        "data": {
          "type": "customers",
          "id": "f1e69b3c-1d6a-45ad-b375-8528eed9e19d"
        }
      }
    }
  },
  "included": [
    {
      "id": "f1e69b3c-1d6a-45ad-b375-8528eed9e19d",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T14:36:54+00:00",
        "updated_at": "2021-12-02T14:36:54+00:00",
        "number": 1,
        "name": "Ritchie Group",
        "email": "group.ritchie@orn-nicolas.io",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=f1e69b3c-1d6a-45ad-b375-8528eed9e19d&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=f1e69b3c-1d6a-45ad-b375-8528eed9e19d&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f1e69b3c-1d6a-45ad-b375-8528eed9e19d&filter[owner_type]=customers"
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
          "owner_id": "abf594d2-2adc-4cde-9554-3ca8e1d74829",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "35eafdf7-c82b-4b63-9f35-b23d48aebb1d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T14:36:55+00:00",
      "updated_at": "2021-12-02T14:36:55+00:00",
      "number": "http://bqbl.it/35eafdf7-c82b-4b63-9f35-b23d48aebb1d",
      "barcode_type": "qr_code",
      "image_url": "/uploads/ec094f9a463d297d6bb01c2f919aafbc/barcode/image/35eafdf7-c82b-4b63-9f35-b23d48aebb1d/a2e7cf38-fe92-4f8c-8251-7de440c763fd.svg",
      "owner_id": "abf594d2-2adc-4cde-9554-3ca8e1d74829",
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
  "links": {
    "self": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=abf594d2-2adc-4cde-9554-3ca8e1d74829&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=abf594d2-2adc-4cde-9554-3ca8e1d74829&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/barcodes?data%5Battributes%5D%5Bbarcode_type%5D=qr_code&data%5Battributes%5D%5Bowner_id%5D=abf594d2-2adc-4cde-9554-3ca8e1d74829&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=barcodes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/02a8da84-8d3e-45d4-9d0a-c74c19bffe3f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "02a8da84-8d3e-45d4-9d0a-c74c19bffe3f",
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
    "id": "02a8da84-8d3e-45d4-9d0a-c74c19bffe3f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2021-12-02T14:36:55+00:00",
      "updated_at": "2021-12-02T14:36:55+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/efc1d3bc84cc9566160d5ff49b9925f5/barcode/image/02a8da84-8d3e-45d4-9d0a-c74c19bffe3f/afbfb3aa-7755-48da-9fc6-0cfd711bc15f.svg",
      "owner_id": "96c30949-da7e-48a6-bd15-effb83261ad3",
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
`data[attributes][number]` | **String**<br>The barcode data, can be a number, code or url. Leave blank to let Booqable create one.
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d9221757-10fa-4a78-844c-7660c953cef4' \
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