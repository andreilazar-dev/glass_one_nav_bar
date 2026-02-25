/*
 * Copyright (c)  2026
 * Author: Andrei Lazar
 *
 * This file is part of UniTime.
 *
 *  UnitTime is distributed WITHOUT ANY WARRANTY; without even the
 *  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file or at:
 *  <http://www.gnu.org/licenses/gpl.html>
 */

import 'package:flutter/widgets.dart';

/// Data model representing a single navigation destination.
class GlassOneNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const GlassOneNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
