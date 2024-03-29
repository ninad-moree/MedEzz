// Converts int to duration, returns duration left in MM:SS format
String intToTimeLeft(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  // ignore: unused_local_variable
  String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();

  String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

  String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

  String result = "$minuteLeft:$secondsLeft";

  return result;
}
