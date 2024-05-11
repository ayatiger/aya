class Category {
  static const String sportsId = 'You & Dr';
  static const String musicId = 'You & Relatives';
  static const String moviesId = 'Relative & Dr';
  late String id;
  late String title;
  late String image;

  Category({required this.id, required this.title, required this.image});

  Category.fromId(this.id) {
    if (id == sportsId) {
      title = 'You & Dr';
      image = 'assets/images/sports.png';
    } else if (id == musicId) {
      title = 'You & Relatives';
      image = 'assets/images/music.png';
    } else if (id == moviesId) {
      title = 'Relative & Dr';
      image = 'assets/images/movies.png';
    }
  }

  static List<Category> getCategory() {
    return [
      Category.fromId(sportsId),
      Category.fromId(musicId),
      Category.fromId(moviesId),
    ];
  }
}
