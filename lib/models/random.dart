import 'dart:math';

class Avatar {
  static Random random = Random();
  static final List<String> _frogs = [
  'https://ie.wampi.ru/2022/01/30/frog-4.png',
  'https://ie.wampi.ru/2022/02/01/frog-5.png',
  'https://ie.wampi.ru/2022/01/30/frog-6.png',
  'https://ie.wampi.ru/2022/01/30/frog-7.png',
  'https://ie.wampi.ru/2022/01/30/frog-9.png',
  'https://ie.wampi.ru/2022/01/30/frog-10.png',
  'https://ie.wampi.ru/2022/01/30/frog-11.png',
  'https://ie.wampi.ru/2022/01/30/frog-14.png',
  'https://ie.wampi.ru/2022/01/30/frog-15.png',
  'https://ie.wampi.ru/2022/01/30/frog-16.png',
  'https://ie.wampi.ru/2022/01/30/frog-17.png',
  'https://ie.wampi.ru/2022/01/30/frog-19.png',
  'https://ie.wampi.ru/2022/01/30/frog-prince-1.png',
  'https://ie.wampi.ru/2022/01/30/frog-prince-2.png',
  'https://ie.wampi.ru/2022/01/30/frog-prince-12.png'
  ];

  static String getRandomAvatar() {
    return _frogs[random.nextInt(_frogs.length)];
  }

  static String getAvatar(int index) {
    return _frogs[index];
  }

  static List<String> getPhotos() {
    return _frogs;
  }
}
