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
`owner` | **Order** <br>Associated Owner


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
      "id": "85c374de-6e0f-4fc8-a4c8-f9da43fcd3b6",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-10-21T09:25:20.259759+00:00",
        "updated_at": "2024-10-21T09:25:20.259759+00:00",
        "category": "order_started",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "a9bdc3db-a6cb-472f-b416-64fe1b818403",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-10-21T09:25:20.253632+00:00",
        "updated_at": "2024-10-21T09:25:20.253632+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "67092cac-c370-4062-84be-c3217f15044f",
        "owner_type": "orders"
      },
      "relationships": {}
    },
    {
      "id": "0646d7be-6e12-4087-a880-d052d28aa701",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-10-21T09:25:20.206813+00:00",
        "updated_at": "2024-10-21T09:25:20.206813+00:00",
        "category": "note_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "55a0f1e8-021b-42e1-b88f-b113e3790787",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-10-21T09:25:20.206813+00:00",
        "updated_at": "2024-10-21T09:25:20.206813+00:00",
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
      "id": "9758ba2c-89c2-4d11-9d06-6a0d00cd79e3",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-10-21T09:25:18.342671+00:00",
        "updated_at": "2024-10-21T09:25:18.342671+00:00",
        "category": "order_started",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "c3016e88-bbdd-4536-a68c-5f62a9942b7b",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-10-21T09:25:18.290561+00:00",
        "updated_at": "2024-10-21T09:25:18.290561+00:00",
        "category": "note_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "ba8202f9-1192-44eb-acd7-dcce80bcc015",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-10-21T09:25:18.290561+00:00",
        "updated_at": "2024-10-21T09:25:18.290561+00:00",
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
      "id": "37cf4ba7-32c6-4568-a0a0-b488e249e2f9",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-10-21T09:25:16.875475+00:00",
        "updated_at": "2024-10-21T09:25:16.875475+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "ac838987-a38e-4bfb-98b9-197ed3fa76fc",
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
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/b42f5cd6-3d4c-475f-8eda-df9fe71e0538' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b42f5cd6-3d4c-475f-8eda-df9fe71e0538",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-10-21T09:25:16.327826+00:00",
      "updated_at": "2024-10-21T09:25:16.327826+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "3ea08b05-187b-4160-8291-2d364bcf75fb",
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
          "owner_id": "1c05858c-5e78-4247-a025-60c6a357d6cd",
          "owner_type": "orders"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fb598352-3e3f-42e5-a023-d32fa7f3fe91",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-10-21T09:25:19.354388+00:00",
      "updated_at": "2024-10-21T09:25:19.354388+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "1c05858c-5e78-4247-a025-60c6a357d6cd",
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
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/e29be797-b8bb-4b0e-82ab-e7b8753993bc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e29be797-b8bb-4b0e-82ab-e7b8753993bc",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-10-21T09:25:15.756882+00:00",
      "updated_at": "2024-10-21T09:25:15.756882+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "9c86d8f2-7f73-4918-9f04-1e5005555644",
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