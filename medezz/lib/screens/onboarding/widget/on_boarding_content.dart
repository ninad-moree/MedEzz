class OnbordingContent {
  String image;
  String title;
  String description;

  OnbordingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnbordingContent> contents = [
  OnbordingContent(
    title: 'Never forget your medicine again!',
    image: 'assets/icons/1.gif',
    description:
        "Remember what to take, when to take, when to refill. Never miss a dose again.",
  ),
  OnbordingContent(
    title: 'Multiple users & multiple devices at the same time!',
    image: 'assets/icons/2.gif',
    description:
        "No matter where you are, you can always access your medicine schedule. Sync your medication shedule across all your devices.",
  ),
  OnbordingContent(
    title: 'Find the best and nearest services!',
    image: 'assets/icons/3.gif',
    description:
        "Find the nearest helpline with ease. Find the nearest hospital and pharmacy. All on your fingertips",
  ),
  OnbordingContent(
    title: 'Track your progress!',
    image: 'assets/icons/4.gif',
    description:
        "Take control of your medication. Never miss a dose again. Stay organized. Stay healthy!",
  ),
];
