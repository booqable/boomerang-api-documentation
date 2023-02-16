# Notification subscriptions

Notification subscriptions can be used to subscribe an employee to a specific category of notications. Booqable offers several categories of notifications:

1. `note_created` for when a new note is created.
2. `webshop_order_created` for when a new order was create via the webshop.
3. `order_reserved` for when an order first transitions into the reserved state.
4. `order_updated` for any update to an order
5. `order_started` for when an order started plannings
6. `order_stopped` for when an order stopped plannings

All categories, except for `webshop_order_created`, can be associated with an owner. At the time of this writing the owner must be an Order.

When a notification subscriptions is associated with an owner, the notification will only be fired for the given owner.

Multiple owned notification subsscriptions can be created for any employee. If the employee has an unowned notification subscription and an owned notification subscription for the same category, a single notification will send for the associated owner.

## Endpoints
`GET /api/boomerang/notification_subscriptions`

`GET /api/boomerang/notification_subscriptions/{id}`

`POST /api/boomerang/notification_subscriptions`

`DELETE /api/boomerang/notification_subscriptions/{id}`

## Fields
Every notification subscription has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`category` | **String** <br>One of `note_created`, `webshop_order_created`, `order_updated`, `order_reserved`, `order_started`, `order_stopped`
`global` | **Boolean** `nullable` `readonly`<br>Will be set true when the subscription is not associated with any owner, flase otherwise
`owner_id` | **Uuid** <br>ID of the resource the notications subscription is associated with
`owner_type` | **String** <br>The resource type of the owner. One of `orders`


## Relationships
Notification subscriptions have the following relationships:

Name | Description
- | -
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
      "id": "3082590a-0bba-4619-934c-d66cc6c947ad",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-16T22:57:11+00:00",
        "updated_at": "2023-02-16T22:57:11+00:00",
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
      "id": "58686508-f299-4f2e-a83c-2e155d997610",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-16T22:57:11+00:00",
        "updated_at": "2023-02-16T22:57:11+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "d2ea396a-be96-49b9-a739-f6db9453df8e",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/d2ea396a-be96-49b9-a739-f6db9453df8e"
          }
        }
      }
    },
    {
      "id": "222fbec9-0ddc-4128-98a1-4e4e100b38f8",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-16T22:57:11+00:00",
        "updated_at": "2023-02-16T22:57:11+00:00",
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
      "id": "2238e0d4-8e80-40f7-88b3-17affeed3192",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-16T22:57:11+00:00",
        "updated_at": "2023-02-16T22:57:11+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T22:54:51Z`
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
`category` | **String** <br>`eq`
`global` | **Boolean** <br>`eq`
`owner_id` | **Uuid** <br>`eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
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
      "id": "7350ab7a-9c3b-4e7b-bb9b-ba9df68ddbe4",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-16T22:57:12+00:00",
        "updated_at": "2023-02-16T22:57:12+00:00",
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
      "id": "c3c1cbed-aa56-43a9-8ac5-5ced615b3533",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-16T22:57:12+00:00",
        "updated_at": "2023-02-16T22:57:12+00:00",
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
      "id": "c4e3cb03-f99e-4f7d-b60a-b5c389c843c4",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-16T22:57:12+00:00",
        "updated_at": "2023-02-16T22:57:12+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T22:54:51Z`
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
`category` | **String** <br>`eq`
`global` | **Boolean** <br>`eq`
`owner_id` | **Uuid** <br>`eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
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
      "id": "d76b3dad-60eb-4a17-9b49-56de7d39fb52",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-16T22:57:12+00:00",
        "updated_at": "2023-02-16T22:57:12+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "9c723026-670e-49fe-8386-c8e0fa6ace02",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/9c723026-670e-49fe-8386-c8e0fa6ace02"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T22:54:51Z`
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
`category` | **String** <br>`eq`
`global` | **Boolean** <br>`eq`
`owner_id` | **Uuid** <br>`eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a notification subscription



> How to fetch a notification subscription:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/a8052348-399f-4c26-a5ff-89c001d6f394' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a8052348-399f-4c26-a5ff-89c001d6f394",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2023-02-16T22:57:13+00:00",
      "updated_at": "2023-02-16T22:57:13+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "e9e7d38a-b770-4170-ba1d-906af9a02c18",
      "owner_type": "orders"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/e9e7d38a-b770-4170-ba1d-906af9a02c18"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=id,created_at,updated_at`


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
          "owner_id": "5fafc7b3-78af-4326-8fe1-c5e2e36ae7ac",
          "owner_type": "orders"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7d4ab431-e779-4a5a-8bf6-1244ecadf642",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2023-02-16T22:57:14+00:00",
      "updated_at": "2023-02-16T22:57:14+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "5fafc7b3-78af-4326-8fe1-c5e2e36ae7ac",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][category]` | **String** <br>One of `note_created`, `webshop_order_created`, `order_updated`, `order_reserved`, `order_started`, `order_stopped`
`data[attributes][owner_id]` | **Uuid** <br>ID of the resource the notications subscription is associated with
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`


### Includes

This request does not accept any includes
## Deleting a notification subscription



> How to delete a notification subscription:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/0bde86db-5ef4-42fd-911d-29c5d46d5921' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/notification_subscriptions/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notification_subscriptions]=id,created_at,updated_at`


### Includes

This request does not accept any includes