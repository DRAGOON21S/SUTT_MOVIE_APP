class StringConverter {
  double Str_double(String str) {
  double? d = double.tryParse(str);
  if(d != null) {
    return d;
  } else {
    return 0.0;
}}}