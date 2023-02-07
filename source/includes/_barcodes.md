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
      "id": "8860767b-23b7-40cc-a2e3-fa439d6b146c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T16:04:39+00:00",
        "updated_at": "2023-02-07T16:04:39+00:00",
        "number": "http://bqbl.it/8860767b-23b7-40cc-a2e3-fa439d6b146c",
        "barcode_type": "qr_code",
        "image_url": "/uploads/d162be9e385c35de843d9c99c3274768/barcode/image/8860767b-23b7-40cc-a2e3-fa439d6b146c/3cad362f-612a-4803-bfcd-6771f511c7a2.svg",
        "owner_id": "b311bcc3-cbfc-4661-a4f0-9f06cf916768",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/b311bcc3-cbfc-4661-a4f0-9f06cf916768"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F04b18c73-0a9a-4c34-9b68-d068862e85a9&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "04b18c73-0a9a-4c34-9b68-d068862e85a9",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T16:04:40+00:00",
        "updated_at": "2023-02-07T16:04:40+00:00",
        "number": "http://bqbl.it/04b18c73-0a9a-4c34-9b68-d068862e85a9",
        "barcode_type": "qr_code",
        "image_url": "/uploads/f91cc31a6bbaa0c9bde2ceae9d762eb1/barcode/image/04b18c73-0a9a-4c34-9b68-d068862e85a9/04407390-8461-4141-ae12-ade651e71851.svg",
        "owner_id": "3220d7f6-0523-4017-9675-f9ccd509771f",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3220d7f6-0523-4017-9675-f9ccd509771f"
          },
          "data": {
            "type": "customers",
            "id": "3220d7f6-0523-4017-9675-f9ccd509771f"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "3220d7f6-0523-4017-9675-f9ccd509771f",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T16:04:40+00:00",
        "updated_at": "2023-02-07T16:04:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=3220d7f6-0523-4017-9675-f9ccd509771f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=3220d7f6-0523-4017-9675-f9ccd509771f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3220d7f6-0523-4017-9675-f9ccd509771f&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNmQ4ZmQ1ODctZTU1OC00ZjIwLTlkNTktZDQyN2I1N2FmNzcy&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6d8fd587-e558-4f20-9d59-d427b57af772",
      "type": "barcodes",
      "attributes": {
        "created_at": "2023-02-07T16:04:40+00:00",
        "updated_at": "2023-02-07T16:04:40+00:00",
        "number": "http://bqbl.it/6d8fd587-e558-4f20-9d59-d427b57af772",
        "barcode_type": "qr_code",
        "image_url": "/uploads/98d1ad2edf39dbdf13a40330d27ae957/barcode/image/6d8fd587-e558-4f20-9d59-d427b57af772/dc2966f9-9568-43e6-90de-477b2de999ac.svg",
        "owner_id": "e523c1d0-1e58-47bd-a7c6-4acb826b5017",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e523c1d0-1e58-47bd-a7c6-4acb826b5017"
          },
          "data": {
            "type": "customers",
            "id": "e523c1d0-1e58-47bd-a7c6-4acb826b5017"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "e523c1d0-1e58-47bd-a7c6-4acb826b5017",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T16:04:40+00:00",
        "updated_at": "2023-02-07T16:04:40+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=e523c1d0-1e58-47bd-a7c6-4acb826b5017&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e523c1d0-1e58-47bd-a7c6-4acb826b5017&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e523c1d0-1e58-47bd-a7c6-4acb826b5017&filter[owner_type]=customers"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T16:04:23Z`
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d55f6119-f419-406c-8306-917e9ad9fb07?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d55f6119-f419-406c-8306-917e9ad9fb07",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T16:04:41+00:00",
      "updated_at": "2023-02-07T16:04:41+00:00",
      "number": "http://bqbl.it/d55f6119-f419-406c-8306-917e9ad9fb07",
      "barcode_type": "qr_code",
      "image_url": "/uploads/8fa11aae4a6118df373b22002423a657/barcode/image/d55f6119-f419-406c-8306-917e9ad9fb07/b7d4bd97-06b8-4130-be70-dcbe51225a2f.svg",
      "owner_id": "4d874ec5-cd7a-40ce-8e14-c3ec75c1e9a2",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/4d874ec5-cd7a-40ce-8e14-c3ec75c1e9a2"
        },
        "data": {
          "type": "customers",
          "id": "4d874ec5-cd7a-40ce-8e14-c3ec75c1e9a2"
        }
      }
    }
  },
  "included": [
    {
      "id": "4d874ec5-cd7a-40ce-8e14-c3ec75c1e9a2",
      "type": "customers",
      "attributes": {
        "created_at": "2023-02-07T16:04:41+00:00",
        "updated_at": "2023-02-07T16:04:41+00:00",
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
            "related": "api/boomerang/properties?filter[owner_id]=4d874ec5-cd7a-40ce-8e14-c3ec75c1e9a2&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=4d874ec5-cd7a-40ce-8e14-c3ec75c1e9a2&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=4d874ec5-cd7a-40ce-8e14-c3ec75c1e9a2&filter[owner_type]=customers"
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
          "owner_id": "5d518402-b835-44c2-8d51-9a16eb5f92c3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "14aeff4d-b642-45de-acc7-5406bc69dd3f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T16:04:41+00:00",
      "updated_at": "2023-02-07T16:04:41+00:00",
      "number": "http://bqbl.it/14aeff4d-b642-45de-acc7-5406bc69dd3f",
      "barcode_type": "qr_code",
      "image_url": "/uploads/629e0dee003ac3ca0f9783dd714bb524/barcode/image/14aeff4d-b642-45de-acc7-5406bc69dd3f/12252c6e-7a9a-46cd-b86b-04d815faae35.svg",
      "owner_id": "5d518402-b835-44c2-8d51-9a16eb5f92c3",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/14eed3b5-5e15-4f0c-97f3-6a43ff0bef88' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "14eed3b5-5e15-4f0c-97f3-6a43ff0bef88",
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
    "id": "14eed3b5-5e15-4f0c-97f3-6a43ff0bef88",
    "type": "barcodes",
    "attributes": {
      "created_at": "2023-02-07T16:04:42+00:00",
      "updated_at": "2023-02-07T16:04:42+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "/uploads/96bbafee22426088befa0e0383393172/barcode/image/14eed3b5-5e15-4f0c-97f3-6a43ff0bef88/70aedb22-8194-4f89-b17b-399254fce167.svg",
      "owner_id": "5c8ffd7f-8d92-415d-938c-f6381fafd824",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/d313da41-d359-4c4a-8bca-87ab4b3eb7ad' \
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