import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showRatingText;

  const RatingStars({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 16,
    this.activeColor,
    this.inactiveColor,
    this.showRatingText = false,
  });

  @override
  Widget build(BuildContext context) {
    final activeStarColor = activeColor ?? Colors.amber;
    final inactiveStarColor = inactiveColor ?? Colors.grey.withValues(alpha: 0.3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(maxRating, (index) {
          final starRating = index + 1;
          IconData icon;
          Color color;

          if (rating >= starRating) {
            icon = Icons.star;
            color = activeStarColor;
          } else if (rating >= starRating - 0.5) {
            icon = Icons.star_half;
            color = activeStarColor;
          } else {
            icon = Icons.star_border;
            color = inactiveStarColor;
          }

          return Icon(
            icon,
            size: size,
            color: color,
          );
        }),
        if (showRatingText) ...[
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}

class InteractiveRatingStars extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double> onRatingChanged;
  final int maxRating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const InteractiveRatingStars({
    super.key,
    this.initialRating = 0,
    required this.onRatingChanged,
    this.maxRating = 5,
    this.size = 24,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  State<InteractiveRatingStars> createState() => _InteractiveRatingStarsState();
}

class _InteractiveRatingStarsState extends State<InteractiveRatingStars> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    final activeStarColor = widget.activeColor ?? Colors.amber;
    final inactiveStarColor = widget.inactiveColor ?? Colors.grey.withValues(alpha: 0.3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) {
        final starRating = index + 1.0;
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = starRating;
            });
            widget.onRatingChanged(starRating);
          },
          child: Icon(
            _currentRating >= starRating 
              ? Icons.star 
              : Icons.star_border,
            size: widget.size,
            color: _currentRating >= starRating 
              ? activeStarColor 
              : inactiveStarColor,
          ),
        );
      }),
    );
  }
}