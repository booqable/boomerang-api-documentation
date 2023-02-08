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
      "id": "4bad00e2-ab7a-4746-bbb7-b34ebfa58432",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-08T15:00:40+00:00",
        "updated_at": "2023-02-08T15:00:40+00:00",
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
      "id": "e5936d14-5351-4473-8bf7-56ab3b3cacef",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-08T15:00:40+00:00",
        "updated_at": "2023-02-08T15:00:40+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "8144d5e2-962d-4e3d-92dc-94be834f8de2",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/8144d5e2-962d-4e3d-92dc-94be834f8de2"
          }
        }
      }
    },
    {
      "id": "ad3feac8-565f-4946-bf10-a6b91b0e33fd",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-08T15:00:40+00:00",
        "updated_at": "2023-02-08T15:00:40+00:00",
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
      "id": "c6b007f1-df3d-4a91-9332-70e02b8a973c",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-08T15:00:40+00:00",
        "updated_at": "2023-02-08T15:00:40+00:00",
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:59:07Z`
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
      "id": "09d37a39-10f1-4167-b11e-93b5443877f7",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-08T15:00:41+00:00",
        "updated_at": "2023-02-08T15:00:41+00:00",
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
      "id": "ac87fdbb-fdc7-45a9-91f9-83eeffeb2242",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-08T15:00:40+00:00",
        "updated_at": "2023-02-08T15:00:40+00:00",
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
      "id": "d46bb34f-8e2a-4f5b-a173-cc12c3183a38",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-08T15:00:40+00:00",
        "updated_at": "2023-02-08T15:00:40+00:00",
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:59:07Z`
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
      "id": "a3f1b56b-50fa-43e0-adb1-c716b7124bb9",
      "type": "notification_subscriptions",
      "attributes": {
        "created_at": "2023-02-08T15:00:41+00:00",
        "updated_at": "2023-02-08T15:00:41+00:00",
        "category": "order_updated",
        "global": false,
        "owner_id": "bec5e139-a918-482c-baab-35f30e708423",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/bec5e139-a918-482c-baab-35f30e708423"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:59:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/32b3fae6-2b66-45a3-b066-bb15d80e01ce' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "32b3fae6-2b66-45a3-b066-bb15d80e01ce",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2023-02-08T15:00:41+00:00",
      "updated_at": "2023-02-08T15:00:41+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "4a63337e-bfd1-43a4-9556-cc34976db1a4",
      "owner_type": "orders"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/4a63337e-bfd1-43a4-9556-cc34976db1a4"
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
          "owner_id": "a4a1add2-cd56-4c5e-a966-3b1ff95291f1",
          "owner_type": "orders"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1bcc2e21-80de-4586-8280-dfc9729aad13",
    "type": "notification_subscriptions",
    "attributes": {
      "created_at": "2023-02-08T15:00:42+00:00",
      "updated_at": "2023-02-08T15:00:42+00:00",
      "category": "order_updated",
      "global": false,
      "owner_id": "a4a1add2-cd56-4c5e-a966-3b1ff95291f1",
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
    --url 'https://example.booqable.com/api/boomerang/notification_subscriptions/eb33a66d-870b-44fb-b9f6-e94464f7cffd' \
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