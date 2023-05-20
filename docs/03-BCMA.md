---
output:
  pdf_document: default
  html_document: default
---

# BCMA

[**British Columbia Marine Bird Atlas**](\(https:/storymaps.arcgis.com/stories/643e7710d56a427487e4fbe04cb8064c\)/)

<figure><img src="images/BCMA.PNG" alt=""><figcaption></figcaption></figure>

## Quick Data Overview <a href="#bcma3.1" id="bcma3.1"></a>

| Data        | British Columbia Marine Bird Atlas (BCMA)                                                                           |
| ----------- | ------------------------------------------------------------------------------------------------------------------- |
| Owner       | Birds Canada/ Pacific Wildlife Foundation                                                                           |
| Status      | Not Active                                                                                                          |
| Years       | 2008-2015                                                                                                           |
| Seasons     | Monthly surveys over a full year, with some variability                                                             |
| Sampling    | Vessel transects along designated routes, over different regions of the Canadian Salish Sea in each year            |
| Data Access | Available directly in R or through the [NatureCounts](https://naturecounts.ca/nc/default/searchquery.jsp) webportal |
| Contact     | [acouturier@bsc-eoc.org](mailto:acouturier@bsc-eoc.org){.email}                                                     |

## Data Collection Protocol <a href="#bcma3.2" id="bcma3.2"></a>

Protocols are published in technical reports (links below), which may differ slightly between years since each year the survey focused on a different geographic region within the Salish Sea. Also note that the year long survey period straddles a calendar year.

In short, counts of birds and marine mammals were made from a small boat moving at 10-12 knots within a 200 m (100m on either side) wide transect parallel to the shoreline. Surveyors also recorded the number of birds and mammals seen beyond 100 m of the boat. Two observers scanned for birds and mammals on either side of the boat. One observer calls out waypoints approximately every 250-500 meters (depending on survey year), while the other observer recorded the data. Binoculars are used to assist in counting and identifying distant birds and mammals. In most situations, birds and mammals are counted individually. Flocks of more than about 100 individual birds were estimated by summing the number by groups of 10s of individuals.

Technical reports can be found here:

* [The Southern Gulf Islands (2008-2010)](https://pwlf.ca/wp-content/uploads/2019/04/Davidson2010SGI.pdf)
* [Burrard Inlet and Indian Arm (2011-2013)](https://pwlf.ca/wp-content/uploads/2019/04/mbbi.pdf)
* Boundary Bay (2007-2008) (no report available)
* [Howe Sound (2014-2015)](https://secureservercdn.net/45.40.148.234/g5z.e05.myftpupload.com/wp-content/uploads/2021/10/Howe\_Sound\_Report\_Final.pdf)
* [The Fraser River Estuary (2016-2017)](https://pwlf.ca/wp-content/uploads/2019/04/ferf.pdf)

## Avian Data Collected <a href="#bcma3.3" id="bcma3.3"></a>

Counts of waterbird seen during a survey are compiled for each point along a survey transect (i.e., the maximum species count) on each monthly survey. These observations are divided into Port Section, Central Section, Board Section and total ObservationCount. The dataset is not zero-filled.

Taxonomic Authority = AOU

## Auxiliary Data Collected <a href="#bcma3.4" id="bcma3.4"></a>

* Observer information: observer ID
* Survey information: time observation started, time observation ended, duration in hours
* Survey condition: none recorded

## Data Access, Permission, and Format <a href="#bcma3.5" id="bcma3.5"></a>

Data can be freely accessed through the NatureCounts data [download](https://naturecounts.ca/nc/default/searchquery.jsp) portal or directly through the naturecounts R package, which I will demonstrate later in this chapter. The BCMA is an Access Level 5 dataset, meaning a data request form is not required to get access to this dataset, and it can be openly downloaded directly into R using the naturecounts R package.

Data are formatted using a standardized schema that is a core standard of the [Avian Knowledge Network](https://avianknowledge.net/) and which feeds into [GBIF](https://www.gbif.org/).This format is called the Bird Monitoring Data Exchange ([BMDE](https://naturecounts.ca/nc/default/nc\_bmde.jsp)), which includes 169 core fields used for capturing all metric and descriptors associated with bird observations.

## Data Use Considerations <a href="#bcma3.6" id="bcma3.6"></a>

Measures of effort are innate to the dataset. Survey duration (column `DurationinHours`) can be used to make effort correction to counts.

Surveys targeted regions of the Canadian Salish Sea that are known to be important to seabirds. The sampling design is therefore not randomized with respect to habitat types samples, which may limit its usability for habitat suitability modelling.

This dataframe is not zero-filled. It is up to the data user to zero-fill the martix prior to use.

**Some data are missing from the NatureCounts database. Birds Canada is working to get this updated before the official release of this book**

## Data Use Examples <a href="#bcma3.7" id="bcma3.7"></a>

Davidson, P.J.A., R.J. Cannings, A.R. Couturier, D. Lepage, and C.M. Di Corrado (eds.). 2015. _The Atlas of the Breeding Birds of British Columbia, 2008-2012_. Bird Studies Canada, Delta, B.C. \[online] http://www.birdatlas.bc.ca/ e
