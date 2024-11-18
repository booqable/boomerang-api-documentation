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
`owner` | **Customer, Product, Order, Stock item** <br>Associated Owner


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
      "id": "25b49e65-07a5-4798-b8d8-82d31c2657df",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-18T09:26:07.415744+00:00",
        "updated_at": "2024-11-18T09:26:07.415744+00:00",
        "number": "http://bqbl.it/25b49e65-07a5-4798-b8d8-82d31c2657df",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-155.lvh.me:/barcodes/25b49e65-07a5-4798-b8d8-82d31c2657df/image",
        "owner_id": "99cf4e58-dff8-4c43-9f4a-6448ed787c94",
        "owner_type": "customers"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2F67119cf3-f53b-42d4-bbc6-777e49b08e7a&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "67119cf3-f53b-42d4-bbc6-777e49b08e7a",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-18T09:26:07.894103+00:00",
        "updated_at": "2024-11-18T09:26:07.894103+00:00",
        "number": "http://bqbl.it/67119cf3-f53b-42d4-bbc6-777e49b08e7a",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-156.lvh.me:/barcodes/67119cf3-f53b-42d4-bbc6-777e49b08e7a/image",
        "owner_id": "a382b761-c5b8-4a1c-b4f3-f464b22ed4c8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "a382b761-c5b8-4a1c-b4f3-f464b22ed4c8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a382b761-c5b8-4a1c-b4f3-f464b22ed4c8",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-18T09:26:07.857357+00:00",
        "updated_at": "2024-11-18T09:26:07.895673+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-75@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find an owner by a barcode number containing a url:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvNWExM2NkNGItY2UyYi00ZGNjLTg2MTItMmU3ZmE3NTNlZTFm&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5a13cd4b-ce2b-4dcc-8612-2e7fa753ee1f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-11-18T09:26:08.441539+00:00",
        "updated_at": "2024-11-18T09:26:08.441539+00:00",
        "number": "http://bqbl.it/5a13cd4b-ce2b-4dcc-8612-2e7fa753ee1f",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-157.lvh.me:/barcodes/5a13cd4b-ce2b-4dcc-8612-2e7fa753ee1f/image",
        "owner_id": "cab274f6-b49d-4e9b-91f7-03fd8ced276b",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "cab274f6-b49d-4e9b-91f7-03fd8ced276b"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "cab274f6-b49d-4e9b-91f7-03fd8ced276b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-18T09:26:08.409630+00:00",
        "updated_at": "2024-11-18T09:26:08.442935+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-77@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/6cf8d024-4f3a-4fb0-a988-99c4a53eb47a?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6cf8d024-4f3a-4fb0-a988-99c4a53eb47a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-18T09:26:06.917405+00:00",
      "updated_at": "2024-11-18T09:26:06.917405+00:00",
      "number": "http://bqbl.it/6cf8d024-4f3a-4fb0-a988-99c4a53eb47a",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-154.lvh.me:/barcodes/6cf8d024-4f3a-4fb0-a988-99c4a53eb47a/image",
      "owner_id": "9472a3f1-48cd-45ce-bb81-7d2b502b7dab",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "9472a3f1-48cd-45ce-bb81-7d2b502b7dab"
        }
      }
    }
  },
  "included": [
    {
      "id": "9472a3f1-48cd-45ce-bb81-7d2b502b7dab",
      "type": "customers",
      "attributes": {
        "created_at": "2024-11-18T09:26:06.883946+00:00",
        "updated_at": "2024-11-18T09:26:06.919076+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-73@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
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
          "owner_id": "a1caffac-b479-4b13-a1a0-986eaf5f4c01",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0b4a7b6c-448e-4c1f-9e7d-a9df21b1c529",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-18T09:26:05.919316+00:00",
      "updated_at": "2024-11-18T09:26:05.919316+00:00",
      "number": "http://bqbl.it/0b4a7b6c-448e-4c1f-9e7d-a9df21b1c529",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-152.lvh.me:/barcodes/0b4a7b6c-448e-4c1f-9e7d-a9df21b1c529/image",
      "owner_id": "a1caffac-b479-4b13-a1a0-986eaf5f4c01",
      "owner_type": "customers"
    },
    "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/255a1d4c-e635-40af-b6ad-3a59437f3c5a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "255a1d4c-e635-40af-b6ad-3a59437f3c5a",
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
    "id": "255a1d4c-e635-40af-b6ad-3a59437f3c5a",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-18T09:26:06.392684+00:00",
      "updated_at": "2024-11-18T09:26:06.446291+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-153.lvh.me:/barcodes/255a1d4c-e635-40af-b6ad-3a59437f3c5a/image",
      "owner_id": "a97d4cb9-c2b7-4b18-a3fc-a8de386b0a57",
      "owner_type": "customers"
    },
    "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/a286df08-bebc-4369-9520-e73f490b1f9b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a286df08-bebc-4369-9520-e73f490b1f9b",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-11-18T09:26:05.289955+00:00",
      "updated_at": "2024-11-18T09:26:05.289955+00:00",
      "number": "http://bqbl.it/a286df08-bebc-4369-9520-e73f490b1f9b",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-151.lvh.me:/barcodes/a286df08-bebc-4369-9520-e73f490b1f9b/image",
      "owner_id": "9a026ff4-f2c7-4c58-95f2-721265c1845c",
      "owner_type": "customers"
    },
    "relationships": {}
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









