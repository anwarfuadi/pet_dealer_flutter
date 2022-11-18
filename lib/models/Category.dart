class Category{
  int id;
  String name;
  String image_path;

  Category(this.id, this.name, this.image_path);

  Map<String, dynamic> toJson() => {
    'name': name,
    'image_path': image_path
  };

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      json["id"],
      json['name'].toString(),
      json['image_path'].toString()
    );  
  }
}