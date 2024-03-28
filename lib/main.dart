import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Curtain Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ColorChangeScreen(),
    );
  }
}

class ColorChangeScreen extends StatefulWidget {
  const ColorChangeScreen({super.key});

  @override
  State<ColorChangeScreen> createState() => _ColorChangeScreenState();
}

class _ColorChangeScreenState extends State<ColorChangeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controllerLeftToRight;
  late AnimationController _controllerRightToLeft;
  late Animation<Offset> _animationLeftToRight;
  late Animation<Offset> _animationRightToLeft;
  bool _isColorChanged = false;

  final List<String> _trendingCategories = [
    'All',
    'Technology',
    'Science',
    'Sports',
    'Health',
    'Business',
    'Entertainment',
    'Politics',
  ];

  @override
  void initState() {
    super.initState();
    _controllerLeftToRight = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controllerRightToLeft = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationLeftToRight = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(_controllerLeftToRight);
    _animationRightToLeft = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(_controllerRightToLeft);
  }

  @override
  void dispose() {
    _controllerLeftToRight.dispose();
    _controllerRightToLeft.dispose();
    super.dispose();
  }

  void _changeColor() {
    if (_isColorChanged) {
      _controllerRightToLeft.reset();
      _controllerRightToLeft.forward();
    } else {
      _controllerLeftToRight.reset();
      _controllerLeftToRight.forward();
    }
    setState(() {
      _isColorChanged = !_isColorChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SlideTransition(
            position: _animationLeftToRight,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
          ),
          SlideTransition(
            position: _animationRightToLeft,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20 * 3, left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 24,
                    color: _isColorChanged ? Colors.white : Colors.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    _isColorChanged ? Icons.wb_sunny : Icons.brightness_3,
                    color: _isColorChanged ? Colors.white : Colors.black,
                  ),
                  onPressed: _changeColor,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20 * 6, left: 20, right: 20),
            child: SizedBox(
              height: 55,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: _isColorChanged ? Colors.white54 : Colors.black54,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: _isColorChanged ? Colors.white54 : Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor:
                      _isColorChanged ? Colors.white30 : Colors.grey[300],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20 * 10, left: 20, right: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _trendingCategories
                    .map(
                      (category) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: _isColorChanged
                              ? Colors.white.withOpacity(0.5)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color:
                                _isColorChanged ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20 * 11.5, left: 20, right: 20),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://picsum.photos/200/300?random=$index',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
