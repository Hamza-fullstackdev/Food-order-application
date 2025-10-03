class FoodCourierGetRepo {
  Future<void> getCategory() async {}

}
  //! http://localhost:5000/api/v1/auth/login


//! http://localhost:5000/api/v1/product/get-by-category/<paste-category-id>
/*  {
    "status": 200,
    "products": [
        {
            "_id": "68cfddefbeb001e5ef042e6a",
            "userId": "68ce85e655435a94c99dfa2e",
            "categoryId": "68c92b88cf8c8608857f0baa",
            "subcategoryId": "68c935fabc9a2919f2d784aa",
            "name": "BBQ Ranch",
            "shortDescription": "Fries with smoky BBQ sauce & ranch drizzle.",
            "description": "Golden fries drizzled with smoky barbecue sauce and creamy ranch dressing, topped with herbs for an extra zing. A perfect mix of tangy, smoky, and savory flavors that keep you coming back for more.",
            "price": 600,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/v1758453230/products/dxcyrmbjnv1cq6zltjdb.jpg",
            "imageId": "products/dxcyrmbjnv1cq6zltjdb",
            "createdAt": "2025-09-21T11:13:51.710Z",
            "updatedAt": "2025-09-24T05:31:50.463Z",
            "__v": 1,
            "variantGroups": [
                {
                    "name": "Size",
                    "isRequired": true,
                    "maxSelectable": 1,
                    "options": [
                        {
                            "name": "Small pack",
                            "price": 300,
                            "_id": "68d3824623305f0e8fd441fb"
                        },
                        {
                            "name": "Large pack",
                            "price": 600,
                            "_id": "68d3824623305f0e8fd441fc"
                        }
                    ],
                    "_id": "68d3824623305f0e8fd441fa"
                }
            ]
        },
        {
            "_id": "68cfdd7cbeb001e5ef042e51",
            "userId": "68ce85e655435a94c99dfa2e",
            "categoryId": "68c92b88cf8c8608857f0baa",
            "subcategoryId": "68c9360fbc9a2919f2d784b0",
            "name": "Loaded Fries",
            "shortDescription": "Fries topped with melted cheddar cheese.",
            "description": "Crispy fries smothered in gooey melted cheddar cheese, creating a rich and savory bite in every mouthful. Perfect for cheese lovers who crave that irresistible combination of crunch and creaminess.",
            "price": 750,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/v1758453115/products/e9cyrjqrviq0ro0mxx68.jpg",
            "imageId": "products/e9cyrjqrviq0ro0mxx68",
            "createdAt": "2025-09-21T11:11:56.111Z",
            "updatedAt": "2025-09-24T05:32:34.842Z",
            "__v": 1,
            "variantGroups": [
                {
                    "name": "Size",
                    "isRequired": true,
                    "maxSelectable": 1,
                    "options": [
                        {
                            "name": "Small pack",
                            "price": 500,
                            "_id": "68d3827223305f0e8fd44236"
                        },
                        {
                            "name": "Large pack",
                            "price": 750,
                            "_id": "68d3827223305f0e8fd44237"
                        }
                    ],
                    "_id": "68d3827223305f0e8fd44235"
                }
            ]
        },
        {
            "_id": "68cfdd32beb001e5ef042e28",
            "userId": "68ce85e655435a94c99dfa2e",
            "categoryId": "68c92b88cf8c8608857f0baa",
            "subcategoryId": "68c935edbc9a2919f2d784a4",
            "name": "Salted Fries",
            "shortDescription": "Golden, crispy fries of sea salt.",
            "description": "Freshly cut potatoes, fried to a golden crisp and lightly sprinkled with sea salt for the perfect balance of crunch and flavor. A timeless favorite, simple yet satisfying, best enjoyed with your favorite dip.",
            "price": 500,
            "image": "https://res.cloudinary.com/doobnnrrs/image/upload/v1758453041/products/xagyyzhfdacijmmbf99l.jpg",
            "imageId": "products/xagyyzhfdacijmmbf99l",
            "createdAt": "2025-09-21T11:10:42.569Z",
            "updatedAt": "2025-09-24T05:33:12.304Z",
            "__v": 1,
            "variantGroups": [
                {
                    "name": "Size",
                    "isRequired": true,
                    "maxSelectable": 1,
                    "options": [
                        {
                            "name": "Small pack",
                            "price": 300,
                            "_id": "68d3829823305f0e8fd44277"
                        },
                        {
                            "name": "Large pack",
                            "price": 500,
                            "_id": "68d3829823305f0e8fd44278"
                        }
                    ],
                    "_id": "68d3829823305f0e8fd44276"
                }
            ]
        }
    ]
}*/



  //! http://localhost:5000/api/v1/category/get-all-categories

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