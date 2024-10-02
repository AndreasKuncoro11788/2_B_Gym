class Person{
  final String name ;
  final String phone ;
  final String picture;
  const Person(this.name, this.phone, this.picture);
}

final List<Person> people = _people.map((e) => Person(e['name'] as String,e['phone'] as String, e['picture'] as String)).toList(growable: false);

final List<Map<String, Object>> _people =
[
  {
    "_id": "66fa38d573be78eef0e03d70",
    "index": 0,
    "guid": "72fce02f-5c11-40c7-a356-4db84198283f",
    "isActive": true,
    "balance": "\$3,303.00",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "green",
    "name": "Mavis Murray",
    "gender": "female",
    "company": "QUILTIGEN",
    "email": "mavismurray@quiltigen.com",
    "phone": "+1 (895) 445-3248",
    "address": "646 Tompkins Avenue, Bethany, Iowa, 3386",
    "about": "Proident consequat laboris adipisicing laboris pariatur fugiat reprehenderit magna sit ea laboris ea quis. Reprehenderit proident nisi proident adipisicing excepteur. Nulla aliqua officia commodo aliquip sit velit aliquip aute sint ullamco. Sint nisi tempor duis laboris consectetur sunt aliquip ea consequat quis et id laborum. Aliquip irure laboris excepteur deserunt quis.\r\n",
    "registered": "2023-06-06T09:56:04 -07:00",
    "latitude": 53.166682,
    "longitude": -49.156804,
    "tags": [
      "aliqua",
      "exercitation",
      "fugiat",
      "veniam",
      "tempor",
      "ullamco",
      "nisi"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Loraine Mcmahon"
      },
      {
        "id": 1,
        "name": "Charlene Lopez"
      },
      {
        "id": 2,
        "name": "Kerr Melendez"
      }
    ],
    "greeting": "Hello, Mavis Murray! You have 9 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fa38d5443e0514dc0d297f",
    "index": 1,
    "guid": "76fa1956-0cd2-4364-8d90-6eb776b6e04c",
    "isActive": false,
    "balance": "\$2,262.21",
    "picture": "http://placehold.it/32x32",
    "age": 28,
    "eyeColor": "brown",
    "name": "Blackburn Huff",
    "gender": "male",
    "company": "ETERNIS",
    "email": "blackburnhuff@eternis.com",
    "phone": "+1 (957) 509-2980",
    "address": "512 Etna Street, Ventress, North Carolina, 9330",
    "about": "Fugiat cupidatat elit sint duis cillum eiusmod. Dolor voluptate cupidatat dolor cupidatat laborum sint velit irure excepteur elit. Amet labore dolore irure exercitation. Laborum ullamco exercitation nostrud non cupidatat reprehenderit elit in eu deserunt sint anim laboris. Amet adipisicing est duis voluptate nisi.\r\n",
    "registered": "2020-01-26T09:04:30 -07:00",
    "latitude": 88.595507,
    "longitude": -157.019843,
    "tags": [
      "dolor",
      "excepteur",
      "laboris",
      "velit",
      "minim",
      "ipsum",
      "dolor"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Dorothy Mullins"
      },
      {
        "id": 1,
        "name": "Ortega Dunn"
      },
      {
        "id": 2,
        "name": "Talley Ellis"
      }
    ],
    "greeting": "Hello, Blackburn Huff! You have 4 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fa38d564aacfca67297c53",
    "index": 2,
    "guid": "b24edde8-d4ef-46a8-a340-f5e349b3de9f",
    "isActive": false,
    "balance": "\$1,622.32",
    "picture": "http://placehold.it/32x32",
    "age": 20,
    "eyeColor": "brown",
    "name": "Burks Joyce",
    "gender": "male",
    "company": "PLEXIA",
    "email": "burksjoyce@plexia.com",
    "phone": "+1 (835) 536-2105",
    "address": "492 Montauk Avenue, Efland, Oklahoma, 6672",
    "about": "Lorem in sit Lorem consequat veniam sint. Aliquip sint irure mollit tempor velit. Laborum reprehenderit ipsum sit fugiat irure Lorem officia amet mollit eu. Ea ipsum labore exercitation voluptate consectetur do laboris do enim ipsum cillum aliquip et. Ut veniam qui quis ad tempor adipisicing voluptate reprehenderit irure reprehenderit laborum. Enim ut elit nulla veniam culpa.\r\n",
    "registered": "2018-01-23T05:52:30 -07:00",
    "latitude": -4.023804,
    "longitude": -148.912253,
    "tags": [
      "voluptate",
      "id",
      "id",
      "consectetur",
      "magna",
      "eu",
      "ad"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Moody Clark"
      },
      {
        "id": 1,
        "name": "Amparo Fletcher"
      },
      {
        "id": 2,
        "name": "Kristy Sullivan"
      }
    ],
    "greeting": "Hello, Burks Joyce! You have 4 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fa38d591a8109d55759579",
    "index": 3,
    "guid": "41af86dc-bb56-44f6-a426-df8509bf06f6",
    "isActive": false,
    "balance": "\$1,068.90",
    "picture": "http://placehold.it/32x32",
    "age": 27,
    "eyeColor": "brown",
    "name": "Boyd Marks",
    "gender": "male",
    "company": "FLEXIGEN",
    "email": "boydmarks@flexigen.com",
    "phone": "+1 (807) 583-2463",
    "address": "319 Navy Walk, Moquino, Guam, 321",
    "about": "Incididunt exercitation est ea occaecat do labore id adipisicing ea velit non minim occaecat duis. Consequat adipisicing Lorem ipsum tempor dolore labore Lorem labore nulla ea. Enim dolore sunt enim in. Proident magna exercitation qui magna in deserunt. Sit dolore laboris commodo incididunt ipsum laborum quis nulla Lorem exercitation. Velit ipsum do in elit aliquip aute in.\r\n",
    "registered": "2017-02-15T10:32:43 -07:00",
    "latitude": -71.476541,
    "longitude": 161.019429,
    "tags": [
      "non",
      "ex",
      "proident",
      "fugiat",
      "ex",
      "duis",
      "cillum"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Le Reynolds"
      },
      {
        "id": 1,
        "name": "Perry Waller"
      },
      {
        "id": 2,
        "name": "Tyson Jacobson"
      }
    ],
    "greeting": "Hello, Boyd Marks! You have 4 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66fa38d5bd64ddcc8f82671d",
    "index": 4,
    "guid": "c3afa732-5104-4bf6-9680-97b0ab86477d",
    "isActive": false,
    "balance": "\$3,519.47",
    "picture": "http://placehold.it/32x32",
    "age": 23,
    "eyeColor": "blue",
    "name": "Coleman Richards",
    "gender": "male",
    "company": "MARTGO",
    "email": "colemanrichards@martgo.com",
    "phone": "+1 (997) 537-2243",
    "address": "154 Barwell Terrace, Catherine, New York, 7035",
    "about": "Qui id aliqua deserunt occaecat consectetur mollit tempor do voluptate pariatur cupidatat aliquip duis. Do nostrud laborum esse magna veniam in. Commodo incididunt ut laborum in ad. Elit voluptate mollit culpa et magna adipisicing veniam ipsum tempor enim est.\r\n",
    "registered": "2021-11-13T04:24:28 -07:00",
    "latitude": -38.775266,
    "longitude": -76.034029,
    "tags": [
      "in",
      "velit",
      "elit",
      "aute",
      "eiusmod",
      "magna",
      "nostrud"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Mckee Mcintyre"
      },
      {
        "id": 1,
        "name": "Fernandez Hurst"
      },
      {
        "id": 2,
        "name": "Peggy Salazar"
      }
    ],
    "greeting": "Hello, Coleman Richards! You have 5 unread messages.",
    "favoriteFruit": "strawberry"
  }
];