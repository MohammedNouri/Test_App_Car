import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_app/main.dart';


// class ViewFiltre extends StatefulWidget {
//   _ViewFiltre createState() => _ViewFiltre();
// }

// class _ViewFiltre extends State<ViewFiltre> {
//   bool isDark = false;
//   Widget build(BuildContext context) {
//     final ThemeData themeData = ThemeData(
//         useMaterial3: true,
//         brightness: isDark ? Brightness.dark : Brightness.light);
//     return MaterialApp(
//         theme: themeData,
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text("Cars View"),
//             centerTitle: true,
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   showSearch(
//                     context: context,
//                     delegate: SearchBarDelegate(),
//                   );
//                 },
//                 icon: const Icon(Icons.search),
//               ),
//               IconButton(
//                   isSelected: isDark,
//                   onPressed: () {
//                     setState(() {
//                       isDark = !isDark;
//                     });
//                   },
//                   icon: isDark
//                       ? Icon(Icons.wb_sunny_outlined)
//                       : Icon(Icons.brightness_2_outlined)),
//               IconButton(
//                 onPressed: () {
//                   ;
//                 },
//                 icon: Container(
//                   height: 50,
//                   width: 50,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage('images_Cars/3135715.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           drawer: const SideMenu(),
//           body: const FiltreView(),
//         ));
//   }
// }

class FiltreView extends StatelessWidget {
  const FiltreView({super.key, required this.name});
  final String name;
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> listFiltre = items
        .where((element) => element['marque']
            .toString()
            .toLowerCase()
            .contains(name.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text("MyView"), actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchBarDelegate(),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ]),
      body: GridView.builder(
        itemCount: listFiltre.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: ((context, index) {
          return GridItem(
            name: listFiltre[index]['name'],
            image: listFiltre[index]["image"],
            price: listFiltre[index]["price"],
          );
        }),
      ),
    );
  }
}
