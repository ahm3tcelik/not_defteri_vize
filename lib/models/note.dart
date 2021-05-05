class Note {
  int? id;
  late String title;
  late String content;
  late String createdAt;
  late String color;
  String? icon;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.color,
    this.icon,
  });

  Note.fromMap(Map map) {
    id = map['id'];
    title = map['title'];
    content = map['content'];
    createdAt = map['createdAt'];
    color = map['color'];
    icon = map['icon'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'color': color,
      'icon': icon,
    };
  }
}

var colors = <String> [
  '#99b3ff',
  '#6b7db3',
  '#bb99ff',
  '#00e5e6',
  '#6bb3b3',
];

var icons = <String>[
  'shopping_cart',
  'star',
  'heart',
  'bell',
  'exclamationmark_triangle',
  'clock'
];
/*
var fakeNoteList = <Note> [
  Note(id: 0, title: 'Sevgili Günlük', createdAt: '17 Nisan', icon: 'shopping_cart', color: '#99b3ff',  content: 'as sadasfdsafss sa sadasf '),
  Note(id: 1, title: 'Sevgili Günlük', createdAt: '17 Nisan', icon: 'star', color: '#6b7db3', content: '''Nulla auctor justo nec felis venenatis, non ultricies lacus fringilla. Morbi justo tellus, egestas quis ex quis, tincidunt facilisis risus. Proin in porta libero, vitae ornare augue. Etiam eu venenatis dolor, in dapibus odio. Maecenas rhoncus erat vel justo porttitor semper. Integer imperdiet urna vel purus congue, vitae efficitur nulla porta. Phasellus vestibulum, leo ut fringilla semper, risus velit elementum ipsum, a aliquet dui leo sed urna. Sed iaculis sit amet risus sit amet laoreet. '''),
  Note(id: 2, title: 'Sevgili GünlükScbc', createdAt: '21 Nisan', icon: 'heart', color: '#bb99ff', content: '''Pellentesque venenatis porta urna at efficitur. Aliquam a lorem sed massa semper facilisis vel quis lorem. Aliquam justo ligula, posuere a mauris ac, convallis tincidunt tellus. Curabitur mollis ex quis erat sollicitudin, ut vulputate diam consequat. Fusce sed vehicula ligula, sit amet sollicitudin leo. Quisque urna nulla, aliquet et efficitur ut, pretium vitae est. Aliquam at lacus at magna dictum suscipit eu a turpis. Aenean viverra erat nec orci porta, in ultricies turpis faucibus. Sed eu nibh quam. Interdum et malesuada fames ac ante ipsum primis in faucibus. '''),
  Note(id: 3, title: 'SevgiliSf Günlaük', createdAt: '23 Nisan', icon: 'bell', color: '#99b3ff', content: '''Nulla non metus erat. Integer in velit tempor, porttitor risus id, elementum ipsum. Duis non massa id purus semper volutpat. Vivamus gravida egestas odio sed porta. Suspendisse ante augue, fringilla ut porta at, tempus quis urna. Suspendisse id tellus dolor. Nunc vitae sem fermentum, laoreet massa quis, tempus risus. Nulla suscipit vel leo facilisis pulvinar. Sed varius nisi non auctor consequat. '''),
  Note(id: 1, title: 'Sevgili Günlük', createdAt: '17 Nisan', icon: 'exclamationmark_triangle', color: '#99b3ff', content: '''Nulla auctor justo nec felis venenatis, non ultricies lacus fringilla. Morbi justo tellus, egestas quis ex quis, tincidunt facilisis risus. Proin in porta libero, vitae ornare augue. Etiam eu venenatis dolor, in dapibus odio. Maecenas rhoncus erat vel justo porttitor semper. Integer imperdiet urna vel purus congue, vitae efficitur nulla porta. Phasellus vestibulum, leo ut fringilla semper, risus velit elementum ipsum, a aliquet dui leo sed urna. Sed iaculis sit amet risus sit amet laoreet. '''),
  Note(id: 2, title: 'Sevgili GünlükScbc', createdAt: '21 Nisan', color: '#6bb3b3', content: '''Pellentesque venenatis porta urna at efficitur. Aliquam a lorem sed massa semper facilisis vel quis lorem. Aliquam justo ligula, posuere a mauris ac, convallis tincidunt tellus. Curabitur mollis ex quis erat sollicitudin, ut vulputate diam consequat. Fusce sed vehicula ligula, sit amet sollicitudin leo. Quisque urna nulla, aliquet et efficitur ut, pretium vitae est. Aliquam at lacus at magna dictum suscipit eu a turpis. Aenean viverra erat nec orci porta, in ultricies turpis faucibus. Sed eu nibh quam. Interdum et malesuada fames ac ante ipsum primis in faucibus. '''),
  Note(id: 3, title: 'SevgiliSf Günlaük', createdAt: '23 Nisan', color: '#99b3ff', content: '''Nulla non metus erat. Integer in velit tempor, porttitor risus id, elementum ipsum. Duis non massa id purus semper volutpat. Vivamus gravida egestas odio sed porta. Suspendisse ante augue, fringilla ut porta at, tempus quis urna. Suspendisse id tellus dolor. Nunc vitae sem fermentum, laoreet massa quis, tempus risus. Nulla suscipit vel leo facilisis pulvinar. Sed varius nisi non auctor consequat. '''),
  Note(id: 1, title: 'Sevgili Günlük', createdAt: '17 Nisan', color: '#99b3ff', content: '''Nulla auctor justo nec felis venenatis, non ultricies lacus fringilla. Morbi justo tellus, egestas quis ex quis, tincidunt facilisis risus. Proin in porta libero, vitae ornare augue. Etiam eu venenatis dolor, in dapibus odio. Maecenas rhoncus erat vel justo porttitor semper. Integer imperdiet urna vel purus congue, vitae efficitur nulla porta. Phasellus vestibulum, leo ut fringilla semper, risus velit elementum ipsum, a aliquet dui leo sed urna. Sed iaculis sit amet risus sit amet laoreet. '''),
  Note(id: 2, title: 'Sevgili GünlükScbc', createdAt: '21 Nisan', color: '#6bb3b3', content: '''Pellentesque venenatis porta urna at efficitur. Aliquam a lorem sed massa semper facilisis vel quis lorem. Aliquam justo ligula, posuere a mauris ac, convallis tincidunt tellus. Curabitur mollis ex quis erat sollicitudin, ut vulputate diam consequat. Fusce sed vehicula ligula, sit amet sollicitudin leo. Quisque urna nulla, aliquet et efficitur ut, pretium vitae est. Aliquam at lacus at magna dictum suscipit eu a turpis. Aenean viverra erat nec orci porta, in ultricies turpis faucibus. Sed eu nibh quam. Interdum et malesuada fames ac ante ipsum primis in faucibus. '''),
  Note(id: 3, title: 'SevgiliSf Günlaük', createdAt: '23 Nisan', color: '#99b3ff', content: '''Nulla non metus erat. Integer in velit tempor, porttitor risus id, elementum ipsum. Duis non massa id purus semper volutpat. Vivamus gravida egestas odio sed porta. Suspendisse ante augue, fringilla ut porta at, tempus quis urna. Suspendisse id tellus dolor. Nunc vitae sem fermentum, laoreet massa quis, tempus risus. Nulla suscipit vel leo facilisis pulvinar. Sed varius nisi non auctor consequat. ''')
];

 */