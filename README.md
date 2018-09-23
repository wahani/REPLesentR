[![Travis-CI Build Status](https://travis-ci.org/wahani/REPLesentR.svg?branch=master)](https://travis-ci.org/wahani/REPLesentR)
[![Coverage Status](https://img.shields.io/codecov/c/github/wahani/REPLesentR/master.svg)](https://codecov.io/github/wahani/REPLesentR?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/REPLesentR)](https://cran.r-project.org/package=REPLesentR)
[![Downloads](http://cranlogs.r-pkg.org/badges/REPLesentR?color=brightgreen)](http://www.r-pkg.org/pkg/REPLesentR)

## Do presentations in the R REPL

This package provides tools to do presentations inside the R REPL. You can start
from a RMarkdown file and compile a presentation you can then give directly in
R!

Inspiration for this package comes from the
[REPLesent](https://github.com/marconilanna/REPLesent) project which does the
same thing for Scala.

### Features

- Tools to do presentations inside the R REPL
- Take advantage of RMarkdown and pandoc
- Evaluate code on slides
- Integrate data visualisations using the fantastic 'txtplot' package


### Wish-list:

- Syntax highlighting on slides
- Colours on slides
- Satisfying set of formats for slides
- Number of slide in lower right corner



### Install from CRAN

```
install.packages("REPLesentR")
```

### Install from GitHub

```{r}
devtools::install_github("wahani/REPLesentR")
```

## Getting started

Just start with the introduction presentation:

```
REPLesentR::introPresentation()
```

