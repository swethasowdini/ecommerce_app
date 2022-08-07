import 'package:equatable/equatable.dart';

import '../data/model/food.dart';

abstract class ShoppingEvent extends Equatable {}

class ShoppingFoodEvent extends ShoppingEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ItemAddedCartEvent extends ShoppingEvent {
  List<Datum> cartItems;

  ItemAddedCartEvent({this.cartItems});
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ItemDeleteCartEvent extends ShoppingEvent {
  List<Datum> cartItems;
  int index;
  ItemDeleteCartEvent({this.cartItems, this.index});
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ItemAddingCartEvent extends ShoppingEvent {
  List<Datum> cartItems;
  int index;
  ItemAddingCartEvent({this.cartItems, this.index});
  @override
  // TODO: implement props
  List<Object> get props => [];
}
