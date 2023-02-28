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
- | -
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
      "id": "8db3cc45-623a-4004-9da0-7f18630ccc11",
      "type": "coupons",
      "attributes": {
        "created_at": "2023-02-28T08:10:57+00:00",
        "updated_at": "2023-02-28T08:10:57+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`
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
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`identifier` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`coupon_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`value` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`active` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a coupon



> How to fetch a coupon:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/coupons/f78f90e6-5f75-41f8-a90a-8688145c79c4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f78f90e6-5f75-41f8-a90a-8688145c79c4",
    "type": "coupons",
    "attributes": {
      "created_at": "2023-02-28T08:10:57+00:00",
      "updated_at": "2023-02-28T08:10:57+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


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
    "id": "147be798-bf16-4c85-947a-5973cabf1b1d",
    "type": "coupons",
    "attributes": {
      "created_at": "2023-02-28T08:10:58+00:00",
      "updated_at": "2023-02-28T08:10:58+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/coupons/29975758-cc9e-4fd4-ac80-cebddc4c81d8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "29975758-cc9e-4fd4-ac80-cebddc4c81d8",
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
    "id": "509f734e-319c-4ccc-8af9-5710a834f07a",
    "type": "coupons",
    "attributes": {
      "created_at": "2023-02-28T08:10:58+00:00",
      "updated_at": "2023-02-28T08:10:58+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/coupons/6966c759-03bf-4f5b-ab09-b71065619be7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6966c759-03bf-4f5b-ab09-b71065619be7",
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
    "id": "0951b5bf-11b4-4d6d-8645-fa0f6b5256e2",
    "type": "coupons",
    "attributes": {
      "created_at": "2023-02-28T08:10:59+00:00",
      "updated_at": "2023-02-28T08:10:59+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/coupons/ab2c56bc-2edf-414f-b3ef-7bc3d94a9167' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/coupons/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Includes

This request does not accept any includes