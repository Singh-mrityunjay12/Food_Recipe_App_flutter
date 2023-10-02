import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_recipe/model.dart';
import 'package:food_recipe/recipeView.dart';
import 'package:food_recipe/search.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  bool isLoadging = true;
  //is list me RecipeModel me object or instance ko store karenge list type RecipeModel h
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();
  List reciptCatList = [
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
      "heading": "Salad"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1550547660-d9450f859349?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80",
      "heading": "Burger"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1593504049359-74330189a345?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1854&q=80",
      "heading": "Pizza"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1579684947550-22e945225d9a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80",
      "heading": "Pasta"
    }
  ];
  // String url =
  //     "https://api.edamam.com/search?q=chicken&app_id=530f051c&app_key=3cde7a7e8d5708bddfa3d069be8cbe1f";

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=530f051c&app_key=3cde7a7e8d5708bddfa3d069be8cbe1f";
    // var responce = await http.get(Uri.parse(url));
    Response responce = await http.get(Uri.parse(url));
    //jab tak responce variable me data n a jaye tab tak age mat badhana
    // print(responce.body);
    // print("////////////////////////////////////////////////////////////////");
    Map data = jsonDecode(responce.body);
    // print(data);
    // log(data.toString());
    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoadging = false;
      });
      log(recipeList.toString());
    });
    print(
        "Mrityunjay//////////////////////////////////////////////////////////////////////");

    recipeList.forEach((recipe) {
      print(recipe.applabel);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Mrityunjay");
    // getRecipe("Ladoo");
    print("Singh");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff213A50), Color(0xff071938)])),
        ),
        SingleChildScrollView(
            child: Column(
          children: [
            SafeArea(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      child: Icon(
                        Icons.search,
                        color: Colors.blueAccent,
                      ),
                      margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                    ),
                    onTap: () {
                      if ((searchController.text).replaceAll(" ", "") == "") {
                        print("Blank search");
                      } else {
                        var foodrecipe = searchController.text.trim();
                        // getRecipe(foodrecipe);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(foodrecipe)));
                      }
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Let's Cook Something!"),
                    ),
                  )
                ],
              ),
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WHAT DO YOU WANT TO COOK TODAY?",
                    style: TextStyle(fontSize: 33, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Let's Cook Something New!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              child: isLoadging
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeView(recipeList[index].appUrl)));
                          },
                          child: Card(
                              elevation: 0.0,
                              margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        recipeList[index].appimgUrl),
                                  ),
                                  Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: Container(
                                        // margin: EdgeInsets.only(bottom: 40),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.black38),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Text(
                                          recipeList[index].applabel,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )),
                                  // Positioned(
                                  //     left: 0,
                                  //     bottom: 0,
                                  //     child: Container(
                                  //       width: MediaQuery.of(context).size.width,
                                  //       decoration:
                                  //           BoxDecoration(color: Colors.black38),
                                  //       padding: EdgeInsets.symmetric(
                                  //           vertical: 5, horizontal: 10),
                                  //       child: Text(
                                  //         recipeList[index].appUrl,
                                  //         style: TextStyle(
                                  //             color: Colors.white, fontSize: 20),
                                  //       ),
                                  //     )),
                                  Positioned(
                                      right: 0,
                                      height: 30,
                                      width: 80,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: Center(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                Icon(Icons
                                                    .local_fire_department),
                                                Text(recipeList[index]
                                                    .appcalories
                                                    .toString()
                                                    .substring(0, 6))
                                              ])))),
                                ],
                              )),
                        );
                      }),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                  itemCount: reciptCatList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Search(reciptCatList[index]["heading"])));
                      },
                      child: Card(
                          margin: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 0.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(18.0),
                                  child: Image.network(
                                    reciptCatList[index]["imgUrl"],
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 250,
                                  )),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top: 0,
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration:
                                          BoxDecoration(color: Colors.black26),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            reciptCatList[index]["heading"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 28),
                                          ),
                                        ],
                                      ))),
                            ],
                          )),
                    ));
                  }),
            )
          ],
        )),
      ]),
    );
  }
}

//apana khud ka bhi widget bana skate h
Widget MrityunjayText() {
  return InkWell(
    onTap: () {},
    child: Card(
        child: Stack(
      children: [
        ClipRRect(
          child: Image.network(""),
        )
      ],
    )),
  );
}
