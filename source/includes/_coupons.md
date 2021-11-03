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
`identifier` | **String**<br>The code that customers need to type in
`coupon_type` | **String**<br>One of `percentage`, `cents`
`value` | **Integer**<br>A percentage for type `percentage` or a value in cents for `cents`
`active` | **Boolean**<br>Whether coupon can be redeemed at the moment
`archived` | **Boolean** `readonly`<br>Whether coupon is archived


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
      "id": "14b37251-3e52-43f6-979c-ff2e5a4d1664",
      "type": "coupons",
      "attributes": {
        "identifier": "SUMMER20OFF",
        "coupon_type": "percentage",
        "value": 20,
        "active": true,
        "archived": false
      }
    }
  ],
  "links": {
    "self": "api/boomerang/coupons?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/coupons?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/coupons?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/coupons`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-03T08:35:45Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`identifier` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`coupon_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`value` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`active` | **Boolean**<br>`eq`
`archived` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a coupon



> How to fetch a coupon:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/coupons/83b50700-0358-427d-8872-c06c80ba50d4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "83b50700-0358-427d-8872-c06c80ba50d4",
    "type": "coupons",
    "attributes": {
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": true,
      "archived": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/coupons/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


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
    "id": "282d5644-218b-4c31-842a-62e6293c4b85",
    "type": "coupons",
    "attributes": {
      "identifier": "WINTERDISCOUNT",
      "coupon_type": "cents",
      "value": 2000,
      "active": true,
      "archived": false
    }
  },
  "links": {
    "self": "api/boomerang/coupons?data%5Battributes%5D%5Bactive%5D=true&data%5Battributes%5D%5Bcoupon_type%5D=cents&data%5Battributes%5D%5Bidentifier%5D=WINTERDISCOUNT&data%5Battributes%5D%5Bvalue%5D=2000&data%5Btype%5D=coupons&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/coupons?data%5Battributes%5D%5Bactive%5D=true&data%5Battributes%5D%5Bcoupon_type%5D=cents&data%5Battributes%5D%5Bidentifier%5D=WINTERDISCOUNT&data%5Battributes%5D%5Bvalue%5D=2000&data%5Btype%5D=coupons&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/coupons?data%5Battributes%5D%5Bactive%5D=true&data%5Battributes%5D%5Bcoupon_type%5D=cents&data%5Battributes%5D%5Bidentifier%5D=WINTERDISCOUNT&data%5Battributes%5D%5Bvalue%5D=2000&data%5Btype%5D=coupons&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/coupons`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][identifier]` | **String**<br>The code that customers need to type in
`data[attributes][coupon_type]` | **String**<br>One of `percentage`, `cents`
`data[attributes][value]` | **Integer**<br>A percentage for type `percentage` or a value in cents for `cents`
`data[attributes][active]` | **Boolean**<br>Whether coupon can be redeemed at the moment


### Includes

This request does not accept any includes
## Updating a coupon

When updating a coupon the existing one is archived and a new one gets created:


> How to update a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/7cd2f827-b7a5-4727-91a8-0e34b34ec365' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7cd2f827-b7a5-4727-91a8-0e34b34ec365",
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
    "id": "30b12aa3-e788-4e29-8e8d-d3e416bc4592",
    "type": "coupons",
    "attributes": {
      "identifier": "SUMMER30OFF",
      "coupon_type": "percentage",
      "value": 30,
      "active": false,
      "archived": false
    }
  },
  "meta": {}
}
```


> How to deativate a coupon:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/coupons/d08dfea1-1f85-46db-9e46-7301273ecadd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d08dfea1-1f85-46db-9e46-7301273ecadd",
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
    "id": "05f94227-41e3-4150-a1e3-6a095dde4b4c",
    "type": "coupons",
    "attributes": {
      "identifier": "SUMMER20OFF",
      "coupon_type": "percentage",
      "value": 20,
      "active": false,
      "archived": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/coupons/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][identifier]` | **String**<br>The code that customers need to type in
`data[attributes][coupon_type]` | **String**<br>One of `percentage`, `cents`
`data[attributes][value]` | **Integer**<br>A percentage for type `percentage` or a value in cents for `cents`
`data[attributes][active]` | **Boolean**<br>Whether coupon can be redeemed at the moment


### Includes

This request does not accept any includes
## Archiving a coupon



> How to archive a coupon:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/coupons/6323b9d6-2f62-4279-9a8d-2e436653ee0a' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[coupons]=id,created_at,updated_at`


### Includes

This request does not accept any includes