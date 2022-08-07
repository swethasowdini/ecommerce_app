// import 'package:flutter/material.dart';
// import 'package:groceries_app/data/model/food.dart';

// import '../data/repositories/food_repository.dart';

// Widget buildHintsList(List<Datum> data) {
//   FoodRepositoryImpl foodrepository = FoodRepositoryImpl();
//   return Container(
//     child: GridView.builder(
//       itemCount: data.length,
//       shrinkWrap: true,
//       itemBuilder: (BuildContext context, int index) {
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
//           child: Container(
//             color: Color.fromARGB(255, 233, 229, 214),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                     height: 90,
//                     width: 100,
//                     child: Image.network(data[index].featuredImage)),
//                 SizedBox(height: 10),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(
//                         width: 100,
//                         child: Text(
//                           data[index].title,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 2,
//                         )),
//                     IconButton(
//                       icon: Icon(Icons.shopping_cart), onPressed: () {  },
//                     ),
//                     // onPressed: () {
//                     //   foodrepository.countdata.add(data[index]);
//                     //   print(foodrepository.countdata.toString());
//                     // })
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//       gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
//     ),
//   );
// }
