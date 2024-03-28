$(document).ready(function () {
    updateCart()
})


// update cart function
function updateCart() {
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);

    if (cart == null || cart.length == 0) {
        // when cart is empty
        console.log("Cart is Empty !!!");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3> Cart Empty </h3>");
        $(".checkout-btn").addClass('disabled');
    } else {
        // there is something in cart to show 

        $(".cart-items").html(` ( ${cart ? cart.length : 0} ) `);

        let table = `
        
            <table class='table'>
                <thead class='thead-light'>
                    <tr>
                        <th>Item Name </th>
                        <th> Price </th>
                        <th> Quantity </th>
                        <th> Total Price </th>
                        <th> Action </th>
                    </tr>
                </thead>

        `;

        let totalPrice = 0;
        cart.map((item) => {

            table += `
            <tr>
                <td> ${item.productName} </td>
                <td> ${item.productPrice} </td>
                <td> ${item.productQuantity} </td>
                <td> ${item.productQuantity * item.productPrice} </td>
                <td> <button class='btn btn-danger btn-sm' onclick='delete_Item(${item.productId})' >Remove</button>  </td>
            </tr>`;

            totalPrice += item.productPrice * item.productQuantity;
        });


        table = table + `
            <tr><td colspan='5' class='text-right font-weight-bold' > Total Price : ${totalPrice} </td> <tr>
        </table>`;

        $(".cart-body").html(table);
        console.log("Cart Getting Updated --------------------------");
        console.log(localStorage.getItem('cart'));


    }
}

function add_to_cart(pid, pname, price) {
    let cart = localStorage.getItem("cart");
    console.log("LocalStorage Retrieved");

    if (cart == null) {
        // cart is empty till now 
        let products = [];
        console.log("Product List Created");

        let product = {
            productId: pid,
            productName: pname,
            productQuantity: 1,
            productPrice: price
        };

        console.log("Product Object Created");

        products.push(product);
        console.log("Product Added to Cart");

        localStorage.setItem("cart", JSON.stringify(products));
        console.log("Cart Saved to LocalStorage first time");

        Toastify({

            text: "First Item Added to Cart",

            duration: 3000

        }).showToast();

    } else {
        // some products already in cart
        let pcart = JSON.parse(cart);

        let existingProductIndex = pcart.findIndex((item) => item.productId === pid);

        if (existingProductIndex !== -1) {
            // Product already exists in cart, so increment its quantity
            pcart[existingProductIndex].productQuantity += 1;
            console.log("Product Quantity Updated in Cart");
        } else {
            // Product does not exist in cart, so add it
            let product = {
                productId: pid,
                productName: pname,
                productQuantity: 1,
                productPrice: price
            };
            pcart.push(product);
            console.log("New Product Added to Cart yo ");
        }

        localStorage.setItem("cart", JSON.stringify(pcart));
        console.log("Cart Saved to LocalStorage");
        console.log(JSON.parse(localStorage.getItem("cart"))); // Move the console.log statement here
        Toastify({

            text: "Cart is Updated",

            duration: 3000

        }).showToast();
    }
    updateCart(); // Call updateCart() after updating the cart
}

function delete_Item(pid) {
    let cart = JSON.parse(localStorage.getItem("cart"));
    let newCart = cart.filter((item) => item.productId !== pid);
    localStorage.setItem("cart", JSON.stringify(newCart));
    updateCart(); // Update the cart display after item removal
}

