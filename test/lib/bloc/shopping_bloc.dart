import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_app/bloc/shopping_state.dart';
import 'package:groceries_app/data/repositories/food_repository.dart';

import '../data/model/food.dart';
import 'shopping_event.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  FoodRepository repository;
  int page = 1;
  ShoppingBloc({@required this.repository}) : super(null);

  ShoppingState get initialState => ShoppingInitialState();
  @override
  Stream<ShoppingState> mapEventToState(ShoppingEvent event) async* {
    if (event is ShoppingFoodEvent) {
      yield ShoppingLoadingState();

      try {
        List<Datum> recipes = await repository.getFoods(page);
        yield ShoppingLoadedState(recipes: recipes);
      } catch (e) {
        yield ShoppingErrorState(message: e.toString());
      }
    }

    if (event is ItemAddingCartEvent) {
      yield ItemAddingCartState(cartItems: event.cartItems);
    }
    if (event is ItemAddedCartEvent) {
      yield ItemAddedCartState(cartItems: event.cartItems);
    }
    if (event is ItemDeleteCartEvent) {
      yield ItemDeletingCartState(cartItems: event.cartItems);
    }

    void loadPosts() {
      if (state is PostsLoading) return;

      final currentState = state;

      var oldPosts = <Datum>[];
      if (currentState is ShoppingLoadedState) {
        oldPosts = currentState.recipes;
      }

      emit(PostsLoading(oldPosts, isFirstFetch: page == 1));

      repository.getFoods(page).then((newPosts) {
        page++;

        final posts = (state as PostsLoading).oldPosts;
        posts.addAll(newPosts);

        emit(ShoppingLoadedState(recipes: []));
      });
    }
  }
}
