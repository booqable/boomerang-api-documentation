# Notification subscriptions

Notification subscriptions can be used to subscribe an employee to a specific category of notifications. Booqable offers several categories of notifications:

1. `note_created` for when a new note is created.
2. `webshop_order_created` for when a new order was create via the webshop.
3. `order_reserved` for when an order first transitions into the reserved state.
4. `order_updated` for any update to an order
5. `order_started` for when an order started plannings
6. `order_stopped` for when an order stopped plannings

All categories, except for `webshop_order_created`, can be associated with an owner. At the time of this writing the owner must be an Order.

When a notification subscriptions is associated with an owner, the notification will only be fired for the given owner.

Multiple owned notification subscriptions can be created for any employee. If the employee has an unowned notification subscription and an owned notification subscription for the same category, a single notification will send for the associated owner.

## Endpoints
`GET /api/boomerang/notification_subscriptions`

`GET /api/boomerang/notification_subscriptions/{id}`

`POST /api/boomerang/notification_subscriptions`

`DELETE /api/boomerang/notification_subscriptions/{id}`

## Fields
Every notification subscription has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`category` | **String** <br>One of `note_created`, `webshop_order_created`, `order_updated`, `order_reserved`, `order_started`, `order_stopped`
`global` | **Boolean** `nullable` `readonly`<br>Will be set true when the subscription is not associated with any owner, false otherwise
`owner_id` | **Uuid** <br>ID of the resource the notifications subscription is associated with
`owner_type` | **String** <br>The resource type of the owner. One of `orders`


## Relationships
Notification subscriptions have the following relationships:

Name | Description
-- | --
`owner` | **Order**<br>Associated Owner


## Listing notification subscriptions



> How to fetch a list of notification subscriptions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "58f69437-5b55-404e-a791-d989add98b5b",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-22T09:25:17.967089+00:00",
        "updated_at": "2024-07-22T09:25:17.967089+00:00",
        "category": "order_started",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "14a377fc-43d5-47f8-8d0d-413df740b627",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-22T09:25:17.956402+00:00",
        "updated_at": "2024-07-22T09:25:17.956402+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "1de1fee1-c94b-4270-9ca2-394009aad294",
        "owner_type": "orders"
      },
      "relationships": {}
    },
    {
      "id": "5a28686b-f4d8-4c24-99ba-4db997d81512",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-22T09:25:17.848318+00:00",
        "updated_at": "2024-07-22T09:25:17.848318+00:00",
        "category": "note_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "edaa2dd6-5a09-42dd-8e2e-052e6fac9c99",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-22T09:25:17.848318+00:00",
        "updated_at": "2024-07-22T09:25:17.848318+00:00",
        "category": "webshop_order_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/notification_subscriptions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=created_at,updated_at,category`
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
`category` | **String** <br>`eq`
`global` | **Boolean** <br>`eq`
`owner_id` | **Uuid** <br>`eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Listing global notification subscriptions



> How to fetch a list of global notification subscriptions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions?filter%5Bglobal%5D=true' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1eb2002b-7218-4fac-9c55-3a741f608f57",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-22T09:25:19.290964+00:00",
        "updated_at": "2024-07-22T09:25:19.290964+00:00",
        "category": "order_started",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "f00c1738-1ead-4252-94a2-3bae22e3b503",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-22T09:25:19.185924+00:00",
        "updated_at": "2024-07-22T09:25:19.185924+00:00",
        "category": "note_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "3e0536a9-0e21-43d0-99fb-82af590ede2c",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-22T09:25:19.185924+00:00",
        "updated_at": "2024-07-22T09:25:19.185924+00:00",
        "category": "webshop_order_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/notification_subscriptions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=created_at,updated_at,category`
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
`category` | **String** <br>`eq`
`global` | **Boolean** <br>`eq`
`owner_id` | **Uuid** <br>`eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Listing non-global/ owned notification subscriptions



> How to fetch a list of non-global/owned notification subscriptions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions?filter%5Bglobal%5D=false' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c88b92a8-0251-4c66-8115-7ad462391ff5",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-22T09:25:21.900297+00:00",
        "updated_at": "2024-07-22T09:25:21.900297+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "4e0ed915-d3df-406a-833c-4f9a68a5f09a",
        "owner_type": "orders"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/notification_subscriptions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=created_at,updated_at,category`
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
`category` | **String** <br>`eq`
`global` | **Boolean** <br>`eq`
`owner_id` | **Uuid** <br>`eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a notification subscription



> How to fetch a notification subscription:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/ca2d0365-1328-4a92-957c-05b54c073ffa' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ca2d0365-1328-4a92-957c-05b54c073ffa",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-07-22T09:25:19.855561+00:00",
      "updated_at": "2024-07-22T09:25:19.855561+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "e06ec619-9d86-4dac-98fe-57c341c2f17c",
      "owner_type": "orders"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/notification_subscriptions/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=created_at,updated_at,category`


### Includes

This request does not accept any includes
## Creating a notification subscription



> How to create a notification_subscription:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "notification_subscriptions",
        "attributes": {
          "category": "order_updated",
          "owner_id": "7e1bb304-1666-4d1f-825a-4a7e36b3c17f",
          "owner_type": "orders"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "14c0d311-6880-4466-920c-75f8fe4f25d5",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-07-22T09:25:20.651171+00:00",
      "updated_at": "2024-07-22T09:25:20.651171+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "7e1bb304-1666-4d1f-825a-4a7e36b3c17f",
      "owner_type": "orders"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/notification_subscriptions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=created_at,updated_at,category`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][category]` | **String** <br>One of `note_created`, `webshop_order_created`, `order_updated`, `order_reserved`, `order_started`, `order_stopped`
`data[attributes][owner_id]` | **Uuid** <br>ID of the resource the notifications subscription is associated with
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`


### Includes

This request does not accept any includes
## Deleting a notification subscription



> How to delete a notification subscription:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/795619d3-c636-4d4a-8614-420ee3f50069' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "795619d3-c636-4d4a-8614-420ee3f50069",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-07-22T09:25:21.279043+00:00",
      "updated_at": "2024-07-22T09:25:21.279043+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "c0d80469-d824-4242-8ac3-d805cbbc2416",
      "owner_type": "orders"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/notification_subscriptions/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=created_at,updated_at,category`


### Includes

This request does not accept any includes