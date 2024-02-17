class Category {
  static const String sportsId = 'You & Dr';
  static const String moviesId = 'You & Relatives';
  static const String musicId = 'Relative & Dr';
  late String id;
  late String title;
  late String image;

  Category({required this.id, required this.title, required this.image});

  Category.fromId(this.id) {
    if (id == sportsId) {
      title = 'You & Dr';
      image = 'assets/images/sports.png';
    } else if (id == moviesId) {
      title = 'You & Relatives';
      image = 'assets/images/movies.png';
    } else if (id == musicId) {
      title = 'Relative & Dr';
      image = 'assets/images/music.png';
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
