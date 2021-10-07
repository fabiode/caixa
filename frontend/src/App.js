import './App.css';
import Product from './components/Product.js'
import Cart from './components/Cart.js'
import React from 'react'
import { ShoppingCartIcon } from '@heroicons/react/solid'

const apiUrl = `${process.env.REACT_APP_API_URL}:3000`
const axios = require('axios').default

class App extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      isOpen: true,
      products: [],
      cartId: null,
      totalPrice: '',
      promotionRules: [],
      cartItems: []
    }

    this.cartOpen = this.cartOpen.bind(this)
    this.fetchCart = this.fetchCart.bind(this)
    this.fetchAndOpen = this.fetchAndOpen.bind(this)
  }

  componentDidMount() {
    this.fetchProducts()
    this.fetchCart()
    debugger
  }

  fetchProducts() {
    axios.get(`${apiUrl}/products`)
      .then(response => {
        this.setState({
          products: response.data
        })
      })
      .catch(error => console.log(error))
  }

  fetchCart() {
    axios.get(`${apiUrl}`)
      .then(response => {
        this.setState({
          cartId: response.data.id,
          totalPrice: response.data.total_price,
          promotionRules: response.data.promotion_rules,
          cartItems: response.data.items
        })
      })
      .catch(error => console.log(error))
  }

  fetchAndOpen() {
    this.fetchCart()
    this.cartOpen()
  }


  cartOpen = (openState = true) => {
    this.setState({ cartOpen: openState })
  }

  render() {


    return (
      <div className="App" >
        <div className="container mx-auto">
          <header className="App-header text-left flex justify-between">
            <h1 className="text-base font-black md:text-8xl sm:text-lg">la caixa registradora</h1>
            <button onClick={() => { this.cartOpen() }}>
              <ShoppingCartIcon className="text-blue-500 w-5 h-5 inline-block" /> Your cart
            </button>
          </header>
          <div className="mt-6 grid grid-cols-1 gap-y-10 gap-x-6 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
            {this.state.products.map(product =>
              < Product productData={product} cartId={this.state.cartId} key={product.id} onAddToCart={this.fetchAndOpen} />
            )}
          </div>
          <Cart isOpen={this.state.isOpen} cartId={this.state.cartId} totalPrice={this.state.totalPrice} promotionRules={this.state.promotionRules} cartItems={this.state.cartItems} parentCallback={this.cartOpen} updateCallback={this.fetchCart} />
        </div>

      </div>
    );

  }
}

export default App
