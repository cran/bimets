
**BIMETS Change-Log**



BIMETS ver. 1.4.0 - Nov. 2018
==============================

* Refined simulation capabilities.

* Refined modeling documentation.


BIMETS ver. 1.3.1 - Apr. 2018
==============================

* Added weekly support, i.e. frequency 53.


BIMETS ver. 1.3.0 - Mar. 2018
==============================

* Multi-Platform Support Code Refactoring.


BIMETS ver. 1.2.20 - Nov. 2017
==============================

* Added function `CUMPROD`.


BIMETS ver. 1.2.19 - Nov. 2017
==============================

* Added function `TSTRIM`.


BIMETS ver. 1.2.18 - Aug. 2017
==============================

* Added function `MOVTOT`.


BIMETS ver. 1.2.16 - Jun. 2017
==============================

* Fixed Bugs in `TSMERGE`.

* Added option `EXTEND `in `TSPROJECT`.


BIMETS ver. 1.2.15 - Mar. 2017
==============================

* Added option `FILLVALUE ` and `VERBOSE `in `as.bimets`.


BIMETS ver. 1.2.13 - Aug. 2016
==============================

* Added option `NSTOCK `in `ANNUAL`, `SEMIANNUAL`, `QUARTERLY`, `MONTHLY`.


BIMETS ver. 1.2.11 - Feb. 2016
==============================

* Added function `CUMULO`.


BIMETS ver. 1.2.10 - Feb. 2015
==============================

* Added function `INDEXNUM`.
 
* Fixed bug in `as.bimets()` with a single observation timeseries.

* Extended time range in 1800-2199.


BIMETS ver. 1.2.7 - Apr. 2014
==============================

* Added option `BIMETS_CONF_NOC `in order to globally disable the compliance check.


BIMETS ver. 1.2.6 - Mar. 2014
==============================

* Added support to frequencies 24 and 36.


BIMETS ver. 1.2.5 - Mar. 2014
==============================

* Speedup in timeseries conversion from and to BIMETS.

* Added `Date()`, `yearmon()` and `yearqtr()` as input class of argument `START` in the `TSERIES` function.

* Added array as input class in functions `date2yp()`, `yq2yp()`, `ym2yp()`.

* `xtsPeriodicity()` and f`requency(xts)` now give high priority to the attribute `.bimetsFreq`, if any.


BIMETS ver. 1.2.4 - Mar. 2014
==============================

* New global option for selecting base class `BIMETS_CONF_CCT`.

* Added function `is.bimets`, added class-type check in function `isCompliant`.

* Added function `as.bimets`, `fromBIMETStoTS`, `fromBIMETStoXTS`.

* Added `coredata` filter in override `[[.xts`.

* Bug fix in function `date2yp()`.


BIMETS ver. 1.2.3 - Jan. 2014
==============================

* Bug fix in xts() daily in range 1970-1979 on daylight saving time change.


BIMETS ver. 1.2.1 - Nov. 2013
==============================

* Added daily support in functions `ANNUAL`, `SEMIANNUAL`, `QUARTERLY`, `MONTHLY`.

* Added function `DAILY`.


BIMETS ver. 1.2.0 - Nov. 2013
==============================

* Added single observation timeseries support.


BIMETS ver. < 1.2.0
==============================

* Initial private releases
