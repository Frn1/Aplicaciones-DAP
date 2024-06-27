class Item {
  /// Title to show to the user
  final String? title;

  /// Title for the wikipedia article
  final String wikipediaTitle;

  /// URL pointing an image
  final Uri? imageUrl;

  const Item({required this.wikipediaTitle, this.title, this.imageUrl});
}

const testItems = [
  Item(wikipediaTitle: "Dart"),
  Item(wikipediaTitle: "C++"),
  Item(
    wikipediaTitle: "C (lenguaje de programación)",
    title: "C",
  ),
  Item(
    wikipediaTitle: "Rust (lenguaje de programación)",
    title: "Rust",
  ),
  Item(wikipediaTitle: "JavaScript"),
  Item(
    wikipediaTitle: "Java (lenguaje de programación)",
    title: "Java",
  ),
  Item(wikipediaTitle: "Lua"),
  Item(wikipediaTitle: "Perl"),
  Item(wikipediaTitle: "Haskell"),
  Item(wikipediaTitle: "Lisp"),
  Item(wikipediaTitle: "Brainfuck"),
  Item(
    wikipediaTitle: "Piet (lenguaje de programación)",
    title: "Piet",
  ),
  Item(wikipediaTitle: "COBOL"),
  Item(wikipediaTitle: "VBScript"),
  Item(wikipediaTitle: "Basic"),
  Item(wikipediaTitle: "Lenguaje ensamblador"),
  Item(wikipediaTitle: "C Sharp", title: "C#"),
  Item(wikipediaTitle: "Python"),
  Item(wikipediaTitle: "Swift (lenguaje de programación)", title: "Swift"),
  Item(wikipediaTitle: "Pascal")
];
