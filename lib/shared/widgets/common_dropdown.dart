import 'package:flutter/material.dart';
import '../../core/extensions/margin_extension.dart';
import '../../core/style/app_text_style.dart';
import '../../core/style/colors.dart';
import 'app_svg.dart';

class CustomDropdown<T> extends StatefulWidget {
  final T? selectedValue;
  final List<T> items;
  final Function(T?) onChanged;
  final String hint;
  final double? w;
  final bool showHeading;
  final String? headingText;
  final double? h;
  final TextStyle? hintStyle;
  final String Function(T)? itemToString;
  final String? Function(T?)? validator;
  final double radius;
  final bool isloading;
  final bool isSelectedValid;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hint,
    this.showHeading = false,
    this.headingText,
    this.w = 120,
    this.h = 50,
    this.hintStyle,
    this.itemToString,
    this.validator,
    this.radius = 12.47,
    this.isloading = false,
    required this.isSelectedValid,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  bool _isOpen = false;

  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();

    _filteredItems = widget.items;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _rotation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  static const double _itemHeight = 50;
  static const int _maxVisibleItems = 4;

  void _toggle(bool open) {
    setState(() {
      _isOpen = open;
    });

    if (open) {
      _controller.forward();
    } else {
      _controller.reverse();
      _searchController.clear();
      _filteredItems = widget.items;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,

      initialValue: widget.selectedValue,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showHeading && widget.headingText != null) ...[
              Text(
                widget.headingText!,
                style: AppTextStyles.textStyle_400_14.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              5.hBox,
            ],

            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: widget.w,
              height: widget.h,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _isOpen ? primaryColor : messageButtonClr,
                  width: _isOpen ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(widget.radius),
                color: appFieldBgClr
              ),
              child: InkWell(
                onTap: () => _toggle(!_isOpen),
                child: Row(
                  children: [
                    Expanded(
                      child: _isOpen
                          ? TextField(
                              controller: _searchController,
                              autofocus: false,

                              decoration: const InputDecoration(
                                hintText: "Search...",
                                border: InputBorder.none,
                               
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _filteredItems = widget.items
                                      .where(
                                        (item) =>
                                            (widget.itemToString != null
                                                    ? widget.itemToString!(item)
                                                    : item.toString())
                                                .toLowerCase()
                                                .contains(value.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                            )
                          : Text(
                              field.value != null
                                  ? (widget.itemToString != null
                                        ? widget.itemToString!(field.value as T)
                                        : field.value.toString())
                                  : widget.hint,
                              style: field.value == null
                                  ? (widget.hintStyle ??
                                        AppTextStyles.textStyle_400_14.copyWith(
                                          color: blackGrey,
                                          fontSize: 12,
                                        ))
                                  :AppTextStyles.textStyle_400_14.copyWith(
                                          color: blackGrey,
                                         
                                        ),
                            ),
                    ),
                    RotationTransition(
                      turns: _rotation,
                      child: AppSvg(assetName: "grey_down_arrow",color: primaryColor,),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: _isOpen
                  ? Container(
                      width: widget.w,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: appFieldBgClr,
                        borderRadius: BorderRadius.circular(widget.radius),
                        border: Border.all(color: messageButtonClr),
                      ),
                      child: _filteredItems.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: Text("No results found"),
                            )
                          : ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight:
                                    _filteredItems.length <= _maxVisibleItems
                                    ? _filteredItems.length * _itemHeight
                                    : _maxVisibleItems * _itemHeight,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics:
                                    _filteredItems.length <= _maxVisibleItems
                                    ? const NeverScrollableScrollPhysics()
                                    : const BouncingScrollPhysics(),
                                itemCount: _filteredItems.length,
                                itemBuilder: (context, index) {
                                  final item = _filteredItems[index];
                                  return SizedBox(
                                    height: _itemHeight,
                                    child: ListTile(
                                      title: Text(
                                        widget.itemToString != null
                                            ? widget.itemToString!(item)
                                            : item.toString(),
                                      ),
                                      onTap: () {
                                        field.didChange(item);
                                        widget.onChanged(item);
                                        field.validate();
                                        _toggle(false);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                    )
                  : const SizedBox.shrink(),
            ),

            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Text(
                  field.errorText ?? '',
                  style: AppTextStyles.textStyle_400_14.copyWith(
                    color: const Color.fromARGB(255, 160, 11, 0),
                    fontSize: 12
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
