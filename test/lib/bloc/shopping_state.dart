import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../data/model/food.dart';

abstract class ShoppingState extends Equatable {}

class ShoppingInitialState extends ShoppingState {
  @override
  List<Object> get props => [];
}

class ShoppingLoadingState extends ShoppingState {
  @override
  List<Object> get props => [];
}

class ShoppingLoadedState extends ShoppingState {
  List<Datum> recipes;
  ShoppingLoadedState({@required this.recipes});
  @override
  List<Object> get props => null;
}

class ShoppingErrorState extends ShoppingState {
  String message;
  ShoppingErrorState({@required this.message});
  @override
  List<Object> get props => null;
}

class ItemAddedCartState extends ShoppingState {
  List<Datum> cartItems;

  ItemAddedCartState({this.cartItems});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ItemDeletingCartState extends ShoppingState {
  List<Datum> cartItems;

  ItemDeletingCartState({this.cartItems});
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ItemAddingCartState extends ShoppingState {
  List<Datum> cartItems;

  ItemAddingCartState({this.cartItems});
  @override
  // TODO: implement props
  List<Object> get props => null;
}


class PostsLoading extends ShoppingState {
  final List<Datum> oldPosts;
  final bool isFirstFetch;

  PostsLoading(this.oldPosts, {this.isFirstFetch=false});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}