import 'package:flutter/material.dart';

class UserOnboardingPage extends StatefulWidget {
  const UserOnboardingPage({Key? key}) : super(key: key);

  @override
  State<UserOnboardingPage> createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 10;

  // Animation controllers
  late AnimationController _progressAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _progressAnimation;
  late Animation<Offset> _slideAnimation;

  // User data
  final Map<String, dynamic> _userData = {};

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Selection variables
  String? _selectedGender;
  String? _selectedBloodGroup;
  String? _selectedDietType;
  String? _selectedActivityLevel;
  List<String> _selectedAllergies = [];
  List<String> _selectedCuisines = [];

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressAnimationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideAnimationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressAnimationController.dispose();
    _slideAnimationController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _currentPage++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateProgress();
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateProgress();
    }
  }

  void _updateProgress() {
    _progressAnimationController.animateTo((_currentPage + 1) / _totalPages);
  }

  void _completeOnboarding() {
    // Save user data
    _userData['name'] = _nameController.text;
    _userData['age'] = _ageController.text;
    _userData['weight'] = _weightController.text;
    _userData['height'] = _heightController.text;
    _userData['location'] = _locationController.text;
    _userData['gender'] = _selectedGender;
    _userData['bloodGroup'] = _selectedBloodGroup;
    _userData['dietType'] = _selectedDietType;
    _userData['activityLevel'] = _selectedActivityLevel;
    _userData['allergies'] = _selectedAllergies;
    _userData['cuisines'] = _selectedCuisines;

    // Navigate to home
    Navigator.pushReplacementNamed(context, '/home');
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return _nameController.text.isNotEmpty;
      case 1:
        return _ageController.text.isNotEmpty;
      case 2:
        return _selectedGender != null;
      case 3:
        return _weightController.text.isNotEmpty && _heightController.text.isNotEmpty;
      case 4:
        return _selectedBloodGroup != null;
      case 5:
        return _locationController.text.isNotEmpty;
      case 6:
        return _selectedDietType != null;
      case 7:
        return _selectedActivityLevel != null;
      case 8:
        return _selectedAllergies.isNotEmpty;
      case 9:
        return _selectedCuisines.isNotEmpty;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4ECDC4),
              Color(0xFF44A08D),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with progress
              _buildHeader(),
              
              // Questions
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                    _updateProgress();
                  },
                  children: [
                    _buildNameQuestion(),
                    _buildAgeQuestion(),
                    _buildGenderQuestion(),
                    _buildPhysicalInfoQuestion(),
                    _buildBloodGroupQuestion(),
                    _buildLocationQuestion(),
                    _buildDietTypeQuestion(),
                    _buildActivityLevelQuestion(),
                    _buildAllergiesQuestion(),
                    _buildCuisinePreferencesQuestion(),
                  ],
                ),
              ),
              
              // Navigation buttons
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage > 0)
                IconButton(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                )
              else
                const SizedBox(width: 48),
              Text(
                'Profile Setup',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${_currentPage + 1}/$_totalPages',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Progress bar
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3),
            ),
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildNameQuestion() {
    return _buildQuestionCard(
      title: "What's your name?",
      subtitle: "We'd love to know what to call you!",
      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          hintText: "Enter your full name",
          prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF4ECDC4)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
        ),
        onChanged: (value) => setState(() {}),
      ),
    );
  }

  Widget _buildAgeQuestion() {
    return _buildQuestionCard(
      title: "How old are you?",
      subtitle: "This helps us personalize your nutrition needs",
      child: TextField(
        controller: _ageController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Enter your age",
          prefixIcon: const Icon(Icons.cake_outlined, color: Color(0xFF4ECDC4)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
        ),
        onChanged: (value) => setState(() {}),
      ),
    );
  }

  Widget _buildGenderQuestion() {
    return _buildQuestionCard(
      title: "What's your gender?",
      subtitle: "This helps us calculate your nutritional requirements",
      child: Column(
        children: [
          _buildOptionButton("Male", _selectedGender == "Male", () {
            setState(() => _selectedGender = "Male");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Female", _selectedGender == "Female", () {
            setState(() => _selectedGender = "Female");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Other", _selectedGender == "Other", () {
            setState(() => _selectedGender = "Other");
          }),
        ],
      ),
    );
  }

  Widget _buildPhysicalInfoQuestion() {
    return _buildQuestionCard(
      title: "Physical Information",
      subtitle: "Help us calculate your ideal nutrition plan",
      child: Column(
        children: [
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Weight (kg)",
              prefixIcon: const Icon(Icons.monitor_weight_outlined, color: Color(0xFF4ECDC4)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
            ),
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Height (cm)",
              prefixIcon: const Icon(Icons.height, color: Color(0xFF4ECDC4)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
            ),
            onChanged: (value) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodGroupQuestion() {
    return _buildQuestionCard(
      title: "What's your blood group?",
      subtitle: "Some diets are optimized based on blood type",
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
            .map((bloodGroup) => _buildChipOption(
                  bloodGroup,
                  _selectedBloodGroup == bloodGroup,
                  () => setState(() => _selectedBloodGroup = bloodGroup),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildLocationQuestion() {
    return _buildQuestionCard(
      title: "Where are you located?",
      subtitle: "We'll suggest local cuisines and restaurants",
      child: TextField(
        controller: _locationController,
        decoration: InputDecoration(
          hintText: "Enter your city/location",
          prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFF4ECDC4)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
        ),
        onChanged: (value) => setState(() {}),
      ),
    );
  }

  Widget _buildDietTypeQuestion() {
    return _buildQuestionCard(
      title: "What's your diet preference?",
      subtitle: "This helps us recommend suitable meals",
      child: Column(
        children: [
          _buildOptionButton("Vegetarian", _selectedDietType == "Vegetarian", () {
            setState(() => _selectedDietType = "Vegetarian");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Vegan", _selectedDietType == "Vegan", () {
            setState(() => _selectedDietType = "Vegan");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Non-Vegetarian", _selectedDietType == "Non-Vegetarian", () {
            setState(() => _selectedDietType = "Non-Vegetarian");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Pescatarian", _selectedDietType == "Pescatarian", () {
            setState(() => _selectedDietType = "Pescatarian");
          }),
        ],
      ),
    );
  }

  Widget _buildActivityLevelQuestion() {
    return _buildQuestionCard(
      title: "What's your activity level?",
      subtitle: "This affects your caloric needs",
      child: Column(
        children: [
          _buildOptionButton("Sedentary (Little to no exercise)", _selectedActivityLevel == "Sedentary", () {
            setState(() => _selectedActivityLevel = "Sedentary");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Lightly Active (1-3 days/week)", _selectedActivityLevel == "Lightly Active", () {
            setState(() => _selectedActivityLevel = "Lightly Active");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Moderately Active (3-5 days/week)", _selectedActivityLevel == "Moderately Active", () {
            setState(() => _selectedActivityLevel = "Moderately Active");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Very Active (6-7 days/week)", _selectedActivityLevel == "Very Active", () {
            setState(() => _selectedActivityLevel = "Very Active");
          }),
        ],
      ),
    );
  }

  Widget _buildAllergiesQuestion() {
    return _buildQuestionCard(
      title: "Any food allergies?",
      subtitle: "We'll make sure to avoid these in recommendations",
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: ['Nuts', 'Dairy', 'Gluten', 'Shellfish', 'Eggs', 'Soy', 'Fish', 'None']
            .map((allergy) => _buildChipOption(
                  allergy,
                  _selectedAllergies.contains(allergy),
                  () {
                    setState(() {
                      if (allergy == 'None') {
                        _selectedAllergies = ['None'];
                      } else {
                        _selectedAllergies.remove('None');
                        if (_selectedAllergies.contains(allergy)) {
                          _selectedAllergies.remove(allergy);
                        } else {
                          _selectedAllergies.add(allergy);
                        }
                      }
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCuisinePreferencesQuestion() {
    return _buildQuestionCard(
      title: "Favorite cuisines?",
      subtitle: "Select all that you enjoy eating",
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: ['Indian', 'Chinese', 'Italian', 'Mexican', 'Thai', 'Japanese', 'Mediterranean', 'American']
            .map((cuisine) => _buildChipOption(
                  cuisine,
                  _selectedCuisines.contains(cuisine),
                  () {
                    setState(() {
                      if (_selectedCuisines.contains(cuisine)) {
                        _selectedCuisines.remove(cuisine);
                      } else {
                        _selectedCuisines.add(cuisine);
                      }
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget _buildOptionButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildChipOption(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousPage,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Previous',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          if (_currentPage > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _canProceed() ? _nextPage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF4ECDC4),
                disabledBackgroundColor: Colors.white.withOpacity(0.5),
                elevation: 8,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _currentPage == _totalPages - 1 ? 'Complete' : 'Next',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}