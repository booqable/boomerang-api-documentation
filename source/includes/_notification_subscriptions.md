# Notification subscriptions

Notification subscriptions can be used to subscribe an employee to a specific category
of notifications. Booqable offers several categories of notifications:

1. `note_created` for when a new note is created.
2. `webshop_order_created` for when a new order was create via the webshop.
3. `order_reserved` for when an order first transitions into the reserved state.
4. `order_updated` for any update to an order
5. `order_started` for when an order started plannings
6. `order_stopped` for when an order stopped plannings

All categories, except for `webshop_order_created`, can be associated with an owner.
At the time of this writing the owner must be an Order.

When a notification subscriptions is associated with an owner,
the notification will only be fired for the given owner.

Multiple owned notification subscriptions can be created for any employee.
If the employee has an unowned notification subscription and an owned notification
subscription for the same category, a single notification will send for the associated owner.

## Relationships
Name | Description
-- | --
`owner` | **[Order](#orders)** `required`<br>When present, only notifications for this specific resource will be fired. Currently only Orders are supported. 


Check matching attributes under [Fields](#notification-subscriptions-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`category` | **enum** `readonly-after-create`<br>The category of notifications subscribing to.<br> One of: `note_created`, `webshop_order_created`, `order_updated`, `order_reserved`, `order_started`, `order_stopped`.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`global` | **boolean** `readonly`<br>Will be set true when the subscription is not associated with any owner, false otherwise. 
`id` | **uuid** `readonly`<br>Primary key.
`owner_id` | **uuid** `readonly-after-create`<br>When present, only notifications for this specific resource will be fired. Currently only Orders are supported. 
`owner_type` | **enum** `readonly-after-create`<br>The resource type of the owner.<br>Always `orders`
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List notification subscriptions


> How to fetch a list of notification subscriptions:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/notification_subscriptions'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "cbc577cf-16fe-4576-8ed6-44f7ab78152e",
        "type": "notification_subscriptions",
        "attributes": {
          "created_at": "2015-12-10T21:11:00.000000+00:00",
          "updated_at": "2015-12-10T21:11:00.000000+00:00",
          "category": "order_started",
          "global": true,
          "owner_id": null,
          "owner_type": ""
        },
        "relationships": {}
      },
      {
        "id": "cda6aeef-1ba9-4b6e-82e8-5b6c772939a1",
        "type": "notification_subscriptions",
        "attributes": {
          "created_at": "2015-12-10T21:11:00.000000+00:00",
          "updated_at": "2015-12-10T21:11:00.000000+00:00",
          "category": "order_updated",
          "global": false,
          "owner_id": "5449b8dc-cb8b-41a8-8491-73a77d453273",
          "owner_type": "orders"
        },
        "relationships": {}
      },
      {
        "id": "883e415b-bca8-499b-8c3b-76aa6ba5b585",
        "type": "notification_subscriptions",
        "attributes": {
          "created_at": "2015-12-10T21:11:00.000000+00:00",
          "updated_at": "2015-12-10T21:11:00.000000+00:00",
          "category": "note_created",
          "global": true,
          "owner_id": null,
          "owner_type": ""
        },
        "relationships": {}
      },
      {
        "id": "5aad1419-c996-4fec-8796-ccf4ee8f4ad3",
        "type": "notification_subscriptions",
        "attributes": {
          "created_at": "2015-12-10T21:11:00.000000+00:00",
          "updated_at": "2015-12-10T21:11:00.000000+00:00",
          "category": "webshop_order_created",
          "global": true,
          "owner_id": null,
          "owner_type": ""
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notification_subscriptions]=created_at,updated_at,category`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`category` | **string** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`global` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`owner_id` | **uuid** <br>`eq`
`owner_type` | **enum** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## List global notification subscriptions


> How to fetch a list of global notification subscriptions:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/notification_subscriptions'
       --header 'content-type: application/json'
       --data-urlencode 'filter[global]=true'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "6fb3e414-e712-4701-8c4b-e366e1e2a70f",
        "type": "notification_subscriptions",
        "attributes": {
          "created_at": "2015-10-03T03:42:01.000000+00:00",
          "updated_at": "2015-10-03T03:42:01.000000+00:00",
          "category": "order_started",
          "global": true,
          "owner_id": null,
          "owner_type": ""
        },
        "relationships": {}
      },
      {
        "id": "79a47450-bf96-4178-88ce-0690903d718a",
        "type": "notification_subscriptions",
        "attributes": {
          "created_at": "2015-10-03T03:42:01.000000+00:00",
          "updated_at": "2015-10-03T03:42:01.000000+00:00",
          "category": "note_created",
          "global": true,
          "owner_id": null,
          "owner_type": ""
        },
        "relationships": {}
      },
      {
        "id": "5507b5fc-a05e-4976-8638-3ff9fc00003f",
        "type": "notification_subscriptions",
        "attributes": {
          "created_at": "2015-10-03T03:42:01.000000+00:00",
          "updated_at": "2015-10-03T03:42:01.000000+00:00",
          "category": "webshop_order_created",
          "global": true,
          "owner_id": null,
          "owner_type": ""
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notification_subscriptions]=created_at,updated_at,category`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`category` | **string** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`global` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`owner_id` | **uuid** <br>`eq`
`owner_type` | **enum** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## List non-global/ owned notification subscriptions


> How to fetch a list of non-global/owned notification subscriptions:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/notification_subscriptions'
       --header 'content-type: application/json'
       --data-urlencode 'filter[global]=false'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "af78e169-b56a-4ae8-8ab6-704bef5a6069",
        "type": "notification_subscriptions",
        "attributes": {
          "created_at": "2016-02-10T10:37:00.000000+00:00",
          "updated_at": "2016-02-10T10:37:00.000000+00:00",
          "category": "order_updated",
          "global": false,
          "owner_id": "23ccbe38-6e90-48f7-818a-d345f34ebaf7",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notification_subscriptions]=created_at,updated_at,category`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`category` | **string** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`global` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`owner_id` | **uuid** <br>`eq`
`owner_type` | **enum** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a notification subscription


> How to fetch a notification subscription:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/notification_subscriptions/14a99f09-8eb2-468e-8247-8d74e95b1ce6'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "14a99f09-8eb2-468e-8247-8d74e95b1ce6",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2025-07-08T16:51:01.000000+00:00",
        "updated_at": "2025-07-08T16:51:01.000000+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "82b844b8-d0a3-4189-8bf0-b0775e8f91ec",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notification_subscriptions]=created_at,updated_at,category`


### Includes

This request does not accept any includes
## Create a notification subscription


> How to create a notification_subscription:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/notification_subscriptions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "notification_subscriptions",
           "attributes": {
             "category": "order_updated",
             "owner_id": "e7aa81c6-ff6c-4254-8cd8-097a0cd0c5b7",
             "owner_type": "orders"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "c545b409-2a9c-441f-82bf-e810e83260fc",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2028-03-17T00:06:01.000000+00:00",
        "updated_at": "2028-03-17T00:06:01.000000+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "e7aa81c6-ff6c-4254-8cd8-097a0cd0c5b7",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notification_subscriptions]=created_at,updated_at,category`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][category]` | **enum** <br>The category of notifications subscribing to.<br> One of: `note_created`, `webshop_order_created`, `order_updated`, `order_reserved`, `order_started`, `order_stopped`.
`data[attributes][owner_id]` | **uuid** <br>When present, only notifications for this specific resource will be fired. Currently only Orders are supported. 
`data[attributes][owner_type]` | **enum** <br>The resource type of the owner.<br>Always `orders`


### Includes

This request does not accept any includes
## Delete a notification subscription


> How to delete a notification subscription:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/c876c994-c34e-4f04-89db-1daaa7299ec5'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "c876c994-c34e-4f04-89db-1daaa7299ec5",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2015-06-03T11:11:01.000000+00:00",
        "updated_at": "2015-06-03T11:11:01.000000+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "95d531d9-925e-4753-8d37-e15e1d5cfda8",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notification_subscriptions]=created_at,updated_at,category`


### Includes

This request does not accept any includes