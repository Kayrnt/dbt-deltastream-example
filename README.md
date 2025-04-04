# Getting Started with dbt and Deltastream

## dbt adapter installation

### Using pip
```bash
pip install dbt-deltastream
```

### Using uv (recommended for faster installation)
```bash
uv pip install dbt-deltastream
```

## Prepare the sample project
1. Clone the current Github repository:
```bash
git clone https://github.com/Kayrnt/dbt-deltastream-example.git
```

2. Configure your `profiles.yml` in the project root directory.
You need at least a valid token.
To get a token, you can create a new token in your Deltastream account.
[Sign in the console](https://console.deltastream.io/signin) and [create an API token using SQL](https://docs.deltastream.io/reference/sql-syntax/ddl/create-api_token):
```sql
CREATE API_TOKEN api_token_name;
```

Retrieve the token value and add it to your `profiles.yml`:
```yaml
dbt_deltastream_example:
  outputs:
    dev:
      type: deltastream
      token: your-token-here
      database: dev
      schema: public
      organization_id: your-organization-id-here
```      

## Run the sample project

Create a `dev` database if it doesn't exist:

```bash
dbt run-operation create_deltastream_database --args '{database_name: dev}'
```

Then create the sources with dbt:

```bash
./create_sources.sh
```

and create the transformation with dbt:

```bash
dbt -d run
```
