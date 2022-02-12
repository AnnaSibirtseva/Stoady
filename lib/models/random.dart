import 'dart:math';

class RandomFrog {
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
  'https://ie.wampi.ru/2022/01/30/frog-prince-12.png',
  'https://ie.wampi.ru/2022/01/30/frog-10e5b7f1a59a43dce3.png',
  'https://ie.wampi.ru/2022/01/30/frog-118e7a46bbc13e8359.png',
  'https://ie.wampi.ru/2022/01/30/frog-14edd3b9ed195dfb6b.png',
  'https://ie.wampi.ru/2022/01/30/frog-1563d4f806813e3458.png',
  'https://ie.wampi.ru/2022/01/30/frog-16d0e8a5a19f3f3f14.png',
  'https://ie.wampi.ru/2022/01/30/frog-17240c7083019c989b.png',
  'https://ie.wampi.ru/2022/01/30/frog-1997b486ebcd713aa3.png',
  'https://ie.wampi.ru/2022/01/30/frog-prince-12a5301a222a2c905.png',
  'https://ie.wampi.ru/2022/01/30/frog-prince-2b7f6e94c85818108.png',
  'https://ie.wampi.ru/2022/01/30/frog-prince-12fe8fd73038da8a60.png',
  'https://ie.wampi.ru/2022/01/30/frog-4310ed9b635eae120.png',
  'https://ie.wampi.ru/2022/01/30/frog-5d7f770ba6ac47193.png',
  'https://ie.wampi.ru/2022/01/30/frog-64d4a033118613540.png',
  'https://ie.wampi.ru/2022/01/30/frog-7d31248d76760b819.png',
  'https://ie.wampi.ru/2022/01/30/frog-99cd88a045997cfbe.png',
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
