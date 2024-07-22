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
      "id": "793467e8-8fc4-4c30-ac36-56f07a0e2b4f",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-22T09:29:12.393134+00:00",
        "updated_at": "2024-07-22T09:29:12.393134+00:00",
        "number": "http://bqbl.it/793467e8-8fc4-4c30-ac36-56f07a0e2b4f",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-211.lvh.me:/barcodes/793467e8-8fc4-4c30-ac36-56f07a0e2b4f/image",
        "owner_id": "4e164ce5-f383-42c1-8405-065c6d3a331f",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=http%3A%2F%2Fbqbl.it%2Fb8acc604-d197-4338-afbb-5807fc70463c&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b8acc604-d197-4338-afbb-5807fc70463c",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-22T09:29:14.203111+00:00",
        "updated_at": "2024-07-22T09:29:14.203111+00:00",
        "number": "http://bqbl.it/b8acc604-d197-4338-afbb-5807fc70463c",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-213.lvh.me:/barcodes/b8acc604-d197-4338-afbb-5807fc70463c/image",
        "owner_id": "bf754133-7927-43b1-b0eb-5181c7eea8c4",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "bf754133-7927-43b1-b0eb-5181c7eea8c4"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "bf754133-7927-43b1-b0eb-5181c7eea8c4",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-22T09:29:14.147335+00:00",
        "updated_at": "2024-07-22T09:29:14.205940+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-52@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes?filter%5Bnumber%5D=aHR0cDovL2JxYmwuaXQvZTdkOTRkNDUtZGQzOC00YjliLTk4ZjMtMTQyYzM3NzdmMGEz&include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e7d94d45-dd38-4b9b-98f3-142c3777f0a3",
      "type": "barcodes",
      "attributes": {
        "created_at": "2024-07-22T09:29:13.322362+00:00",
        "updated_at": "2024-07-22T09:29:13.322362+00:00",
        "number": "http://bqbl.it/e7d94d45-dd38-4b9b-98f3-142c3777f0a3",
        "barcode_type": "qr_code",
        "image_url": "http://company-name-212.lvh.me:/barcodes/e7d94d45-dd38-4b9b-98f3-142c3777f0a3/image",
        "owner_id": "b453a205-ad98-4403-a8e0-ba7dbc6a1cc8",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "b453a205-ad98-4403-a8e0-ba7dbc6a1cc8"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b453a205-ad98-4403-a8e0-ba7dbc6a1cc8",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-22T09:29:13.265462+00:00",
        "updated_at": "2024-07-22T09:29:13.325160+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-51@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/db8ae484-7972-4c79-95a6-ca4739bdfa6e?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "db8ae484-7972-4c79-95a6-ca4739bdfa6e",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-22T09:29:11.503395+00:00",
      "updated_at": "2024-07-22T09:29:11.503395+00:00",
      "number": "http://bqbl.it/db8ae484-7972-4c79-95a6-ca4739bdfa6e",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-210.lvh.me:/barcodes/db8ae484-7972-4c79-95a6-ca4739bdfa6e/image",
      "owner_id": "e1f27c99-2fd9-4987-a891-a3c047a0308b",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "e1f27c99-2fd9-4987-a891-a3c047a0308b"
        }
      }
    }
  },
  "included": [
    {
      "id": "e1f27c99-2fd9-4987-a891-a3c047a0308b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-22T09:29:11.406915+00:00",
        "updated_at": "2024-07-22T09:29:11.509116+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-48@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
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
          "owner_id": "90d76b70-9c72-4322-aae8-70c02f2aa25b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "acab2b5a-070a-490d-93ee-d50493d53c7d",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-22T09:29:16.851853+00:00",
      "updated_at": "2024-07-22T09:29:16.851853+00:00",
      "number": "http://bqbl.it/acab2b5a-070a-490d-93ee-d50493d53c7d",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-216.lvh.me:/barcodes/acab2b5a-070a-490d-93ee-d50493d53c7d/image",
      "owner_id": "90d76b70-9c72-4322-aae8-70c02f2aa25b",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/35bdb3aa-da12-48c9-a199-a1faab358e8c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "35bdb3aa-da12-48c9-a199-a1faab358e8c",
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
    "id": "35bdb3aa-da12-48c9-a199-a1faab358e8c",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-22T09:29:14.987075+00:00",
      "updated_at": "2024-07-22T09:29:15.117803+00:00",
      "number": "https://myfancysite.com",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-214.lvh.me:/barcodes/35bdb3aa-da12-48c9-a199-a1faab358e8c/image",
      "owner_id": "5d6ea02d-ede3-4a41-a011-5b2aa441de43",
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
    --url 'https://example.booqable.com/api/boomerang/barcodes/0ff5ba95-c143-4c80-9e13-4e91790a36f5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0ff5ba95-c143-4c80-9e13-4e91790a36f5",
    "type": "barcodes",
    "attributes": {
      "created_at": "2024-07-22T09:29:15.828418+00:00",
      "updated_at": "2024-07-22T09:29:15.828418+00:00",
      "number": "http://bqbl.it/0ff5ba95-c143-4c80-9e13-4e91790a36f5",
      "barcode_type": "qr_code",
      "image_url": "http://company-name-215.lvh.me:/barcodes/0ff5ba95-c143-4c80-9e13-4e91790a36f5/image",
      "owner_id": "cf0355ff-8662-4bf5-ad76-ec72d170dc58",
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









