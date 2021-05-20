//import 'dart:io';
//import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaperplugin/wallpaperplugin.dart';
import '../models/wallpaper_model.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class ImageView extends StatefulWidget {

  final String imgUrl;
  final SrcModel abcd;

  ImageView({
    @required this.imgUrl,
    @required this.abcd,
  });
   
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  //var filepath;
  bool permission = false;
  bool downloadImage = false;
  String downPer = "0%";
  final String nAvail = "Not Available";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Hero(
          tag: widget.imgUrl,
            child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.imgUrl, fit: BoxFit.cover,
          ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
            GestureDetector(
              onTap: () {
                //_save();
                if (permission == false) {
                          print("Requesting Permission");
                          _permissionRequest();
                        } else {
                          print("Permission Granted.");
                          setWallpaper();
                        }
              },
              child: Stack(
                children:<Widget>[
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff1C1B1B).withOpacity(0.7),
                    ),
                    width: MediaQuery.of(context).size.width/2,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.symmetric(horizontal:8, vertical:10),
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.white60,width:1),
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                      colors: [
                          Color(0x36FFFFFF),
                          Color(0x0FFFFFFF),   
                        ]
                      ),
                    ),
                child: Text(
                  "Apply Wallpaper",style:TextStyle(fontSize:18,color:Colors.white70),textAlign: TextAlign.center,
                  ),
                  ),
                ]
              ),
            ),
                SizedBox(height:26,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back", style: TextStyle(fontSize:18 ,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  ),
                SizedBox(height:50,)
          ],)
        ),
      ],
      ),
    );
  }

   /* _save() async {
     if(Platform.isAndroid){
       await _askPermission();
       }
    var response = await Dio().get(widget.imgUrl,
        ;options: Options(responseType: ResponseType.bytes))
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */await PermissionHandler()
              .requestPermissions([PermissionGroup.photos]);
    } else {
     /* PermissionStatus permission = */await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }  */

  _permissionRequest() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Wallpaper World',
    );
    var result = await permissionValidator.storage();
    if (result) {
      setState(() {
        permission = true;
        setWallpaper();
      });
    }
  }

  void setWallpaper() async {
    final dir = await getExternalStorageDirectory();
    print(dir);
    Dio dio = new Dio();
    dio.download(
      widget.imgUrl,
      "${dir.path}/wallpaper_app.jpg",
      onReceiveProgress: (received, total) {
        if (total != -1) {
          String downloadingPer =
              ((received / total * 100).toStringAsFixed(0) + "%");
          setState(() {
            downPer = downloadingPer;
          });
        }
        setState(() {
          downloadImage = true;
        });
      },
    ).whenComplete(() {
      setState(() {
        downloadImage = false;
      });
      initPlatformState("${dir.path}/wallpaper_app.jpg");
      Navigator.pop(context);
    });
  }

  Future<void> initPlatformState(String path) async {
    // ignore: unused_local_variable
    String wallpaperStatus = "Unexpected Result";
    String _localFile = path;
    try {
      Wallpaperplugin.setWallpaperWithCrop(localFile: _localFile);
      wallpaperStatus = "Wallpaper set";
    } on PlatformException {
      print("Platform exception");
      wallpaperStatus = "Platform Error Occured";
    }
    if (!mounted) return;
  }

}

  


