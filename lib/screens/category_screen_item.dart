import 'package:flutter/material.dart';
import '../data/data.dart';
import '../models/categories_item.dart';
import 'categories.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  List<CategoriesItem> categories = new List();

  @override
  void initState(){
    categories = getCategories();
    super.initState();
  }
  Widget build(BuildContext context) {
    return ListView.builder(
      //padding: const EdgeInsets.all(3.0),
      padding: EdgeInsets.symmetric(vertical: 4),
      itemBuilder: (context,index){
      return DisplayCategories(
        title: categories[index].categoryName,
        imageUrl: categories[index].imageUrl,
      );
    }, 
    itemCount: categories.length,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    );
  }
}

class DisplayCategories extends StatelessWidget {

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
        margin: EdgeInsets.all(4),
        child: Stack(
          children: <Widget>[
            ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              )
            ),
              
            Container(
              //color: Colors.black12,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 200,width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),      
      ],
      ),
        
      ),
    );
  }
}