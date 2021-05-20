import 'dart:convert';
import '../widgets/brand.dart';
import '../data/data.dart';
import 'package:flutter/material.dart';
import '../models/wallpaper_model.dart';
import 'package:http/http.dart' as http;

class Categories extends StatefulWidget {

  final String catId;

  Categories({
    this.catId,
  });

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  
  List<WallpaperModel> wallpapers = new List();

  getSearchWallpapers(String query) async {
    var response =  await http.get("https://api.pexels.com/v1/search?query=$query&per_page=20",
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
  void initState() {
    getSearchWallpapers(widget.catId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Wallpaper World'),
        //title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
             SizedBox(
              height: 16,
              ),
            wallpapersGrid(wallpapers: wallpapers,context: context)
          ],),
        ),
      ),
    );
  }
}