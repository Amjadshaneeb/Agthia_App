import 'package:neumorphic_ui/neumorphic_ui.dart';

class NuemTextfield extends StatelessWidget {
  const NuemTextfield(
      {super.key,
      required this.hinttext,
      required this.depth,
      required this.color, required this.icon});

  final String hinttext;
  final double depth;
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.all(15),
      style: NeumorphicStyle(
        depth: depth,
        lightSource: LightSource.topLeft,
        intensity: 20,
        surfaceIntensity: 1,
        color: color,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(25),
        ),
      ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon:icon,
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        ),
      ),
    );
  }
}
