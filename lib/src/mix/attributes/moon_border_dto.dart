import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

/// Mix representation of [MoonBorder] for Mix v2 styling pipeline.
final class MoonBorderMix extends OutlinedBorderMix<MoonBorder>
    with DefaultValue<MoonBorder> {
  final Prop<BorderRadiusGeometry>? $borderRadius;
  final Prop<BorderAlign>? $borderAlign;

  MoonBorderMix({
    BorderRadiusGeometryMix? borderRadius,
    BorderSideMix? side,
    BorderAlign? borderAlign,
  }) : this.create(
         borderRadius: Prop.maybeMix(borderRadius),
         side: Prop.maybeMix(side),
         borderAlign: Prop.maybe(borderAlign),
       );

  const MoonBorderMix.create({
    Prop<BorderRadiusGeometry>? borderRadius,
    Prop<BorderSide>? side,
    Prop<BorderAlign>? borderAlign,
  }) : $borderRadius = borderRadius,
       $borderAlign = borderAlign,
       super(side: side);

  factory MoonBorderMix.value(MoonBorder border) {
    return MoonBorderMix(
      borderRadius: BorderRadiusGeometryMix.maybeValue(border.borderRadius),
      side: BorderSideMix.maybeValue(border.side),
      borderAlign: border.borderAlign,
    );
  }

  static MoonBorderMix? maybeValue(MoonBorder? border) {
    return border == null ? null : MoonBorderMix.value(border);
  }

  @override
  MoonBorder resolve(BuildContext context) {
    return MoonBorder(
      borderRadius:
          MixOps.resolve(context, $borderRadius) ?? defaultValue.borderRadius,
      side: MixOps.resolve(context, $side) ?? defaultValue.side,
      borderAlign:
          MixOps.resolve(context, $borderAlign) ?? defaultValue.borderAlign,
    );
  }

  @override
  MoonBorderMix merge(MoonBorderMix? other) {
    if (other == null) return this;

    return MoonBorderMix.create(
      borderRadius: MixOps.merge($borderRadius, other.$borderRadius),
      side: MixOps.merge($side, other.$side),
      borderAlign: MixOps.merge($borderAlign, other.$borderAlign),
    );
  }

  @override
  List<Object?> get props => [$borderRadius, $borderAlign, $side];

  @override
  MoonBorder get defaultValue => const MoonBorder();
}
