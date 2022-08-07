import 'dart:ui';

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    this.productImage,
    this.title,
    this.price,
    this.press,
    this.addToCart,
  }) : super(key: key);
  final String productImage, title;
  final double price;
  final Function press;
  final Function addToCart;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: press,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 7.0),
          child: Container(
            color: Color.fromARGB(255, 228, 227, 225),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: Container(
                      height: 90,
                      width: 100,
                      child: Image.network(productImage)),
                ),
                SizedBox(height: 8),
                SizedBox(
                    width: 100,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '\$ ${price}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    IconButton(
                      onPressed: addToCart,
                      icon: Icon(Icons.shopping_cart),
                    ),
                    // onPressed: () {
                    //   foodrepository.countdata.add(data[index]);
                    //   print(foodrepository.countdata.toString());
                    // })
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
