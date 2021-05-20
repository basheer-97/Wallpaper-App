import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/full_image.dart';
import '../models/wallpaper_model.dart';

Widget wallpapersGrid({List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal:9),
    child:GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap:() {
              Navigator.push(context, MaterialPageRoute(
                // ignore: missing_required_param
                builder: (context) => ImageView(
                   imgUrl: wallpaper.src.portrait,
                   ),
                   ),
              );
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    wallpaper.src.portrait,
                    fit: BoxFit.cover,
                    ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ), 
  );
}   