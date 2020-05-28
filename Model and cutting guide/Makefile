NAME := CandleHolder

ALL_2D := \
	exports/${NAME}-4.dxf \
	exports/${NAME}-4.svg \
	exports/${NAME}-6.dxf \
	exports/${NAME}-6.svg \

ALL_3D := \
	exports/${NAME}-4.stl \
	exports/${NAME}-4.png \
	exports/${NAME}-6.stl \
	exports/${NAME}-6.png \

.PHONY: all clean

all: ${ALL_2D} ${ALL_3D}

exports/${NAME}-4.dxf exports/${NAME}-4.svg: exports/${NAME}2D-4.scad ${NAME}.scad
	openscad -o $@ $<

exports/${NAME}-4.stl exports/${NAME}-4.png: exports/${NAME}3D-4.scad ${NAME}.scad
	openscad -o $@ $<

exports/${NAME}-6.dxf exports/${NAME}-6.svg: exports/${NAME}2D-6.scad ${NAME}.scad
	openscad -o $@ $<

exports/${NAME}-6.stl exports/${NAME}-6.png: exports/${NAME}3D-6.scad ${NAME}.scad
	openscad -o $@ $<

clean:
	rm -f ${ALL_2D} ${ALL_3D}
