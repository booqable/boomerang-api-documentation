# Booqable API v4

Booqable API v4, also known as "Boomerang", is our modern, feature-rich REST API that provides comprehensive access to all rental management functionality.

## JSONAPI

With API v4, you can manage orders, customers, products, inventory, payments, and much more. It's built on the [JSON:API specification](https://jsonapi.org/) and offers advanced features like filtering, sorting, pagination, and includes for efficient data retrieval.

[API v4 documentation](/v4.html)

## Ruby client

The [BQBL.rb](https://github.com/booqable/bqbl.rb) gem provides a comprehensive Ruby interface for the Booqable API. It offers a clean, object-oriented way to interact with all API endpoints.

Key features:

- **Full resource coverage**: Access to all Booqable API resources
- **Multiple authentication methods**: API keys, OAuth2, and single-use tokens
- **Rate limiting**: Built-in handling with retry logic
- **Automatic pagination**: Fetch all pages with a single call

It's perfect for Ruby applications that need to integrate with Booqable's rental management platform. To give it a try, check out the project on [GitHub](https://github.com/booqable/bqbl.rb).
