use <openscad-common/CenteredText.scad>

$fn = 60;

CANDLE_RADIUS = 37.5 / 2;
CANDLE_HEIGHT = 16;
CANDLE_CUP_COLOUR = "silver";
CANDLE_WAX_COLOUR = "white";
CUP_THICKNESS = 1;

NUM_CANDLES = 4;
CANDLE_SPACING = CANDLE_RADIUS * 4;
HOLDER_WIDTH = CANDLE_RADIUS * 3;
HOLDER_HEIGHT = CANDLE_HEIGHT * 2;
HOLDER_COLOUR = "brown";
SHOW_CANDLES = true;
SHOW_MEASUREMENTS = true;

function holderLength() = NUM_CANDLES * CANDLE_SPACING;

module Candle()
{
    waxRadius = CANDLE_RADIUS - CUP_THICKNESS * 2;

    // Cup
    color(CANDLE_CUP_COLOUR)
    difference()
    {
        cylinder(r = CANDLE_RADIUS, h = CANDLE_HEIGHT);

        translate([0, 0, CUP_THICKNESS])
        cylinder(r = waxRadius, h = CANDLE_HEIGHT);
    }

    // Wax
    color(CANDLE_WAX_COLOUR)
    cylinder(r = waxRadius, h = CANDLE_HEIGHT);

    // Flame/wick
    color("yellow")
    translate([0, 0, CUP_THICKNESS])
    cylinder(r = 1, h = CANDLE_HEIGHT * 1.5);
}

module MultipleCandles()
{
    translate([0, HOLDER_WIDTH / 2, HOLDER_HEIGHT - CANDLE_HEIGHT])
    for (n = [0 : NUM_CANDLES - 1])
    {
        x = (n + 0.5) * CANDLE_SPACING;
        translate([x, 0, 0]) Candle();
    }
}

module CandleHolder(showCandles = SHOW_CANDLES)
{
    difference()
    {
        color(HOLDER_COLOUR)
        cube([holderLength(), HOLDER_WIDTH, HOLDER_HEIGHT]);

        MultipleCandles();
    }

    if (showCandles)
    {
        translate([0, 0, 0.1])
        MultipleCandles();
    }

    if (SHOW_MEASUREMENTS)
    {
        // Holder length
        linear_extrude(1)
        translate([holderLength() / 2, -20, 0])
        CenteredText(str(holderLength(), " mm"), [holderLength() / 4, 20]);

        // Holder length
        linear_extrude(1)
        rotate([0, 0, 270])
        translate([HOLDER_WIDTH / -2, -20, 0])
        CenteredText(str(HOLDER_WIDTH, " mm"), [HOLDER_WIDTH, 20]);

        // TODO: Show candle diameter
        // TODO: Think about cutting candle holes a little larger than the candle actually is
    }
}

module CandleHolder2D()
{
    projection()
    difference()
    {
        CandleHolder(showCandles=false);

        // Cut off bottom, so that the candle holes go all the way through
        cube([holderLength(), HOLDER_WIDTH, HOLDER_HEIGHT - CANDLE_HEIGHT]);
    }
}
