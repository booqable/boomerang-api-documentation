# Price rules

A price rule contains a single pricing adjustment rule and belongs to a price ruleset.

A price rule can have one of these types:

- **range_of_days**: Adjust pricing for certain days of the week, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from_day`,`till_day`,`from_time,`till_time` and `value`.
- **range_of_dates**: Adjust pricing for certain calendar days, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from`,`till` and `value`.
- **pickup_day**: Rule determines if entire day is charged based on pickup day time, `match_strategy` must be `starts_within`, `charge` determines if day is charged when before `time` or not charged if after `time`.
- **return_day**: Rule determines if entire day is charged based on return day time, `match_strategy` must be `stops_within`, `charge` determines if day is charged when before `time` or not charged if after `time`.

and these match strategies:

- **starts_within**: Used with `pickup_day` rules
- **stops_within**: Used with `return_day` rules
- **within**: Rule is applied when the rule period fits within the order period.
- **overlap**: Rule is applied for the part of the rule period that overlaps the order period.
- **span**: Rule is applied when the rule period spans over the order period.

as well as these adjustment strategies:

- **charge**: Applies `charge` attribute to determine rule effect, either charges or doesn't charge. Used by `pickup_day` and `return_day` rules types.
- **percentage**: Applies `value` attribute to determine the percentage change to the pricing over the rule period. Used by `range_of_days`, `range_of_date` rule types.

## Endpoints
`POST /api/boomerang/price_rules`

`PUT /api/boomerang/price_rules/{id}`

`DELETE /api/boomerang/price_rules/{id}`

## Fields
Every price rule has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the rule
`rule_type` | **String**<br>Determines rule behaviour. One of `range_of_days`, `range_of_dates`, `pickup_day`, `return_day`
`match_strategy` | **String**<br>Determines how dates are matched to the rule. One of `starts_within`, `stops_within`, `overlap`, `span`, `within`
`adjustment_strategy` | **String**<br>Determines wether a price rule adjusts prices by percentage or exact cent ammounts. One of `percentage`, `charge`
`value` | **Float**<br>Adjustment value in percent
`from` | **Datetime**<br>Defines start of period, used by `range_of_dates` rule type
`till` | **Datetime**<br>Defines end of period, used by `range_of_dates` rule type
`from_day` | **Integer**<br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type
`till_day` | **Integer**<br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type
`from_time` | **String**<br>Defines start of period time, `HH:mm` format, used by `range_of_days` rule type
`till_time` | **String**<br>Defines end of period time, `HH:mm` format, used by `range_of_days` rule type
`charge` | **Boolean**<br>Determines effect of rules using charge attribute
`stacked` | **Boolean**<br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules
`time` | **String**<br>Defines time for adjustment, `HH:mm` format, used by `pickup_day`, `return_day` rule types
`price_ruleset_id` | **Uuid**<br>The associated Price ruleset


## Relationships
Price rules have the following relationships:

Name | Description
- | -
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset


## Creating a price rule



> How to create a price rule:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/price_rules' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "price_rules",
        "attributes": {
          "price_ruleset_id": "6219140d-1bea-4a7c-be5c-1e67bfe00a69",
          "name": "Off season",
          "rule_type": "range_of_dates",
          "match_strategy": "span",
          "value": 25,
          "from": "2022-02-15T10:36:13.590Z",
          "till": "2022-04-15T10:36:13.590Z"
        }
      },
      "include": "price_rules"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a24a580a-582c-4110-9803-afb7ef607c69",
    "type": "price_rules",
    "attributes": {
      "created_at": "2022-03-15T10:36:13+00:00",
      "updated_at": "2022-03-15T10:36:13+00:00",
      "name": "Off season",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 25.0,
      "from": "2022-02-15T10:36:13+00:00",
      "till": "2022-04-15T10:36:13+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "price_ruleset_id": "6219140d-1bea-4a7c-be5c-1e67bfe00a69"
    },
    "relationships": {
      "price_ruleset": {
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

`POST /api/boomerang/price_rules`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_ruleset`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rules]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the rule
`data[attributes][rule_type]` | **String**<br>Determines rule behaviour. One of `range_of_days`, `range_of_dates`, `pickup_day`, `return_day`
`data[attributes][match_strategy]` | **String**<br>Determines how dates are matched to the rule. One of `starts_within`, `stops_within`, `overlap`, `span`, `within`
`data[attributes][adjustment_strategy]` | **String**<br>Determines wether a price rule adjusts prices by percentage or exact cent ammounts. One of `percentage`, `charge`
`data[attributes][value]` | **Float**<br>Adjustment value in percent
`data[attributes][from]` | **Datetime**<br>Defines start of period, used by `range_of_dates` rule type
`data[attributes][till]` | **Datetime**<br>Defines end of period, used by `range_of_dates` rule type
`data[attributes][from_day]` | **Integer**<br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][till_day]` | **Integer**<br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][from_time]` | **String**<br>Defines start of period time, `HH:mm` format, used by `range_of_days` rule type
`data[attributes][till_time]` | **String**<br>Defines end of period time, `HH:mm` format, used by `range_of_days` rule type
`data[attributes][charge]` | **Boolean**<br>Determines effect of rules using charge attribute
`data[attributes][stacked]` | **Boolean**<br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules
`data[attributes][time]` | **String**<br>Defines time for adjustment, `HH:mm` format, used by `pickup_day`, `return_day` rule types
`data[attributes][price_ruleset_id]` | **Uuid**<br>The associated Price ruleset


### Includes

This request does not accept any includes
## Updating a price rule



> How to update a price rule:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rules/fd338147-6589-4527-b54f-2aaa5211ffda' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fd338147-6589-4527-b54f-2aaa5211ffda",
        "type": "price_rules",
        "attributes": {
          "value": 10
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fd338147-6589-4527-b54f-2aaa5211ffda",
    "type": "price_rules",
    "attributes": {
      "created_at": "2022-03-15T10:36:13+00:00",
      "updated_at": "2022-03-15T10:36:13+00:00",
      "name": "Holidays",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 10.0,
      "from": "2030-12-01T00:00:00+00:00",
      "till": "2031-01-31T00:00:00+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "price_ruleset_id": "4d347dcb-ba8b-4d00-a264-8c8184ef3928"
    },
    "relationships": {
      "price_ruleset": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Updating a price rule:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rules/d0e19da1-4f8b-4579-9cc6-4dacbed17a2d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d0e19da1-4f8b-4579-9cc6-4dacbed17a2d",
        "type": "price_rules",
        "attributes": {
          "id": "d0e19da1-4f8b-4579-9cc6-4dacbed17a2d",
          "name": "Off season"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d0e19da1-4f8b-4579-9cc6-4dacbed17a2d",
    "type": "price_rules",
    "attributes": {
      "created_at": "2022-03-15T10:36:14+00:00",
      "updated_at": "2022-03-15T10:36:14+00:00",
      "name": "Off season",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 5.0,
      "from": "2030-12-01T00:00:00+00:00",
      "till": "2031-01-31T00:00:00+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "price_ruleset_id": "dab0d2b3-d0fe-444f-9368-9af16cb4702c"
    },
    "relationships": {
      "price_ruleset": {
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

`PUT /api/boomerang/price_rules/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_ruleset`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rules]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the rule
`data[attributes][rule_type]` | **String**<br>Determines rule behaviour. One of `range_of_days`, `range_of_dates`, `pickup_day`, `return_day`
`data[attributes][match_strategy]` | **String**<br>Determines how dates are matched to the rule. One of `starts_within`, `stops_within`, `overlap`, `span`, `within`
`data[attributes][adjustment_strategy]` | **String**<br>Determines wether a price rule adjusts prices by percentage or exact cent ammounts. One of `percentage`, `charge`
`data[attributes][value]` | **Float**<br>Adjustment value in percent
`data[attributes][from]` | **Datetime**<br>Defines start of period, used by `range_of_dates` rule type
`data[attributes][till]` | **Datetime**<br>Defines end of period, used by `range_of_dates` rule type
`data[attributes][from_day]` | **Integer**<br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][till_day]` | **Integer**<br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][from_time]` | **String**<br>Defines start of period time, `HH:mm` format, used by `range_of_days` rule type
`data[attributes][till_time]` | **String**<br>Defines end of period time, `HH:mm` format, used by `range_of_days` rule type
`data[attributes][charge]` | **Boolean**<br>Determines effect of rules using charge attribute
`data[attributes][stacked]` | **Boolean**<br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules
`data[attributes][time]` | **String**<br>Defines time for adjustment, `HH:mm` format, used by `pickup_day`, `return_day` rule types
`data[attributes][price_ruleset_id]` | **Uuid**<br>The associated Price ruleset


### Includes

This request does not accept any includes
## Archiving a price rule



> How to archive a price ruleset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_rules/908d0895-558f-4dc6-9ff1-a608b4ccb59e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/price_rules/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_ruleset`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rules]=id,created_at,updated_at`


### Includes

This request does not accept any includes