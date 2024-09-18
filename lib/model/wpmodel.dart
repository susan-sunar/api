class Wpmodel{
  String imgurl;
  String name;
  String avg_color;
  String describtion;

  Wpmodel({
    required this.imgurl,
    required this.name,
    required this.avg_color,
    required this.describtion,
});
  factory Wpmodel.fromMap(Map<String,dynamic>map){
    return Wpmodel(
        imgurl: map["src"]["portrait"],
        name:map["photographer"],
        avg_color: map["avg_color"],
        describtion: map["alt"],
    );

  }
}