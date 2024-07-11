class Item {
  /// Title to show to the user
  final String? title;

  /// Title for the wikipedia article
  final String wikipediaTitle;

  /// URL pointing an image
  final Uri? imageUrl;

  const Item({required this.wikipediaTitle, this.title, this.imageUrl});
}

final testItems = [
  Item(
    wikipediaTitle: "Dart",
    imageUrl: Uri.parse(
      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Dart_programming_language_logo.svg/1024px-Dart_programming_language_logo.svg.png",
    ),
  ),
  Item(
    wikipediaTitle: "C++",
    imageUrl: Uri.parse(
      "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/ISO_C%2B%2B_Logo.svg/683px-ISO_C%2B%2B_Logo.svg.png",
    ),
  ),
  const Item(
    wikipediaTitle: "C (lenguaje de programación)",
    title: "C",
  ),
  const Item(
    wikipediaTitle: "Rust (lenguaje de programación)",
    title: "Rust",
  ),
  const Item(wikipediaTitle: "JavaScript"),
  const Item(
    wikipediaTitle: "Java (lenguaje de programación)",
    title: "Java",
  ),
  const Item(wikipediaTitle: "Lua"),
  const Item(wikipediaTitle: "Perl"),
  const Item(wikipediaTitle: "Haskell"),
  const Item(wikipediaTitle: "Lisp"),
  const Item(wikipediaTitle: "Brainfuck"),
  Item(
    wikipediaTitle: "Piet (lenguaje de programación)",
    title: "Piet",
    imageUrl: Uri.parse(
        "https://upload.wikimedia.org/wikipedia/commons/d/d0/Piet_Program.gif"),
  ),
  const Item(wikipediaTitle: "COBOL"),
  const Item(wikipediaTitle: "VBScript"),
  const Item(wikipediaTitle: "Basic"),
  const Item(wikipediaTitle: "Lenguaje ensamblador"),
  const Item(wikipediaTitle: "C Sharp", title: "C#"),
  const Item(wikipediaTitle: "Python"),
  const Item(
      wikipediaTitle: "Swift (lenguaje de programación)", title: "Swift"),
  const Item(wikipediaTitle: "Pascal (lenguaje de programación)", title: "Pascal")
];
