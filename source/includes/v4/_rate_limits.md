# Rate limits and usage

The API has two independent limits. Both are reported in response headers.

## Per-minute rate limit

Requests are limited per company over a sliding window of one minute. The limit depends on your plan, and every API key and integration on the company shares the same bucket.

Header | Meaning
------ | -------
`X-RateLimit-Limit` | Requests allowed per period
`X-RateLimit-Period` | Length of the period in seconds
`X-RateLimit-Remaining` | Requests left in the current period

Exceeding the limit returns `429 Too Many Requests`. Wait for the period to pass and retry with a back-off.

## Monthly usage

Plans include a number of API calls per calendar month. Usage is reported on every counted response; the headers are omitted when your plan has no monthly limit.

Header | Meaning
------ | -------
`X-API-Usage-Limit` | Calls included in your plan per month
`X-API-Usage-Remaining` | Calls left this month
`X-API-Usage-Reset` | Unix timestamp (seconds) of the first day of next month, when the counter resets

A request counts when it is made with an API key or access token to any API version and completes with a 2xx status. Requests that fail (`401`, `429`, other `4xx` and `5xx`) do not count. Traffic from your hosted online store and checkout, and from apps installed from the Booqable app store, does not count either.

The monthly limit is advisory: requests are not blocked once it is reached. Usage beyond the included amount may be billed as overage. Contact [support@booqable.com](mailto:support@booqable.com) for the rates that apply to your plan or to raise the included amount.
