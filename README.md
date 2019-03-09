R codes and dataset for *Visualisation of diachronic constructional change using Motion Chart*
================

[**Gede Primahadi Wijaya Rajeg**](https://figshare.com/authors/Gede_Primahadi_Wijaya_Rajeg/1234749) <a itemprop="sameAs" content="https://orcid.org/0000-0002-2047-8621" href="https://orcid.org/0000-0002-2047-8621" target="orcid.widget" rel="noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"></a>

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />The materials in this repository are licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.

Preface
=======

This is a repository containing R codes and dataset for the following proceedings paper (Primahadi Wijaya R. 2014):

> Primahadi Wijaya R., Gede. 2014. Visualisation of diachronic constructional change using Motion Chart. In Zane Goebel, J. Herudjati Purwoko, Suharno, M. Suryadi & Yusuf Al Arief (eds.), Proceedings: International Seminar on Language Maintenance and Shift IV (LAMAS IV), 267–270. Semarang: Universitas Diponegoro. <doi:10.4225/03/58f5c23dd8387>

The first linguistic study demonstrating dynamic visualisation of language change with motion charts is Hilpert (2011). Martin Hilpert also provides more resources on linguistic motion charts [here](http://members.unine.ch/martin.hilpert/motion.html).

About the contents of the repository
====================================

The R codes were created in 2014 for preparing the paper. The following R packages are required (and were used for the codes in 2014, which still run as per March 2019):

-   [`reshape2`](https://cran.r-project.org/web/packages/reshape2/index.html) (Wickham 2007)
-   [`googleVis`](https://cran.r-project.org/web/packages/googleVis/index.html) (Gesmann & de Castillo 2011)

The R codes files begin with numbers, reflecting the order along which the codes should be run. The reshape package is required to run codes in [`1-script-create-input-data-raw.R`](https://github.com/gederajeg/motion-charts-futurate/blob/master/1-script-create-input-data-raw.r). The input data for this script are two matrix tables for the co-occurrence frequencies of infinitival collocates with *will* ([`will_INF.txt`](https://github.com/gederajeg/motion-charts-futurate/blob/master/will_INF.txt)) and *going to* ([`go_INF.txt`](https://github.com/gederajeg/motion-charts-futurate/blob/master/go_INF.txt)) across the 20 periods of [COHA](https://www.english-corpora.org/coha/) (Davies 2012). The output file for the first script is [`input_data_raw.txt`](https://github.com/gederajeg/motion-charts-futurate/blob/master/input_data_raw.txt).

Given the `input_data_raw.txt` and [`coha_size.txt`](https://github.com/gederajeg/motion-charts-futurate/blob/master/coha_size.txt), the second script ([`2-script-create-motion-chart-input-data.R`](https://github.com/gederajeg/motion-charts-futurate/blob/master/2-script-create-motion-chart-input-data.R)) performs normalisation of the token frequency per million words of the infinitives with *will* and *going to*. This process generates the relevant input data (i.e. [`input_data_futurate.txt`](https://github.com/gederajeg/motion-charts-futurate/blob/master/input_data_futurate.txt)) for creating the static motion chart plot for the paper (with [`3-script-create-motion-chart-plot.R`](https://github.com/gederajeg/motion-charts-futurate/blob/master/3-script-create-motion-chart-plot.R)) and the [dynamic motion chart](https://primahadiwijaya.blogspot.com/2014/09/motion-chart-for-futurate-constructions.html) that can be previewed in web browser (with [`4-script-motion-chart-dynamic.R`](https://github.com/gederajeg/motion-charts-futurate/blob/master/4-script-motion-chart-dynamic.R)), providing that Adobe Flash Player plug-in has been installed on the browser. In script 4, the googleVis package is required.

Script no. 5 (`5-tidyverse-codes.R`) captures scripts 1 to 4 with [tidyverse](https://www.tidyverse.org) packages.

References
==========

Davies, Mark. 2012. Expanding horizons in historical linguistics with the 400-million word Corpus of Historical American English. *Corpora* 7(2). 121–157. <http://corpus.byu.edu/files/davies_2012_corpora.pdf> (28 June, 2014).

Gesmann, Markus & Diego de Castillo. 2011. GoogleVis: Interface between r and the google visualisation api. *The R Journal* 3(2). 40–44. <https://journal.r-project.org/archive/2011-2/RJournal_2011-2_Gesmann+de~Castillo.pdf>.

Hilpert, Martin. 2011. Dynamic visualizations of language change: Motion charts on the basis of bivariate and multivariate data from diachronic corpora. *International Journal of Corpus Linguistics* 16(4). 435–461.

Primahadi Wijaya R., Gede. 2014. Visualisation of diachronic constructional change using Motion Chart. In Zane Goebel, J. Herudjati Purwoko, Suharno, M. Suryadi & Yusuf Al Arief (eds.), *Proceedings: International Seminar on Language Maintenance and Shift IV (LAMAS IV)*, 267–270. Semarang: Universitas Diponegoro. doi:[10.4225/03/58f5c23dd8387](https://doi.org/10.4225/03/58f5c23dd8387).

Wickham, Hadley. 2007. Reshaping data with the reshape package. *Journal of Statistical Software* 21(12). 1–20. <http://www.jstatsoft.org/v21/i12/>.
