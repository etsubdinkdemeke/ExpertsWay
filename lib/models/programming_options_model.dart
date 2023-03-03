class ProgrammingOptionsModel {
  final String btnName;
  bool whiteBtn;
  String iconUrl;

  ProgrammingOptionsModel({
    required this.btnName,
    required this.whiteBtn,
    this.iconUrl = 'https://cdn-icons-png.flaticon.com/512/6062/6062646.png',
  });
}

List<ProgrammingOptionsModel> ProgrammingOptionsModels = [
  ProgrammingOptionsModel(
      btnName: 'JavaScript',
      whiteBtn: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/5968/5968292.png'),
  ProgrammingOptionsModel(
      btnName: 'Python',
      whiteBtn: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/5968/5968350.png'),
  ProgrammingOptionsModel(
      btnName: 'Java',
      whiteBtn: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/5968/5968282.png'),
  ProgrammingOptionsModel(
      btnName: 'Go',
      whiteBtn: true,
      iconUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Go_Logo_Blue.svg/1200px-Go_Logo_Blue.svg.png'),
  ProgrammingOptionsModel(
      btnName: 'C++',
      whiteBtn: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/6132/6132222.png'),
  ProgrammingOptionsModel(
      btnName: 'PHP',
      whiteBtn: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/5968/5968332.png'),
  ProgrammingOptionsModel(
      btnName: 'SQL',
      whiteBtn: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/919/919836.png'),
  ProgrammingOptionsModel(
      btnName: 'Ruby',
      whiteBtn: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/919/919842.png'),
];
