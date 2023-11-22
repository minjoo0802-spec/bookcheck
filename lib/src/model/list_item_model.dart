class ListItem {
  final String img;
  final String title;
  final String userName;
  final int like;
  final int reple;

  ListItem(
      {required this.img,
      required this.title,
      required this.userName,
      required this.like,
      required this.reple});
}

final List<ListItem> bookList = [
    ListItem(img: 'https://image.aladin.co.kr/product/32896/32/cover500/k402936527_1.jpg', title: '비가 오면 열리는 상점', userName: '책벌레', like: 4, reple: 1),
    ListItem(img: '', title: '책 제목 0', userName: '작가 0', like: 6, reple: 2),
    ListItem(img: '', title: '책 제목 0', userName: '작가 0', like: 4, reple: 7),
    ListItem(img: '', title: '책 제목 0', userName: '작가 0', like: 4, reple: 1),
    ListItem(img: '', title: '책 제목 0', userName: '작가 0', like: 4, reple: 1),
  ];
