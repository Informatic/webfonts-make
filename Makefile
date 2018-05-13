# Input font path
INPUT ?= OCRA.ttf

# Target output directory (all files named FONT.* will be removed on clean!)
OUTPUT ?= out

FNAME = $(notdir $(basename ${INPUT}))

all: ${OUTPUT}/${FNAME}.ttf ${OUTPUT}/${FNAME}.svg ${OUTPUT}/${FNAME}.woff ${OUTPUT}/${FNAME}.eot ${OUTPUT}/${FNAME}.css

clean:
	-rm ${OUTPUT}/${FNAME}.*
	-rm ${OUTPUT}/.${FNAME}.otf

${OUTPUT}/${FNAME}.ttf: ${INPUT}
	./ttf-svg.pe $<

# .otf is not required for webfonts, thus has different name
${OUTPUT}/.${FNAME}.otf: ${INPUT}
	./ttf-svg.pe $<

${OUTPUT}/${FNAME}.svg: ${INPUT}
	./ttf-svg.pe $<

${OUTPUT}/${FNAME}.woff: ${OUTPUT}/.${FNAME}.otf
	sfnt2woff $<
	mv ${OUTPUT}/.${FNAME}.woff $@

${OUTPUT}/${FNAME}.eot: ${OUTPUT}/${FNAME}.ttf
	mkeot $< > $@

define CSS_FILE =
@font-face {
    font-family: '${FNAME}';
    src: url('${FNAME}.eot'); /* IE 9 Compatibility Mode */
    src: url('${FNAME}.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
         url('${FNAME}.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
         url('${FNAME}.ttf') format('truetype'), /* Safari, Android, iOS */
         url('${FNAME}.svg#YourFont') format('svg'); /* Chrome < 4, Legacy iOS */
}
endef

export CSS_FILE

${OUTPUT}/${FNAME}.css:
	@echo
	@echo "$$CSS_FILE" | tee ${OUTPUT}/${FNAME}.css
