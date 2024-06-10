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
      "id": "2b15ed79-c35c-4781-abb2-b38e3b5ed92a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-10T09:25:48.731088+00:00",
        "updated_at": "2024-06-10T09:25:48.731088+00:00",
        "number": "http://bqbl.it/2b15ed79-c35c-4781-abb2-b38e3b5ed92a",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-142.lvh.me:/barcodes/2b15ed79-c35c-4781-abb2-b38e3b5ed92a/image",
        "owner_id": "f72600e7-a038-4ec7-a951-87792903b322",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f72600e7-a038-4ec7-a951-87792903b322"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Ff2965f9e-652c-40e0-8e89-63f09175c4dd&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f2965f9e-652c-40e0-8e89-63f09175c4dd",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-10T09:25:49.344878+00:00",
        "updated_at": "2024-06-10T09:25:49.344878+00:00",
        "number": "http://bqbl.it/f2965f9e-652c-40e0-8e89-63f09175c4dd",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-143.lvh.me:/barcodes/f2965f9e-652c-40e0-8e89-63f09175c4dd/image",
        "owner_id": "5cbc517e-590b-46fc-98fb-615f7ee6fd23",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/5cbc517e-590b-46fc-98fb-615f7ee6fd23"
          },
          "data": {
            "type": "customers",
            "id": "5cbc517e-590b-46fc-98fb-615f7ee6fd23"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "5cbc517e-590b-46fc-98fb-615f7ee6fd23",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-10T09:25:49.326090+00:00",
        "updated_at": "2024-06-10T09:25:49.347649+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-33@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=5cbc517e-590b-46fc-98fb-615f7ee6fd23&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5cbc517e-590b-46fc-98fb-615f7ee6fd23&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=5cbc517e-590b-46fc-98fb-615f7ee6fd23&filter[owner_type]=customers"
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNjlkOTExNjEtZTY4Zi00ZjEzLTk5YjUtNmE0NDhiOWVmNDJj&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "69d91161-e68f-4f13-99b5-6a448b9ef42c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-06-10T09:25:48.107503+00:00",
        "updated_at": "2024-06-10T09:25:48.107503+00:00",
        "number": "http://bqbl.it/69d91161-e68f-4f13-99b5-6a448b9ef42c",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-141.lvh.me:/barcodes/69d91161-e68f-4f13-99b5-6a448b9ef42c/image",
        "owner_id": "0ccaf65a-de92-4f51-8908-cd6c66a3ea45",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0ccaf65a-de92-4f51-8908-cd6c66a3ea45"
          },
          "data": {
            "type": "customers",
            "id": "0ccaf65a-de92-4f51-8908-cd6c66a3ea45"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "0ccaf65a-de92-4f51-8908-cd6c66a3ea45",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-10T09:25:48.087321+00:00",
        "updated_at": "2024-06-10T09:25:48.110277+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-31@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=0ccaf65a-de92-4f51-8908-cd6c66a3ea45&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0ccaf65a-de92-4f51-8908-cd6c66a3ea45&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0ccaf65a-de92-4f51-8908-cd6c66a3ea45&filter[owner_type]=customers"
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

`owner` => 
`photo`


`product` => 
`photo`










## Fetching a barcode



> How to fetch a barcode:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes/1c303293-1b14-47e3-8d07-d30492c2986e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1c303293-1b14-47e3-8d07-d30492c2986e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-10T09:25:51.426059+00:00",
      "updated_at": "2024-06-10T09:25:51.426059+00:00",
      "number": "http://bqbl.it/1c303293-1b14-47e3-8d07-d30492c2986e",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-146.lvh.me:/barcodes/1c303293-1b14-47e3-8d07-d30492c2986e/image",
      "owner_id": "e39864c1-54a0-488f-9baf-6fc7df2c9101",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e39864c1-54a0-488f-9baf-6fc7df2c9101"
        },
        "data": {
          "type": "customers",
          "id": "e39864c1-54a0-488f-9baf-6fc7df2c9101"
        }
      }
    }
  },
  "included": [
    {
      "id": "e39864c1-54a0-488f-9baf-6fc7df2c9101",
      "type": "customers",
      "attributes": {
        "created_at": "2024-06-10T09:25:51.408163+00:00",
        "updated_at": "2024-06-10T09:25:51.428777+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-36@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=e39864c1-54a0-488f-9baf-6fc7df2c9101&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e39864c1-54a0-488f-9baf-6fc7df2c9101&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e39864c1-54a0-488f-9baf-6fc7df2c9101&filter[owner_type]=customers"
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

`owner` => 
`photo`


`product` => 
`photo`










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
          "owner_id": "a82de603-0827-4186-8955-51b402a84b4e",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ac6d9933-1ee5-4fbf-9336-6f4e56514e03",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-10T09:25:47.384094+00:00",
      "updated_at": "2024-06-10T09:25:47.384094+00:00",
      "number": "http://bqbl.it/ac6d9933-1ee5-4fbf-9336-6f4e56514e03",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-140.lvh.me:/barcodes/ac6d9933-1ee5-4fbf-9336-6f4e56514e03/image",
      "owner_id": "a82de603-0827-4186-8955-51b402a84b4e",
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

`owner` => 
`photo`


`product` => 
`photo`










## Updating a barcode



> How to update a barcode:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/barcodes/d9b23b6f-37ee-4afc-82ae-ed0c8737b64f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d9b23b6f-37ee-4afc-82ae-ed0c8737b64f",
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
    "id": "d9b23b6f-37ee-4afc-82ae-ed0c8737b64f",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-10T09:25:49.965511+00:00",
      "updated_at": "2024-06-10T09:25:50.032194+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-144.lvh.me:/barcodes/d9b23b6f-37ee-4afc-82ae-ed0c8737b64f/image",
      "owner_id": "dd433861-92aa-4e46-955e-0f9545095f27",
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

`owner` => 
`photo`


`product` => 
`photo`










## Destroying a barcode



> How to delete a barcode:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/barcodes/0d01d38e-e3ac-42bb-a1c9-aea2d47075b0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0d01d38e-e3ac-42bb-a1c9-aea2d47075b0",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-06-10T09:25:50.653792+00:00",
      "updated_at": "2024-06-10T09:25:50.653792+00:00",
      "number": "http://bqbl.it/0d01d38e-e3ac-42bb-a1c9-aea2d47075b0",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-145.lvh.me:/barcodes/0d01d38e-e3ac-42bb-a1c9-aea2d47075b0/image",
      "owner_id": "05c6cbcb-ad0e-4208-893d-04b1873f2ad3",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/05c6cbcb-ad0e-4208-893d-04b1873f2ad3"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/barcodes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[barcodes]=created_at,updated_at,number`


### Includes

This request accepts the following includes:

`owner` => 
`photo`


`product` => 
`photo`









