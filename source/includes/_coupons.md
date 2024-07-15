# Coupons

Create codes to discount orders by a fixed amount or a percentage. Customers can redeem the codes online at checkout. Coupons can also be added to orders.

## Endpoints
`GET /api/boomerang/coupons`

`GET /api/boomerang/coupons/{id}`

`POST /api/boomerang/coupons`

`PUT /api/boomerang/coupons/{id}`

`DELETE /api/boomerang/coupons/{id}`

## Fields
Every coupon has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether coupon is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the coupon was archived
`identifier` | **String** <br>The code that customers need to type in
`coupon_type` | **String** <br>One of `percentage`, `cents`
`value` | **Integer** <br>A percentage for type `percentage` or a value in cents for `cents`
`active` | **Boolean** <br>Whether coupon can be redeemed at the moment


## Listing coupons



> How to fetch a list of coupons:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/coupons' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cc42856c-fd4c-4743-8d23-31ef93fda25d",
      "type": "coupons",
      "attributes": {
        "created_at": "2024-07-15T09:28:32.313421+00:00",
        "updated_at": "2024-07-15T09:28:32.313421+00:00",
        "archived": false,
        "archived_at": null,
        "identifier": "SUMMER20OFF",
        "coupon_type": "percentage",
        "value": 20,
        "active": true
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/coupons`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`
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
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`identifier` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`coupon_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`value` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`active` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a coupon



> How to fetch a coupon:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/coupons/9178ab6e-c218-4fd2-9af1-7ee54c1bc89d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9178ab6e-c218-4fd2-9af1-7ee54c1bc89d",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-07-15T09:28:30.368111+00:00",
      "updated_at": "2024-07-15T09:28:30.368111+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": true
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/coupons/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Includes

This request does not accept any includes
## Creating a coupon



> How to create a coupon:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/coupons' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "coupons",
        "attributes": {
          "identifier": "WINTERDISCOUNT",
          "coupon_type": "cents",
          "value": 2000,
          "active": true
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8f1859a8-19b0-4b85-8372-1e9a6b4b23d1",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-07-15T09:28:29.023884+00:00",
      "updated_at": "2024-07-15T09:28:29.023884+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "WINTERDISCOUNT",
      "coupon_type": "cents",
      "value": 2000,
      "active": true
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/coupons`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **String** <br>The code that customers need to type in
`data[attributes][coupon_type]` | **String** <br>One of `percentage`, `cents`
`data[attributes][value]` | **Integer** <br>A percentage for type `percentage` or a value in cents for `cents`
`data[attributes][active]` | **Boolean** <br>Whether coupon can be redeemed at the moment


### Includes

This request does not accept any includes
## Updating a coupon

When updating a coupon the existing one is archived and a new one gets created:


> How to update a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/c8821b0a-507c-4664-8504-b438b9207619' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c8821b0a-507c-4664-8504-b438b9207619",
        "type": "coupons",
        "attributes": {
          "identifier": "SUMMER30OFF",
          "coupon_type": "percentage",
          "value": 30
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cc8683ce-ed36-4bf7-907c-8fb66bbec8ce",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-07-15T09:28:31.050373+00:00",
      "updated_at": "2024-07-15T09:28:31.083966+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "SUMMER30OFF",
      "coupon_type": "percentage",
      "value": 30,
      "active": false
    }
  },
  "meta": {}
}
```


> How to deativate a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/30e597d8-e577-467f-a661-2917c97cbf53' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "30e597d8-e577-467f-a661-2917c97cbf53",
        "type": "coupons",
        "attributes": {
          "active": false
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ffe3fd0e-94af-485b-8886-3216b3f2e8e5",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-07-15T09:28:31.694371+00:00",
      "updated_at": "2024-07-15T09:28:31.743463+00:00",
      "archived": false,
      "archived_at": null,
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/coupons/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **String** <br>The code that customers need to type in
`data[attributes][coupon_type]` | **String** <br>One of `percentage`, `cents`
`data[attributes][value]` | **Integer** <br>A percentage for type `percentage` or a value in cents for `cents`
`data[attributes][active]` | **Boolean** <br>Whether coupon can be redeemed at the moment


### Includes

This request does not accept any includes
## Archiving a coupon



> How to archive a coupon:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/coupons/976f6dfe-19df-4b0d-9b20-4eea9d42696b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "976f6dfe-19df-4b0d-9b20-4eea9d42696b",
    "type": "coupons",
    "attributes": {
      "created_at": "2024-07-15T09:28:29.656700+00:00",
      "updated_at": "2024-07-15T09:28:29.682657+00:00",
      "archived": true,
      "archived_at": "2024-07-15T09:28:29.682657+00:00",
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": true
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/coupons/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=created_at,updated_at,archived`


### Includes

This request does not accept any includes