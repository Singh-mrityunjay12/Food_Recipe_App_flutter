class RecipeModel {
  late String applabel;
  late String appimgUrl;
  late double appcalories;
  late String appUrl;

//Constructor
  RecipeModel(
      {this.applabel = "lable",
      this.appcalories = 0.000,
      this.appimgUrl = "fghjkl",
      this.appUrl = "vhjkl"});

  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
      applabel: recipe["label"],
      appimgUrl: recipe["image"],
      appcalories: recipe["calories"],
      appUrl: recipe['url'],
    );
  }
}
