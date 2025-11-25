import 'package:flutter/material.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({super.key});

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  /// Master list of settings + their values
  final List<SettingItem> settings = [
    SettingItem("Light Theme", "Dark"),
    SettingItem("Vehicle Icon Size", "Small"),
    SettingItem("Time Format", "12 Hours"),
    SettingItem("Speedo Meter", "Analogy"),
    SettingItem("Default Page", "Live Page"),
    SettingItem("Map Type", "Normal"),
    SettingItem("Fuel Unit", "Liter"),
    SettingItem("Language", "English"),
    SettingItem("Speed", "Kmh"),
    SettingItem("Distance", "km"),
    SettingItem("Voice Command", "OFF"),
    SettingItem("Currency", "INR"),
    SettingItem("Live Page Trail", "OFF"),
    SettingItem("Show History on Live", "OFF"),
    SettingItem("Notification", "Small"),
    SettingItem("Fuel Reading", "Sensor"),
    SettingItem("History Route Color", "Default Color"),
    SettingItem("App Color", "Custom Color"),
    SettingItem("Relay Password", "Set Password"),
    SettingItem("Zoom Level", "17"),
  ];

  /// Dropdown options per setting name
  final Map<String, List<String>> optionsMap = {
    "Light Theme": ["Light", "Dark", "System"],
    "Vehicle Icon Size": ["Small", "Medium", "Large"],
    "Time Format": ["12 Hours", "24 Hours"],
    "Speedo Meter": ["Digital", "Analogy"],
    "Default Page": ["Live Page", "Dashboard", "History"],
    "Map Type": ["Normal", "Satellite", "Terrain", "Hybrid"],
    "Fuel Unit": ["Liter", "Gallon"],
    "Language": ["English", "Hindi", "Gujarati", "Spanish"],
    "Speed": ["Kmh", "Mph"],
    "Distance": ["km", "Miles"],
    "Voice Command": ["ON", "OFF"],
    "Currency": ["INR", "USD", "EUR", "AED"],
    "Live Page Trail": ["ON", "OFF"],
    "Show History on Live": ["ON", "OFF"],
    "Notification": ["Small", "Medium", "Large"],
    "Fuel Reading": ["Sensor", "OBD"],
    "History Route Color": ["Default Color", "Red", "Blue", "Green"],
    "App Color": ["Default Color", "Custom Color", "Dark Blue", "Ocean"],
    "Relay Password": ["Set Password", "Change Password"],
    "Zoom Level": ["10", "12", "15", "17", "20"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffE3F4FF),
              Color(0xffE8F8FF),
              Color(0xffF8FCFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Setting",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: settings.length,
                  itemBuilder: (_, index) {
                    return SettingsTile(
                      item: settings[index],
                      options: optionsMap[settings[index].title] ?? [],
                      onSelect: (selected) {
                        setState(() {
                          settings[index].value = selected;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingItem {
  final String title;
  String value;

  SettingItem(this.title, this.value);
}

class SettingsTile extends StatelessWidget {
  final SettingItem item;
  final List<String> options;
  final Function(String) onSelect;

  const SettingsTile({
    super.key,
    required this.item,
    required this.options,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _showOptionsSheet(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(
              children: [
                /// icon placeholder
                Icon(Icons.circle, color: Colors.blue.shade700, size: 26),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Text(
                  item.value,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(width: 6),

                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        Divider(height: 1, thickness: 0.2),
      ],
    );
  }

  void _showOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 18),

            Text(
              item.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ...options.map(
                  (option) => ListTile(
                title: Text(option),
                trailing: option == item.value
                    ? Icon(Icons.check, color: Colors.blue.shade700)
                    : null,
                onTap: () {
                  onSelect(option);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}
