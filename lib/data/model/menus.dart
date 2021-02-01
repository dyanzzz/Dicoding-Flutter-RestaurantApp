class Menus {
  List<Menu> foods;
  List<Menu> drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json != null
            ? List<Menu>.from(json["foods"].map((x) => Menu.fromMap(x)))
            : [],
        drinks: json != null
            ? List<Menu>.from(json["drinks"].map((x) => Menu.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toMap())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toMap())),
      };

  @override
  List<Object> get props => [foods, drinks];
}

class Menu {
  String name;

  Menu({
    this.name,
  });

  factory Menu.fromMap(Map<String, dynamic> json) => Menu(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };

  @override
  List<Object> get props => [name];
}
