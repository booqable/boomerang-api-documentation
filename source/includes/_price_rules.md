# Price rules

A price rule contains a single pricing adjustment rule and belongs to a price ruleset.

A price rule can have one of these types:

- **range_of_days**: Adjust pricing for certain days of the week, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from_day`,`till_day`,`from_time,`till_time` and `value`.
- **range_of_dates**: Adjust pricing for certain calendar days, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from`,`till` and `value`.
- **exclude_week_days**: Do not charge for certain days of the week, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from_day`,`till_day`,`from_time,`till_time`.
- **exclude_date_range**: Do not charge for certain calendar days, `match_strategy` can be one of `within, overlap, span` and must be used in combination with `from`,`till`.
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
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the rule
`rule_type` | **String** <br>Determines rule behaviour. One of `range_of_days`, `range_of_dates`, `exclude_date_range`, `exclude_week_days`, `pickup_day`, `return_day`
`match_strategy` | **String** <br>Determines how dates are matched to the rule. One of `starts_within`, `stops_within`, `overlap`, `span`, `within`
`adjustment_strategy` | **String** <br>Determines wether a price rule adjusts prices by percentage or exact cent ammounts. One of `percentage`, `charge`
`value` | **Float** <br>Adjustment value in percent
`from` | **Datetime** <br>Defines start of period, used by `range_of_dates` rule type
`till` | **Datetime** <br>Defines end of period, used by `range_of_dates` rule type
`from_day` | **Integer** <br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type
`till_day` | **Integer** <br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type
`from_time` | **String** <br>Defines start of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`till_time` | **String** <br>Defines end of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`charge` | **Boolean** <br>Determines effect of rules using charge attribute
`stacked` | **Boolean** <br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules
`time` | **String** <br>Defines time for adjustment, used by `pickup_day` and `return_day` rule types. Format is a `HH:mm` string, independent of time display settings. 
`min_duration` | **Integer** <br>Rule will only be applied when order period is greater than min duration in seconds
`max_duration` | **Integer** <br>Rule will only be applied when order period is smaller than max duration in seconds
`price_ruleset_id` | **Uuid** <br>The associated Price ruleset


## Relationships
Price rules have the following relationships:

Name | Description
-- | --
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
          "price_ruleset_id": "3046cf8f-9ac5-4846-8784-853dc3cf9e10",
          "name": "Off season",
          "rule_type": "range_of_dates",
          "match_strategy": "span",
          "value": 25,
          "from": "2024-06-29T09:27:02.937Z",
          "till": "2024-08-29T09:27:02.937Z"
        }
      },
      "include": "price_rules"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e286fbdf-5380-4d8f-908e-0b5a433a874b",
    "type": "price_rules",
    "attributes": {
      "created_at": "2024-07-29T09:27:02.960793+00:00",
      "updated_at": "2024-07-29T09:27:02.960793+00:00",
      "name": "Off season",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 25.0,
      "from": "2024-06-29T09:27:02.937000+00:00",
      "till": "2024-08-29T09:27:02.937000+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "min_duration": null,
      "max_duration": null,
      "price_ruleset_id": "3046cf8f-9ac5-4846-8784-853dc3cf9e10"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/price_rules`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_ruleset`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rules]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the rule
`data[attributes][rule_type]` | **String** <br>Determines rule behaviour. One of `range_of_days`, `range_of_dates`, `exclude_date_range`, `exclude_week_days`, `pickup_day`, `return_day`
`data[attributes][match_strategy]` | **String** <br>Determines how dates are matched to the rule. One of `starts_within`, `stops_within`, `overlap`, `span`, `within`
`data[attributes][adjustment_strategy]` | **String** <br>Determines wether a price rule adjusts prices by percentage or exact cent ammounts. One of `percentage`, `charge`
`data[attributes][value]` | **Float** <br>Adjustment value in percent
`data[attributes][from]` | **Datetime** <br>Defines start of period, used by `range_of_dates` rule type
`data[attributes][till]` | **Datetime** <br>Defines end of period, used by `range_of_dates` rule type
`data[attributes][from_day]` | **Integer** <br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][till_day]` | **Integer** <br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][from_time]` | **String** <br>Defines start of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][till_time]` | **String** <br>Defines end of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][charge]` | **Boolean** <br>Determines effect of rules using charge attribute
`data[attributes][stacked]` | **Boolean** <br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules
`data[attributes][time]` | **String** <br>Defines time for adjustment, used by `pickup_day` and `return_day` rule types. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][min_duration]` | **Integer** <br>Rule will only be applied when order period is greater than min duration in seconds
`data[attributes][max_duration]` | **Integer** <br>Rule will only be applied when order period is smaller than max duration in seconds
`data[attributes][price_ruleset_id]` | **Uuid** <br>The associated Price ruleset


### Includes

This request accepts the following includes:

`price_ruleset` => 
`price_rules`








## Updating a price rule



> How to update a price rule:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rules/7838dda5-65a6-428b-a718-be7e372730e9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7838dda5-65a6-428b-a718-be7e372730e9",
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
    "id": "7838dda5-65a6-428b-a718-be7e372730e9",
    "type": "price_rules",
    "attributes": {
      "created_at": "2024-07-29T09:27:01.744550+00:00",
      "updated_at": "2024-07-29T09:27:01.772825+00:00",
      "name": "Holidays",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 10.0,
      "from": "2030-12-01T00:00:00.000000+00:00",
      "till": "2031-01-31T00:00:00.000000+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "min_duration": null,
      "max_duration": null,
      "price_ruleset_id": "c54d54c3-0bb8-491f-9a1c-1c531b572164"
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Updating a price rule:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rules/3379505a-4c9d-4b43-8e6a-a9f80ffd6717' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3379505a-4c9d-4b43-8e6a-a9f80ffd6717",
        "type": "price_rules",
        "attributes": {
          "id": "3379505a-4c9d-4b43-8e6a-a9f80ffd6717",
          "name": "Off season"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3379505a-4c9d-4b43-8e6a-a9f80ffd6717",
    "type": "price_rules",
    "attributes": {
      "created_at": "2024-07-29T09:27:02.338239+00:00",
      "updated_at": "2024-07-29T09:27:02.364253+00:00",
      "name": "Off season",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 5.0,
      "from": "2030-12-01T00:00:00.000000+00:00",
      "till": "2031-01-31T00:00:00.000000+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "min_duration": null,
      "max_duration": null,
      "price_ruleset_id": "bdc365ae-ced0-4440-848e-ea17fb0da572"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/price_rules/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_ruleset`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rules]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the rule
`data[attributes][rule_type]` | **String** <br>Determines rule behaviour. One of `range_of_days`, `range_of_dates`, `exclude_date_range`, `exclude_week_days`, `pickup_day`, `return_day`
`data[attributes][match_strategy]` | **String** <br>Determines how dates are matched to the rule. One of `starts_within`, `stops_within`, `overlap`, `span`, `within`
`data[attributes][adjustment_strategy]` | **String** <br>Determines wether a price rule adjusts prices by percentage or exact cent ammounts. One of `percentage`, `charge`
`data[attributes][value]` | **Float** <br>Adjustment value in percent
`data[attributes][from]` | **Datetime** <br>Defines start of period, used by `range_of_dates` rule type
`data[attributes][till]` | **Datetime** <br>Defines end of period, used by `range_of_dates` rule type
`data[attributes][from_day]` | **Integer** <br>Defines start of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][till_day]` | **Integer** <br>Defines end of period in weekdays, 0 is monday, used by `range_of_days` rule type
`data[attributes][from_time]` | **String** <br>Defines start of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][till_time]` | **String** <br>Defines end of period time, used by `range_of_days` rule type. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][charge]` | **Boolean** <br>Determines effect of rules using charge attribute
`data[attributes][stacked]` | **Boolean** <br>If a ruleset consists of multiple rules that adjust the product price, determines if rule should interact with other rules
`data[attributes][time]` | **String** <br>Defines time for adjustment, used by `pickup_day` and `return_day` rule types. Format is a `HH:mm` string, independent of time display settings. 
`data[attributes][min_duration]` | **Integer** <br>Rule will only be applied when order period is greater than min duration in seconds
`data[attributes][max_duration]` | **Integer** <br>Rule will only be applied when order period is smaller than max duration in seconds
`data[attributes][price_ruleset_id]` | **Uuid** <br>The associated Price ruleset


### Includes

This request accepts the following includes:

`price_ruleset` => 
`price_rules`








## Archiving a price rule



> How to archive a price ruleset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_rules/6d27d1e6-3eec-4874-98f5-c224a18ef5c7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6d27d1e6-3eec-4874-98f5-c224a18ef5c7",
    "type": "price_rules",
    "attributes": {
      "created_at": "2024-07-29T09:27:03.508176+00:00",
      "updated_at": "2024-07-29T09:27:03.508176+00:00",
      "name": "Holidays",
      "rule_type": "range_of_dates",
      "match_strategy": "span",
      "adjustment_strategy": "percentage",
      "value": 5.0,
      "from": "2030-12-01T00:00:00.000000+00:00",
      "till": "2031-01-31T00:00:00.000000+00:00",
      "from_day": null,
      "till_day": null,
      "from_time": null,
      "till_time": null,
      "charge": null,
      "stacked": false,
      "time": null,
      "min_duration": null,
      "max_duration": null,
      "price_ruleset_id": "7b90cc35-5395-451d-9236-0acdb7364ba4"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/price_rules/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_ruleset`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rules]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`price_ruleset` => 
`price_rules`







