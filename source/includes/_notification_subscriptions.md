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
      "id": "940438a1-225e-4e50-a948-380499aed062",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-06-10T09:26:27.404168+00:00",
        "updated_at": "2024-06-10T09:26:27.404168+00:00",
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
      "id": "bcceb5c6-fef7-4da5-b819-90d8a95dd795",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-06-10T09:26:27.397748+00:00",
        "updated_at": "2024-06-10T09:26:27.397748+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "1f853c1c-b546-4664-9e86-77cfe607a6dd",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/1f853c1c-b546-4664-9e86-77cfe607a6dd"
          }
        }
      }
    },
    {
      "id": "e8e79169-a9d1-4814-9804-6d1723e33c75",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-06-10T09:26:27.351670+00:00",
        "updated_at": "2024-06-10T09:26:27.351670+00:00",
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
      "id": "127288a3-a5e7-43fe-9965-454800055c24",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-06-10T09:26:27.351670+00:00",
        "updated_at": "2024-06-10T09:26:27.351670+00:00",
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
      "id": "b358586a-e53d-4553-bd03-8028d783246b",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-06-10T09:26:26.200979+00:00",
        "updated_at": "2024-06-10T09:26:26.200979+00:00",
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
      "id": "13084eb4-164f-41ba-941c-da8fbdf7e8da",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-06-10T09:26:26.128603+00:00",
        "updated_at": "2024-06-10T09:26:26.128603+00:00",
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
      "id": "8bb8ca16-0fe3-484a-9bd6-f90d54a4f6d5",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-06-10T09:26:26.128603+00:00",
        "updated_at": "2024-06-10T09:26:26.128603+00:00",
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
      "id": "57678223-e673-442e-b2d3-4a91468215c8",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2024-06-10T09:26:24.282474+00:00",
        "updated_at": "2024-06-10T09:26:24.282474+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "0199b986-8b78-468a-997a-958275bb9013",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/0199b986-8b78-468a-997a-958275bb9013"
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
## Fetching a notification subscription



> How to fetch a notification subscription:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/5deac2d9-bdf5-4fe8-8796-ec48fdd17e5c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5deac2d9-bdf5-4fe8-8796-ec48fdd17e5c",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-06-10T09:26:24.887514+00:00",
      "updated_at": "2024-06-10T09:26:24.887514+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "9b1d5dca-2430-4add-b9a1-9f9c19032952",
      "owner_type": "orders"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/9b1d5dca-2430-4add-b9a1-9f9c19032952"
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
          "owner_id": "7fd57552-5db5-4f29-aa5f-a6298d6163f3",
          "owner_type": "orders"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "763fa419-3c4e-4d63-9831-f79ae2096bb2",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-06-10T09:26:25.558773+00:00",
      "updated_at": "2024-06-10T09:26:25.558773+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "7fd57552-5db5-4f29-aa5f-a6298d6163f3",
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
## Deleting a notification subscription



> How to delete a notification subscription:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/80399769-e811-4692-8278-93e1707920b7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "80399769-e811-4692-8278-93e1707920b7",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2024-06-10T09:26:26.790412+00:00",
      "updated_at": "2024-06-10T09:26:26.790412+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "098aa320-4acb-4afd-9c6c-ce0616bdbe23",
      "owner_type": "orders"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/098aa320-4acb-4afd-9c6c-ce0616bdbe23"
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