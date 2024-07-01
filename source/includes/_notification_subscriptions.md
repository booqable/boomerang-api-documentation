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
      "id": "cd7bc32f-19d0-48a4-af0c-904f2e3c7758",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-01T09:23:59.745201+00:00",
        "updated_at": "2024-07-01T09:23:59.745201+00:00",
        "category": "order_started",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "6113e63e-0478-4e38-8f09-7db45fc1dbdc",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-01T09:23:59.738228+00:00",
        "updated_at": "2024-07-01T09:23:59.738228+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "c1e5b248-63e6-4d4b-b509-f9d9d57bb5a8",
        "owner_type": "orders"
      },
      "relationships": {}
    },
    {
      "id": "d27179f3-bbd8-41a9-af97-bb881fe8ee0d",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-01T09:23:59.687858+00:00",
        "updated_at": "2024-07-01T09:23:59.687858+00:00",
        "category": "note_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "e33aeaae-c7d8-49ec-88d9-6d41188737f1",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-01T09:23:59.687858+00:00",
        "updated_at": "2024-07-01T09:23:59.687858+00:00",
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
      "id": "e4235d0e-bbd9-49bb-8bfd-72c56992f912",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-01T09:24:01.583240+00:00",
        "updated_at": "2024-07-01T09:24:01.583240+00:00",
        "category": "order_started",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "ce3dfde3-36ad-4e2f-b27f-cee84399d3fb",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-01T09:24:01.517987+00:00",
        "updated_at": "2024-07-01T09:24:01.517987+00:00",
        "category": "note_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {}
    },
    {
      "id": "743f1777-6a20-444f-b515-52cfd3eaab30",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-01T09:24:01.517987+00:00",
        "updated_at": "2024-07-01T09:24:01.517987+00:00",
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
      "id": "e7b87064-3a03-495d-9f5a-7d8e31c78277",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-07-01T09:24:00.378214+00:00",
        "updated_at": "2024-07-01T09:24:00.378214+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "b6ef9e6a-f92a-4660-ac3e-cff8aed56a6d",
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
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/f0e573f9-c987-490c-8cda-a48a366e7372' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f0e573f9-c987-490c-8cda-a48a366e7372",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-07-01T09:24:02.185560+00:00",
      "updated_at": "2024-07-01T09:24:02.185560+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "dc01501d-c168-4285-9e15-e0e65b7566f8",
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
          "owner_id": "1d857913-770e-4aa7-9d1d-6fc2d40ffbec",
          "owner_type": "orders"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a33cd8c6-e2f0-4987-a4ae-b7d7a6baf6ef",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-07-01T09:23:59.172480+00:00",
      "updated_at": "2024-07-01T09:23:59.172480+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "1d857913-770e-4aa7-9d1d-6fc2d40ffbec",
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
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/496bb300-a5d0-4e0b-8e2f-4960a3228958' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "496bb300-a5d0-4e0b-8e2f-4960a3228958",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-07-01T09:24:00.948044+00:00",
      "updated_at": "2024-07-01T09:24:00.948044+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "4b6dcd39-5e17-4457-9b9c-ef3d751aad3e",
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