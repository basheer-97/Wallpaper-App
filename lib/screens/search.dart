import 'dart:convert';

import 'package:flutter/material.dart';
import '../data/data.dart';
import '../models/wallpaper_model.dart';
import '../widgets/brand.dart';
import 'package:http/http.dart' as http;


class SearchBar extends StatefulWidget {

  final String searchQuery;
  SearchBar({
    this.searchQuery,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();

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
  void initState(){
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:const Text('Wallpaper World'),
        //title: brandName(),
        elevation: 0.0,
      ),
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
              child: Row(children: <Widget>[
                GestureDetector(
                  onTap: () => {},
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
                
                /* GestureDetector(
                  onTap: () {
                    getSearchWallpapers(searchController.text);
                  }
                ) */
                
              ],
              ),
            ),
             SizedBox(
              height: 16,
              ),
            wallpapersGrid(wallpapers: wallpapers,context: context),
            SizedBox(
            height: 10,
            ),
          ],),
          
        ),
      ),
    );
  }
}