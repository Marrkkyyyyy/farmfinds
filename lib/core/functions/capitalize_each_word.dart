String capitalizeEachWord(String text) {
  // Split the text into words using a regular expression pattern to handle multiple spaces
  List<String> words = text.split(RegExp(r'\s+'));

  // Capitalize each word
  List<String> capitalizedWords = words.map((word) {
    return word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
  }).toList();

  // Join the capitalized words back together
  return capitalizedWords.join(' ');
}
