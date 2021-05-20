import 'dart:convert';

import 'package:flutter/material.dart';
import '../screens/search.dart';
import '../data/data.dart';
import '../widgets/brand.dart';
import '../models/wallpaper_model.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //List<CategoriesItem> categories = new List();
  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();

  getCuratedWallpapers() async {
    var response =  await http.get("https://api.pexels.com/v1/curated?per_page=20",
    headers: {
      "Authorization" : apiKey
    } );

    Map<String,dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {
      
    });
  }

  @override
  void initState(){
    getCuratedWallpapers();
    //categories = getCategories();
    super.initState();
  }
  Widget build(BuildContext context) {
    //var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      /* appBar: AppBar(
        title:const Text('Wallpaper World'),
        //title: brandName(),
        elevation: 0.0,
      ), */
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color:Color(0xfff5f8fd),
              borderRadius: BorderRadius.circular(30),
              ),
            margin: EdgeInsets.symmetric(horizontal:20),
            padding: EdgeInsets.symmetric(horizontal:20),
            child: Row(
              children: <Widget>[
                InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SearchBar(
                      searchQuery: searchController.text,
                    ),
                  ),
                  );
                },
                  child: Container(
                  child: Icon(
                    Icons.search,
                    ),
                    ),
              ),
              Expanded(
                  child: TextField(
                    controller: searchController,
                    textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Search for a wallpaper",
                    border: InputBorder.none,
                    ),
                    ),
              ),
            ],
            ),
          ),
          SizedBox(
            height: 10,
            ),
          Container(
            child: Text(
              "Images by Pexels",style: TextStyle(color: Colors.pink,fontStyle: FontStyle.italic,fontSize: 20,),
            ),
          ),
          SizedBox(
            height: 20,
            ),  
          wallpapersGrid(wallpapers: wallpapers,context: context),
          SizedBox(
            height: 10,
            ),   
        ],
        ),
        ),
      ),
      
    );
  }
}



/*class DisplayCategories extends StatelessWidget {

  final String title;
  final String imageUrl;

  DisplayCategories({
    @required this.title,
    @required this.imageUrl,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categories(
              catId:title,
              ),
              ),
              );
      },
      child: Container(
        margin: EdgeInsets.only(right:4),
        child: Stack(
          children: <Widget>[
            ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 70,
              width: 100,
              fit: BoxFit.cover,
              )
            ),
              
            Container(
              //color: Colors.black12,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 70,width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),      
      ],
      ),
        
      ),
    );
  }
}*/

