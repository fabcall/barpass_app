// Rating Bar Chart Widget
import 'package:flutter/material.dart';

class RatingBarChart extends StatefulWidget {
  const RatingBarChart({
    required this.ratings,
    super.key,
    this.barColor,
    this.barBackgroundColor,
    this.barHeight = 8.0,
    this.ratingNumberWidth = 20.0,
    this.countWidth = 28.0,
    this.barSpacing = 8.0,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeInOut,
  });

  final Map<int, int> ratings;
  final Color? barColor;
  final Color? barBackgroundColor;
  final double barHeight;
  final double ratingNumberWidth;
  final double countWidth;
  final double barSpacing;
  final Duration animationDuration;
  final Curve animationCurve;

  @override
  State<RatingBarChart> createState() => _RatingBarChartState();
}

class _RatingBarChartState extends State<RatingBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total count for proportions
    var totalCount = 0;
    for (final count in widget.ratings.values) {
      totalCount += count;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRatingRow(context, 5, widget.ratings[5] ?? 0, totalCount),
        _buildRatingRow(context, 4, widget.ratings[4] ?? 0, totalCount),
        _buildRatingRow(context, 3, widget.ratings[3] ?? 0, totalCount),
        _buildRatingRow(context, 2, widget.ratings[2] ?? 0, totalCount),
        _buildRatingRow(context, 1, widget.ratings[1] ?? 0, totalCount),
      ],
    );
  }

  Widget _buildRatingRow(
    BuildContext context,
    int rating,
    int count,
    int totalCount,
  ) {
    final actualBarColor = widget.barColor ?? Colors.amber;
    final actualBarBackgroundColor =
        widget.barBackgroundColor ?? Colors.grey.shade200;

    // Calculate the proportion of the filled bar (0.0 to 1.0)
    final fillRatio = totalCount > 0 ? count / totalCount : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Rating Number
          SizedBox(
            width: widget.ratingNumberWidth,
            child: Center(
              child: Text(
                rating.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
          SizedBox(width: widget.barSpacing),
          // Animated Rating Bar
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final animatedBarWidth =
                        constraints.maxWidth * fillRatio * _animation.value;

                    return SizedBox(
                      height: widget.barHeight,
                      child: Stack(
                        children: [
                          // Background Bar
                          Container(
                            width: constraints.maxWidth,
                            height: widget.barHeight,
                            decoration: BoxDecoration(
                              color: actualBarBackgroundColor,
                              borderRadius: BorderRadius.circular(
                                widget.barHeight / 2,
                              ),
                            ),
                          ),
                          // Foreground Bar (Animated)
                          Container(
                            width: animatedBarWidth,
                            height: widget.barHeight,
                            decoration: BoxDecoration(
                              color: actualBarColor,
                              borderRadius: BorderRadius.circular(
                                widget.barHeight / 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(width: widget.barSpacing),
          // Count Number
          SizedBox(
            width: widget.countWidth,
            child: Text(
              count.toString(),
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
