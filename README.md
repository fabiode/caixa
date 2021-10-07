caixa registradora app
---

To run this sample app in local environment, you will need **Docker** and **docker-compose**.

## Using docker-compose

Build image using:

```shell
docker-compose build
```

Then, run `up`:


```shell
docker-compose up -d
```

Now, create the database, run migrations and seeds:

```shell
docker-compose run caixa_api --rm rake db:create
docker-compose run caixa_api --rm rake db:migrate
docker-compose run caixa_api --rm rake db:seed
```


## Tests

### Backend

To run all tests, after setting up `docker-compose` build, just run:

```shell
docker-compose run caixa_api_test rspec spec
```

### Frontend

**TODO: Missing frontend tests**
