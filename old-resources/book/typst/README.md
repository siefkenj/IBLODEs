# IBLODEs Typst Version

This is a [Typst](https://typst.app/docs/) version of IBLODEs. It uses (mostly) one source to compile
 - Slides
 - Workbook
 - Workbook with solutions

 The content can be found in the `modules/` directory. Common things like definitions and settings are in the `common/` directory.

 `libs/` contains special tools like ODE solvers and the overall workbook configuration.

 ## Compiling

 Use
 ```
 typst compile slides.typ --font-path=./
 ```
 or
 ```
 typst compile book.typ --font-path=./
 ```
 to compile. If `--font-path` is not specified and the correct fonts are not installed on your system, you will not get a proper PDF.

 Use the `makedist.sh` script to build all the documents.

 ### Fonts

 Fonts are in the `fonts/` directory. To see if Typst properly detects the fonts, run
 ```
 typst fonts --ignore-system-fonts --font-path=.
 ```

 Make sure to always compile with `--font-path=.` to load the bundled fonts.