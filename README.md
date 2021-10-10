caixa registradora app
---

The goal of this application was to built a simple shopping cart, but with promotion rules that provides discounts or free products.

**Backend** was built using Ruby 2.7.4 and Rails 6.1.4, while **Frontend** uses React 17.0.2.

## Modeling and data structure

The backend app consists of the following models:

### Cart

Cart model is responsible for grouping the cart items, dealing logic when products are added to itself, delegating the verification of elegible promotions to each product and also recalculating the total price of the purchase.

**Obs.:** The application is currently using a single cart, therefore it will be shared among sessions. 

### CartItem

Cart item is an abstraction model, that projects the product added to the cart. It is responsible for quantity and price condition, as well if the item is promotional (created as a consequence of a promotion).

### Product

Product holds information about the product: name, price and description.

### PromotionRule

This is the parent model of a **Single Table Inheritance** schema, which are the base of calculation to apply discounts or any effects of the promotion rule in cart items, using an enum `kind` to specify which type of discount is given (_percentage or fixed amount_. Descendents of this STI are nested in `PromotionRules` module and they are:

#### PromotionRules::BuyOneGetOne

This rule duplicates the respective cart item in which a product has this promotion, zeroing the price and setting the duplicated one as `promotional`. If if not eligible, it removes the promotional cart item.

#### PromotionRules::Bulk

This rule is eligible if product's cart item has 3 or more as quantity in the cart. The amount is specified by `kind` enum and `amount` or `percentage` values.

**Obs.:** The approach used to built promotions relies on ActiveRecord, to avoid rules to be hardcoded, therefore anything can be changed on-the-fly, i.e.: changing the amount, combining more than one promotion to the same product, etc.

The default products and their respective promotions are created through `rake db:seed`.

## Building and running

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

## Next steps

 - Extract promotion and cart item operation to a Service Object;
 - Setup cart creation using user session, so then each user will have a cart;
 - Frontend tests using Jest.
