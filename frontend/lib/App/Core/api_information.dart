// Register Api
//URL :  http://localhost:5000/api/v1/auth/register
//  Fields Required : name, email, password 
//  Respince : status, message
// HEADER :  headers: {   "Content-Type": "multipart/form-data",   }; 
// JSON Body Format   : { "name": "Hami",  "email": "hamza@gmail.com",  "password": "12345678" }

// Responce  Recieved After APi Hit: post man: 
 /* 
{
    "status": 201,
    "message": "User registered successfully"
}*/



// Get ALL  Categories Api : 
// URL:   http://localhost:5000/api/v1/category/get-all-categories


//  headers: {
// "Content-Type": "application/json",
// "Authorization": "Bearer <Paste-Access-Token>"
// },


//!    GET ALL CATEGORIES :: 

//!   URL  : http://localhost:5000/api/v1/category/get-all-categories

//!    RESPONCE :

/*  
{
    "status": 200,
    "categories": [
        {
            "_id": "68c92b88cf8c8608857f0baa",
            "userId": "68c905dc283ed5949c12f39b",
            "name": "fries",
            "createdAt": "2025-09-16T09:19:04.592Z",
            "updatedAt": "2025-09-21T10:23:45.380Z",
            "__v": 0,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/v1758450224/category/jwhbmnhpjxdsonc9cnz2.jpg",
            "imageId": "category/jwhbmnhpjxdsonc9cnz2"
        },
        {
            "_id": "68c92b5fcf8c8608857f0ba6",
            "userId": "68c905dc283ed5949c12f39b",
            "name": "wings",
            "createdAt": "2025-09-16T09:18:23.387Z",
            "updatedAt": "2025-09-21T10:26:42.559Z",
            "__v": 0,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/v1758450401/category/ilgvlzdkgsru5kj5rxo2.jpg",
            "imageId": "category/ilgvlzdkgsru5kj5rxo2"
        },
        {
            "_id": "68c92b58cf8c8608857f0ba2",
            "userId": "68c905dc283ed5949c12f39b",
            "name": "drinks",
            "createdAt": "2025-09-16T09:18:16.144Z",
            "updatedAt": "2025-09-21T10:34:04.160Z",
            "__v": 0,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/v1758450843/category/rmmybclsu036cakprv4b.jpg",
            "imageId": "category/rmmybclsu036cakprv4b"
        },
        {
            "_id": "68c92b52cf8c8608857f0b9e",
            "userId": "68c905dc283ed5949c12f39b",
            "name": "shawarma",
            "createdAt": "2025-09-16T09:18:10.719Z",
            "updatedAt": "2025-09-21T10:33:00.403Z",
            "__v": 0,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/v1758450779/category/tqqnn4oxcvdpcu0tsz9c.jpg",
            "imageId": "category/tqqnn4oxcvdpcu0tsz9c"
        },
        {
            "_id": "68c92b3ecf8c8608857f0b9a",
            "userId": "68c905dc283ed5949c12f39b",
            "name": "pizza",
            "createdAt": "2025-09-16T09:17:50.336Z",
            "updatedAt": "2025-09-21T10:29:46.966Z",
            "__v": 0,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/v1758450585/category/ozrpsuv8zrpcxh7iogsf.jpg",
            "imageId": "category/ozrpsuv8zrpcxh7iogsf"
        },
        {
            "_id": "68c92b17cf8c8608857f0b96",
            "userId": "68c905dc283ed5949c12f39b",
            "name": "burger",
            "createdAt": "2025-09-16T09:17:11.092Z",
            "updatedAt": "2025-09-21T10:27:50.941Z",
            "__v": 0,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/v1758450469/category/d0fnmikcrhx6pqbkbm0u.jpg",
            "imageId": "category/d0fnmikcrhx6pqbkbm0u"
        }
    ]
}

*/

//! get the  prodcut by  category id:::  get specific products of category  

//!  URL :   http://localhost:5000/api/v1/product/get-by-category/68c92b88cf8c8608857f0baa
/*   

RESPONCE  :  

{
    "status": 200,
    "products": [
        {
            "_id": "68cfd9bdbeb001e5ef042c05",
            "userId": "68ce85e655435a94c99dfa2e",
            "categoryId": "68c92b3ecf8c8608857f0b9a",
            "subcategoryId": "68c931ee85d5fa42ee8ab322",
            "name": "Cheese Overload",
            "shortDescription": "Two beef patties stacked",
            "description": "For the true cheese lovers, this burger comes with two flame-grilled beef patties stacked high with gooey cheddar and mozzarella cheese. Finished with fresh lettuce, tomato, onion, and our creamy burger sauce for a rich, indulgent bite.",
            "price": 1100,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/f_auto,q_auto/v1758452156/products/iedpw3uotuzitmtm8gsk.jpg",
            "imageId": "products/iedpw3uotuzitmtm8gsk",
            "createdAt": "2025-09-21T10:55:57.873Z",
            "updatedAt": "2025-09-23T08:52:55.731Z",
            "__v": 1,
            "variantGroups": [
                {
                    "name": "Size",
                    "isRequired": true,
                    "maxSelectable": 1,
                    "options": [
                        {
                            "name": "Small",
                            "price": 550,
                            "_id": "68d25fe7f88443512114042c"
                        },
                        {
                            "name": "Medium",
                            "price": 890,
                            "_id": "68d25fe7f88443512114042d"
                        },
                        {
                            "name": "Large",
                            "price": 1100,
                            "_id": "68d25fe7f88443512114042e"
                        }
                    ],
                    "_id": "68d25fe7f88443512114042b"
                },
                {
                    "name": "Crust",
                    "isRequired": false,
                    "maxSelectable": 1,
                    "options": [
                        {
                            "name": "Thick",
                            "price": 50,
                            "_id": "68d25fe7f884435121140430"
                        },
                        {
                            "name": "Thin",
                            "price": 100,
                            "_id": "68d25fe7f884435121140431"
                        }
                    ],
                    "_id": "68d25fe7f88443512114042f"
                },
                {
                    "name": "Extra Topping",
                    "isRequired": false,
                    "maxSelectable": 2,
                    "options": [
                        {
                            "name": "Extra Cheeze",
                            "price": 150,
                            "_id": "68d25fe7f884435121140433"
                        },
                        {
                            "name": "Extra Chicken",
                            "price": 200,
                            "_id": "68d25fe7f884435121140434"
                        }
                    ],
                    "_id": "68d25fe7f884435121140432"
                }
            ]
        },
        {
            "_id": "68cfd957beb001e5ef042bec",
            "userId": "68ce85e655435a94c99dfa2e",
            "categoryId": "68c92b3ecf8c8608857f0b9a",
            "subcategoryId": "68c9313efdb294c86531073e",
            "name": "Hot & Spicy",
            "shortDescription": "Spice on full blow",
            "description": "A golden, crispy chicken fillet coated with a blend of spices, layered with tangy pickles, fresh lettuce, and a fiery sriracha mayo. Perfect for spice lovers who want a crunchy kick with every bite.",
            "price": 1200,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/f_auto,q_auto/v1758452053/products/xawr6fa8yy6djstivxwj.jpg",
            "imageId": "products/xawr6fa8yy6djstivxwj",
            "createdAt": "2025-09-21T10:54:15.030Z",
            "updatedAt": "2025-09-24T05:34:10.084Z",
            "__v": 1,
            "variantGroups": [
                {
                    "name": "Size",
                    "isRequired": true,
                    "maxSelectable": 1,
                    "options": [
                        {
                            "name": "Small",
                            "price": 700,
                            "_id": "68d382c623305f0e8fd442be"
                        },
                        {
                            "name": "Medium",
                            "price": 950,
                            "_id": "68d382c623305f0e8fd442bf"
                        },
                        {
                            "name": "Large",
                            "price": 1200,
                            "_id": "68d382c623305f0e8fd442c0"
                        }
                    ],
                    "_id": "68d382c623305f0e8fd442bd"
                }
            ]
        },
        {
            "_id": "68cfd8b8beb001e5ef042bc3",
            "userId": "68ce85e655435a94c99dfa2e",
            "categoryId": "68c92b3ecf8c8608857f0b9a",
            "subcategoryId": "68c9320285d5fa42ee8ab328",
            "name": "Milai Boti",
            "shortDescription": "Juicy beef patty pizza",
            "description": "Our Classic Beef Burger is made with a freshly grilled beef patty, topped with melted cheddar cheese, crisp lettuce, ripe tomato slices, onions, and our signature house-made burger sauce. Served on a soft, toasted sesame bun for the ultimate comfort bite.",
            "price": 1150,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/f_auto,q_auto/v1758451894/products/pt2orh1prl0nedf1p77l.jpg",
            "imageId": "products/pt2orh1prl0nedf1p77l",
            "createdAt": "2025-09-21T10:51:36.031Z",
            "updatedAt": "2025-09-24T05:35:52.513Z",
            "__v": 1,
            "variantGroups": [
                {
                    "name": "Size",
                    "isRequired": true,
                    "maxSelectable": 1,
                    "options": [
                        {
                            "name": "Small",
                            "price": 600,
                            "_id": "68d3833823305f0e8fd4436a"
                        },
                        {
                            "name": "Medium",
                            "price": 900,
                            "_id": "68d3833823305f0e8fd4436b"
                        },
                        {
                            "name": "Large",
                            "price": 1150,
                            "_id": "68d3833823305f0e8fd4436c"
                        }
                    ],
                    "_id": "68d3833823305f0e8fd44369"
                },
                {
                    "name": "Extra Topping",
                    "isRequired": false,
                    "maxSelectable": 2,
                    "options": [
                        {
                            "name": "Extra Cheeze",
                            "price": 100,
                            "_id": "68d3833823305f0e8fd4436e"
                        },
                        {
                            "name": "Extra Milai Boti",
                            "price": 200,
                            "_id": "68d3833823305f0e8fd4436f"
                        }
                    ],
                    "_id": "68d3833823305f0e8fd4436d"
                }
            ]
        },
        {
            "_id": "68c90944283ed5949c12f3c2",
            "userId": "68c905dc283ed5949c12f39b",
            "name": "Fiery Pepperoni",
            "shortDescription": "Spicy, Cheesy, Bold Flavor",
            "description": "The Fiery Pepperoni Blaze is a pizza crafted for those who love a kick of spice with every bite. It features a thin, hand-tossed crust layered with zesty tomato sauce, gooey mozzarella, and a generous topping of spicy pepperoni slices. To turn up the heat, chili flakes and jalapeños are sprinkled across the top, perfectly balanced by the richness of melted cheese. The crust is crisp on the outside yet soft inside, ensuring every bite is both crunchy and chewy. This pizza delivers the ultimate spicy, cheesy indulgence.",
            "price": 1600,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/f_auto,q_auto/v1758310853/products/vbm7ssqck2de6w0rkqse.jpg",
            "createdAt": "2025-09-16T06:52:52.448Z",
            "updatedAt": "2025-09-24T05:57:23.813Z",
            "__v": 2,
            "categoryId": "68c92b3ecf8c8608857f0b9a",
            "subcategoryId": "68c93119fdb294c865310726",
            "imageId": "products/vbm7ssqck2de6w0rkqse",
            "variantGroups": [
                {
                    "name": "Size",
                    "isRequired": true,
                    "maxSelectable": 1,
                    "options": [
                        {
                            "name": "Small",
                            "price": 800,
                            "_id": "68d3848e23305f0e8fd443cb"
                        },
                        {
                            "name": "Medium",
                            "price": 1250,
                            "_id": "68d3848e23305f0e8fd443cc"
                        },
                        {
                            "name": "Large",
                            "price": 1600,
                            "_id": "68d3848e23305f0e8fd443cd"
                        }
                    ],
                    "_id": "68d3848e23305f0e8fd443ca"
                },
                {
                    "name": "Extra Topping",
                    "isRequired": false,
                    "maxSelectable": 2,
                    "options": [
                        {
                            "name": "Extra Cheeze",
                            "price": 150,
                            "_id": "68d3848e23305f0e8fd443cf"
                        },
                        {
                            "name": "Extra Sauces",
                            "price": 200,
                            "_id": "68d3848e23305f0e8fd443d0"
                        }
                    ],
                    "_id": "68d3848e23305f0e8fd443ce"
                }
            ]
        }
    ]
}

*/
