import './Product.css'
import React from 'react'

const axios = require('axios').default

class Product extends React.Component {
  constructor(props) {
    super(props)

    this.addToCart = this.addToCart.bind(this)
  }

  addToCart() {
    const cartId = parseInt(this.props.cartId)
    const productId = parseInt(this.props.productData.id)
    axios.post(`//localhost:3000/carts/${cartId}/cart_items`, { product_id: productId })
      .then(response => {
        this.props.onAddToCart()
      })
      .catch(error => console.log(error))
  }


  render() {

    const { productData } = this.props

    function PromotionTag(props) {
      if (props.product.promotion_rules.length >= 1) {
        return <div className="text-white text-center bg-pink-500">{productData.promotion_rules.map(rule => rule.name)}</div>
      } else {
        return ''
      }
    }
    return (
      <div key={productData.id} className="Product shadow-sm bg-gray-100 border border-gray-200 rounded flex-col flex justify-between">
        <div className="group relative">
          <div className="w-full min-h-80 bg-gray-200 aspect-w-1 aspect-h-1 rounded-md overflow-hidden group-hover:opacity-75 lg:h-80 lg:aspect-none">
            <img src="https://tailwindui.com/img/ecommerce-images/product-page-01-related-product-01.jpg" alt="Front of men&#039;s Basic Tee in black." className="w-full h-full object-center object-cover lg:w-full lg:h-full" />
          </div>
          <div className="m-4 flex justify-between">
            <div>
              <h3 className="text-sm text-gray-700">
                <a href="#">
                  <span aria-hidden="true" className="absolute inset-0"></span>
                  {productData.name}
                </a>
              </h3>
              <p className="mt-1 text-sm text-gray-500">{productData.description}</p>
            </div>
            <p className="text-sm font-medium text-gray-900">
              {productData.price}
            </p>
          </div>
        </div>
        <div className="w-full">
          <PromotionTag product={productData} />
          <button onClick={this.addToCart} className="mt-4 w-full bg-indigo-600 border border-transparent rounded py-3 px-8 flex items-center justify-center text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Add to cart</button>
        </div>
      </div>
    )

  }

}
export default Product
