import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:groceries_app/main.dart';
import 'package:groceries_app/ui/prodtc_item.dart';
import '../bloc/shopping_bloc.dart';
import '../bloc/shopping_event.dart';
import '../bloc/shopping_state.dart';
import '../data/model/food.dart';
import '../data/repositories/food_repository.dart';
import '../elements/error.dart';
import '../elements/list.dart';
import '../elements/loading.dart';
import 'shopping_cart.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool loadingData = true;
  List<Datum> _cartItems = [];
  List<Datum> shopItems;
  ShoppingBloc foodBloc;

  @override
  void initState() {
    foodBloc = BlocProvider.of<ShoppingBloc>(context);
    foodBloc.add(ShoppingFoodEvent());
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  // @override
  // void initState() {
  //   foodBloc = BlocProvider.of<FoodBloc>(context);
  //   foodBloc.add(FetchFoodEvent());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping cart"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<ShoppingBloc>(context),
                          child: ShoppingCart())));
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: height * 0.01),
                  child: Icon(Icons.shopping_cart),
                ),
                Text(
                  _cartItems.length.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<ShoppingBloc, ShoppingState>(builder: (context, state) {
        if (state is ShoppingInitialState) {
          return buildLoading();
        } else if (state is ShoppingLoadingState) {
          return buildLoading();
        } else if (state is ShoppingLoadedState) {
          return buildHintsList(state.recipes);
        } else if (state is ShoppingErrorState) {
          return buildError(state.message);
        }
        return Container();
      }),
    );
  }

  Widget buildHintsList(List<Datum> data) {
    FoodRepositoryImpl foodrepository = FoodRepositoryImpl();
    return Container(
      child: GridView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ProductItem(
            addToCart: () {
              setState(() {
                _cartItems.add(data[index]);
              });
              flutterLocalNotificationsPlugin.show(
                  0,
                  "Testing",
                  "How you doin ?",
                  NotificationDetails(
                      android: AndroidNotificationDetails(
                          channel.id, channel.name,
                          importance: Importance.high,
                          color: Colors.blue,
                          playSound: true,
                          icon: '@mipmap/ic_launcher')));
              print("added");
            },
            // productImage:
            //     shopItems[index].imageUrl,
            productImage: data[index].featuredImage,
            price: data[index].price.toDouble(),
            title: data[index].title,
            // press: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (_) => BlocProvider.value(
            //               value: BlocProvider.of<ShopBloc>(context)
            //                 ..add(ItemAddingCartEvent(cartItems: _cartItems)),
            //               child: ProductDetail(
            //                 shopItem: shopItems[index],
            //               ))));
            // },
          );
        },
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      ),
    );
  }
}
