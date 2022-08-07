import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_app/bloc/shopping_event.dart';

import '../bloc/shopping_bloc.dart';
import '../bloc/shopping_state.dart';
import '../data/model/food.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Datum> cartItems;
  double totalAmount = 0;
  void calculateTotalAmount(List<Datum> list) {
    double res = 0;

    list.forEach((element) {
      res = res + element.price * element.quantity;
    });
    totalAmount = res;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingBloc, ShoppingState>(
      builder: (context, state) {
        if (state is ItemAddedCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        if (state is ShoppingLoadedState) {
          cartItems = state.recipes;
          calculateTotalAmount(cartItems);
        }
        if (state is ItemDeletingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }

        if (state is ItemAddingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Shopping Cart',
            ),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          bottomNavigationBar: Container(
            height: 68,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    color: Color(0xFF000000).withOpacity(0.20),
                  ),
                  BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 3,
                    color: Color(0xFF000000).withOpacity(0.20),
                  ),
                  BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 4,
                    color: Color(0xFF000000).withOpacity(0.14),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                )),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text('Total Amount'),
                  Text('\$${totalAmount.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
          body: cartItems == null || cartItems.length == 0
              ? Center(child: Text('Your Cart is Empty'))
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    cartItems[index].featuredImage,
                                    height: 64,
                                    width: 64,
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                      width: 120,
                                      child: Text(
                                        cartItems[index].title,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      )),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      setState(() {
                                        if (state is ShoppingLoadedState) {
                                          state.recipes.removeAt(index);
                                          calculateTotalAmount(cartItems);
                                          BlocProvider.of<ShoppingBloc>(context)
                                            ..add(ItemDeleteCartEvent(
                                                cartItems: state.recipes));
                                        } else if (state
                                            is ItemAddedCartState) {
                                          state.cartItems.removeAt(index);
                                          calculateTotalAmount(cartItems);

                                          BlocProvider.of<ShoppingBloc>(context)
                                            ..add(ItemDeleteCartEvent(
                                                cartItems: state.cartItems));
                                        } else if (state
                                            is ItemDeletingCartState) {
                                          state.cartItems.removeAt(index);
                                          calculateTotalAmount(cartItems);

                                          BlocProvider.of<ShoppingBloc>(context)
                                            ..add(ItemDeleteCartEvent(
                                                cartItems: state.cartItems));
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      if (cartItems[index].quantity > 0)
                                        setState(() {
                                          calculateTotalAmount(cartItems);
                                          cartItems[index].quantity--;
                                        });
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 0.5)),
                                      child: Text(
                                        cartItems[index].quantity.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        calculateTotalAmount(cartItems);
                                        cartItems[index].quantity++;
                                      });
                                    },
                                  ),
                                  Spacer(),
                                  Text(
                                      '\$${cartItems[index].price * cartItems[index].quantity} ')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
