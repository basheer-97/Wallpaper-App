import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/home.dart';
import 'category_screen_item.dart';
import 'home.dart';


class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  final List<Widget> _pages = [
    MyHomePage(),
    CategoryScreen(),
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });

    }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline6.copyWith(fontWeight:FontWeight.bold),
            children: [
              TextSpan(
                text: "Wallpaper",
                style: TextStyle(color:Colors.indigo,fontSize: 25)
                ),
              TextSpan(
                text: " World",
                style: TextStyle(color:Colors.indigo,fontSize: 25)
                ),  
              ],
            ),
          ),
        ),      
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.pink,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
             title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
             title: Text('Categories'),
          ), 
        ],
      ),
    );
  }
}


/*var size=MediaQuery.of(context).size;

body: Stack(
  children: <Widget>[
    Container(
      height: size.height*0.2,
      decoration: BoxDecoration(
        color: Color(0xFF035AA6),
      ),
      ),
    SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20),
        child: Column(
          children: [
            Text(
              "Wallpaper World",
              style:Theme.of(context).textTheme.headline4.copyWith(fontWeight:FontWeight.bold)),
          ],
        ),
       ),
      ),  
  ],
), */