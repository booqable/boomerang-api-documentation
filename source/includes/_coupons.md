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
      "id": "5e4c5114-f035-4827-b61f-9de1a0545f00",
      "type": "coupons",
      "attributes": {
        "created_at": "2022-07-08T11:44:04+00:00",
        "updated_at": "2022-07-08T11:44:04+00:00",
        "identifier": "SUMMER20OFF",
        "coupon_type": "percentage",
        "value": 20,
        "active": true,
        "archived": false
      }
    }
  ],
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-08T11:43:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/coupons/4aab25d4-0979-4d27-9869-687e38de3fd1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4aab25d4-0979-4d27-9869-687e38de3fd1",
    "type": "coupons",
    "attributes": {
      "created_at": "2022-07-08T11:44:04+00:00",
      "updated_at": "2022-07-08T11:44:04+00:00",
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
    "id": "c8aba90c-4788-47ec-ae67-078a8c888beb",
    "type": "coupons",
    "attributes": {
      "created_at": "2022-07-08T11:44:05+00:00",
      "updated_at": "2022-07-08T11:44:05+00:00",
      "identifier": "WINTERDISCOUNT",
      "coupon_type": "cents",
      "value": 2000,
      "active": true,
      "archived": false
    }
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
    --url 'https://example.booqable.com/api/boomerang/coupons/6039bcb8-ad40-4e13-8db9-d6c67733b786' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6039bcb8-ad40-4e13-8db9-d6c67733b786",
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
    "id": "12226b36-e442-43f6-895c-dca3c3bd633e",
    "type": "coupons",
    "attributes": {
      "created_at": "2022-07-08T11:44:05+00:00",
      "updated_at": "2022-07-08T11:44:05+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/coupons/e9394e21-3c65-410e-a42e-a83c6cdeaf36' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e9394e21-3c65-410e-a42e-a83c6cdeaf36",
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
    "id": "99135311-012c-4af6-8944-f46d367cd35e",
    "type": "coupons",
    "attributes": {
      "created_at": "2022-07-08T11:44:06+00:00",
      "updated_at": "2022-07-08T11:44:06+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/coupons/14ca813b-6296-406c-8b7e-5c984dab1607' \
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