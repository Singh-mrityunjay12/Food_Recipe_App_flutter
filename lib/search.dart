import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_recipe/model.dart';
import 'package:food_recipe/recipeView.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Search extends StatefulWidget {
  //hame search karana h aur kya karana h usake liye hame ak query banana padega aur jab koi hamara widget call karega to use query dena padega
  String query;
  //constructor
  Search(this.query);
  // const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoadging = true;
  //is list me RecipeModel me object or instance ko store karenge list type RecipeModel h
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

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
    getRecipe(widget.query);
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

                        Navigator.pushReplacement(
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
