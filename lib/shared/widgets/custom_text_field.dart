import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:al_finance/core/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (hasFocus) => setState(() => _isFocused = hasFocus),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(color: isDark ? Colors.white24 : Colors.black26),
              prefixIcon: widget.prefixIcon != null 
                ? Icon(widget.prefixIcon, size: 20, color: _isFocused ? AppColors.primary : (isDark ? Colors.white38 : Colors.black38))
                : null,
              suffixIcon: widget.isPassword
                ? AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: IconButton(
                      key: ValueKey(_obscureText),
                      icon: Icon(
                        _obscureText ? LucideIcons.eye : LucideIcons.eyeOff,
                        size: 20,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                      onPressed: () => setState(() => _obscureText = !_obscureText),
                    ),
                  )
                : null,
              filled: true,
              fillColor: isDark ? AppColors.surfaceDarkLighter.withOpacity(0.5) : Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: isDark ? AppColors.dividerDark.withOpacity(0.5) : AppColors.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.error, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
