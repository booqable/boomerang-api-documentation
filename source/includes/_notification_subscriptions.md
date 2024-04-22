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
`DELETE /api/boomerang/notification_subscriptions/{id}`

`GET /api/boomerang/notification_subscriptions/{id}`

`POST /api/boomerang/notification_subscriptions`

`GET /api/boomerang/notification_subscriptions`

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


## Deleting a notification subscription



> How to delete a notification subscription:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/0372f397-4527-4009-b776-4d2248397a5f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0372f397-4527-4009-b776-4d2248397a5f",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-04-22T09:27:21+00:00",
      "updated_at": "2024-04-22T09:27:21+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "274e2895-ec88-467f-8b9e-6a9acf9966ad",
      "owner_type": "orders"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/274e2895-ec88-467f-8b9e-6a9acf9966ad"
        }
      }
    }
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
## Fetching a notification subscription



> How to fetch a notification subscription:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/d39efcdc-9e04-4b33-bfca-13e1af64e886' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d39efcdc-9e04-4b33-bfca-13e1af64e886",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-04-22T09:27:22+00:00",
      "updated_at": "2024-04-22T09:27:22+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "e9fd4504-c07d-409a-ad5e-d426d6a28941",
      "owner_type": "orders"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/e9fd4504-c07d-409a-ad5e-d426d6a28941"
        }
      }
    }
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
          "owner_id": "8ff137c0-63ec-4652-b66c-a18ea355b6a9",
          "owner_type": "orders"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d9866995-ecf3-4ddd-aa72-e05af48f0bdf",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-04-22T09:27:23+00:00",
      "updated_at": "2024-04-22T09:27:23+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "8ff137c0-63ec-4652-b66c-a18ea355b6a9",
      "owner_type": "orders"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      }
    }
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
      "id": "1d5ee93f-f62b-4a58-b025-d9d3e0064fc2",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-04-22T09:27:23+00:00",
        "updated_at": "2024-04-22T09:27:23+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "a5f12991-30a4-4668-9a05-7a1c9f3dd5f8",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/a5f12991-30a4-4668-9a05-7a1c9f3dd5f8"
          }
        }
      }
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
      "id": "e5eb381e-f90b-4e12-b899-c3e2fca23a89",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-04-22T09:27:24+00:00",
        "updated_at": "2024-04-22T09:27:24+00:00",
        "category": "order_started",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {
        "owner": {
          "links": {
            "related": null
          }
        }
      }
    },
    {
      "id": "d7640909-8294-4210-9104-f960460d64ef",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-04-22T09:27:24+00:00",
        "updated_at": "2024-04-22T09:27:24+00:00",
        "category": "note_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {
        "owner": {
          "links": {
            "related": null
          }
        }
      }
    },
    {
      "id": "8109e1dd-33ae-4be4-ba6e-ff7fde1eeca9",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-04-22T09:27:24+00:00",
        "updated_at": "2024-04-22T09:27:24+00:00",
        "category": "webshop_order_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {
        "owner": {
          "links": {
            "related": null
          }
        }
      }
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
      "id": "118777bd-ff64-43aa-bb0e-853dda1fb7cf",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-04-22T09:27:24+00:00",
        "updated_at": "2024-04-22T09:27:24+00:00",
        "category": "order_started",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {
        "owner": {
          "links": {
            "related": null
          }
        }
      }
    },
    {
      "id": "33cce101-047b-4255-a33f-872545ddd523",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-04-22T09:27:24+00:00",
        "updated_at": "2024-04-22T09:27:24+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "c3d5baa5-2a7f-45c4-b275-1227c6b26c1e",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/c3d5baa5-2a7f-45c4-b275-1227c6b26c1e"
          }
        }
      }
    },
    {
      "id": "2831dd0d-e162-4e43-bb99-76a7c7d53065",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-04-22T09:27:24+00:00",
        "updated_at": "2024-04-22T09:27:24+00:00",
        "category": "note_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {
        "owner": {
          "links": {
            "related": null
          }
        }
      }
    },
    {
      "id": "df5bc2f3-1eae-4f5d-aa60-26aa89ba9605",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-04-22T09:27:24+00:00",
        "updated_at": "2024-04-22T09:27:24+00:00",
        "category": "webshop_order_created",
        "global": true,
        "owner_id": null,
        "owner_type": null
      },
      "relationships": {
        "owner": {
          "links": {
            "related": null
          }
        }
      }
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