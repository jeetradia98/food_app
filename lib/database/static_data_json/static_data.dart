class StaticData {
  static Map<String, dynamic> screenSaverJson = {
    "ScreenSaverMasters": [
      {
        "ScreenSaverID": "314",
        "ImagePath":
            "https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?q=80&w=480&auto=format&fit=crop",
      },
      {
        "ScreenSaverID": "315",
        "ImagePath":
            "https://images.unsplash.com/photo-1606755962773-d324e0a13086?q=80&w=480&auto=format&fit=crop",
      },
    ]
  };

  static List<Map<String, dynamic>> categoryData = [
    {
      'cId': 100,
      'categoryName': 'Burger',
      'description': 'American in origin',
    },
    {
      'cId': 101,
      'categoryName': 'Soft drinks',
      'description': 'Sample desc',
    },
    {
      'cId': 102,
      'categoryName': 'Pizzas',
      'description': 'Italian in origin',
    },
  ];

  static List<Map<String, dynamic>> categoryImageData = [
    {
      'categoryImageUrl': 'https://dummyimage.com/200x200/000/fff&text=Burger',
      'categoryId': 100,
      'CImgID': 100,
    },
    {
      'categoryImageUrl':
          'https://dummyimage.com/200x200/000/fff&text=Soft drinks',
      'categoryId': 101,
      'CImgID': 101,
    },
    {
      'categoryImageUrl': 'https://dummyimage.com/200x200/000/fff&text=Pizza',
      'categoryId': 102,
      'CImgID': 102,
    },
  ];

  static List<Map<String, dynamic>> foodItemsData = [
    // Burger related data
    {
      "id": 1,
      "itemName": "Classic Burger",
      "fullDescription":
          "Beef patty, lettuce, tomato, onion, pickles, and special sauce on a sesame seed bun.",
      "price": 8.99,
    },
    {
      "id": 2,
      "itemName": "Cheeseburger",
      "fullDescription": "Classic burger with American cheese added.",
      "price": 9.99,
    },
    {
      "id": 3,
      "itemName": "Bacon Burger",
      "fullDescription": "Classic burger with crispy bacon strips.",
      "price": 10.99,
    },
    {
      "id": 4,
      "itemName": "Mushroom Swiss Burger",
      "fullDescription":
          "Classic burger with sautéed mushrooms and Swiss cheese.",
      "price": 10.99,
    },
    {
      "id": 5,
      "itemName": "BBQ Burger",
      "fullDescription":
          "Classic burger with tangy barbecue sauce and crispy onion rings.",
      "price": 11.99,
    },
    // Pizza related data
    {
      "id": 6,
      "itemName": "Margherita Pizza",
      "fullDescription": "Tomato sauce, mozzarella cheese, and fresh basil.",
      "price": 9.99,
    },
    {
      "id": 7,
      "itemName": "Pepperoni Pizza",
      "fullDescription":
          "Tomato sauce, mozzarella cheese, and slices of pepperoni.",
      "price": 10.99,
    },
    {
      "id": 8,
      "itemName": "Vegetarian Pizza",
      "fullDescription":
          "Tomato sauce, mozzarella cheese, bell peppers, onions, olives, and mushrooms.",
      "price": 11.99,
    },
    {
      "id": 9,
      "itemName": "Supreme Pizza",
      "fullDescription":
          "Tomato sauce, mozzarella cheese, pepperoni, sausage, bell peppers, onions, and olives.",
      "price": 12.99,
    },
    {
      "id": 10,
      "itemName": "Hawaiian Pizza",
      "fullDescription": "Tomato sauce, mozzarella cheese, ham, and pineapple.",
      "price": 11.99,
    },
  ];

  static List<Map<String, dynamic>> foodItemImagesData = [
    {
      "IImgID": 1,
      "imageUrl": "https://dummyimage.com/200x200/000/fff&text=Classic Burger",
      "itemId": 1
    },
    {
      "IImgID": 2,
      "imageUrl": "https://dummyimage.com/200x200/000/fff&text=Cheeseburger",
      "itemId": 2
    },
    {
      "IImgID": 3,
      "imageUrl": "https://dummyimage.com/200x200/000/fff&text=Bacon Burger",
      "itemId": 3
    },
    {
      "IImgID": 4,
      "imageUrl":
          "https://dummyimage.com/200x200/000/fff&text=Mushroom Swiss Burger",
      "itemId": 4
    },
    {
      "IImgID": 5,
      "imageUrl": "https://dummyimage.com/200x200/000/fff&text=BBQ Burger",
      "itemId": 5
    },
    {
      "IImgID": 6,
      "imageUrl":
          "https://dummyimage.com/200x200/000/fff&text=Margherita Pizza",
      "itemId": 6
    },
    {
      "IImgID": 7,
      "imageUrl": "https://dummyimage.com/200x200/000/fff&text=Pepperoni Pizza",
      "itemId": 7
    },
    {
      "IImgID": 8,
      "imageUrl":
          "https://dummyimage.com/200x200/000/fff&text=Vegetarian Pizza",
      "itemId": 8
    },
    {
      "IImgID": 9,
      "imageUrl": "https://dummyimage.com/200x200/000/fff&text=Supreme Pizza",
      "itemId": 9
    },
    {
      "IImgID": 10,
      "imageUrl": "https://dummyimage.com/200x200/000/fff&text=Hawaiian Pizza",
      "itemId": 10
    }
  ];
}
