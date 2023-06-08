---
output:
  pdf_document: default
  html_document: default
---

# PSSS

[**Puget Sound Seabird Survey**](\(https:/seattleaudubon.org/wp-content/uploads/2021/01/PSSS\_Protocol\_2014-15.pdf\).)

<figure><img src="images/PSSS.PNG" alt=""><figcaption></figcaption></figure>

## Quick Data Overview <a href="#psss4.1" id="psss4.1"></a>

| Data        | Puget Sound Seabird Survey (PSSS)                                   |
| ----------- | ------------------------------------------------------------------- |
| Owner       | Seattle Audubon/ Puget Sound Bird Observatory                       |
| Status      | Active                                                              |
| Years       | 2009 - present                                                      |
| Seasons     | Monthly survey, with a winter focus from Oct - April                |
| Sampling    | Coastal surveys at designated points                                |
| Data Access | Available by contacting data owner                                  |
| Contact     | [joshm@seattleaudubon.org](mailto:joshm@seattleaudubon.org){.email} |

## Data Collection Protocol <a href="#psss4.2" id="psss4.2"></a>

PSSS data collection protocol can be found online [here](https://seattleaudubon.org/wp-content/uploads/2021/01/PSSS\_Protocol\_2014-15.pdf).

In short, surveys are conducted by volunteers using a standardized protocol and data collection [sheets](https://seattleaudubon.org/wp-content/uploads/2021/09/PSSS-Datasheet.pdf). Shore-based counts are completed monthly on the first Saturday of each month from October to April. Surveys are completed within approximately 2 hours of high tide to maximize the opportunity for close observation. Surveys are a minimum of 15 minutes and a maximum of 30 minutes per site. All waterbirds observed to a distance of 300 m from the high tide line are counted, except those that fly through without stopping. For large flocks, surveys estimate both the min, max, and best estimate. Surveyors are required to attend a short training session with Seattle Audubon staff prior to their first survey. Data are entered through a customized online data entry system, available [here](http://seabirdsurvey.org/seabirdsurvey/).

## Avian Data Collected <a href="#psss4.3" id="psss4.3"></a>

Total observation counts of each waterbird species seen during a point survey are recorded, including bearing, distance, and sex ratio. Raptors are recorded separately from the other waterbird species. The dataset is not zero-filled.

Taxonomic Authority =

## Auxiliary Data Collected <a href="#psss4.4" id="psss4.4"></a>

* Observer information: observer name
* Survey information: time observation started, time observation ended
* Survey condition: weather, precipitation, sea state, tide movement, visibility, human activity, raptor activity (all categorical)

## Data Access, Permission, and Format <a href="#psss4.5" id="psss4.5"></a>

At the time of writing, the data were only accessible by reaching out to the Seattle Audubon directly and filling out a data share agreement. The data will be sent to you as a .xslx flat file which will be suitable for [Data Processing](04-PSSS.md#Data9). Ensure that you receive all the data for the specified temporal period you are interested in analyzing. This will be needed to allow for proper zero-filling.

## Data Use Considerations <a href="#psss4.6" id="psss4.6"></a>

The data are collected using a standardized protocol, by trained citizen-science volunteers. This standardization is a strength of this dataset for making inferences about coastal waterbirds in the US Salish Sea.

Since surveyors gather information on distance and direction, estimates of bird density through distance sampling are possible. Specifically, detection of any species declines with the distance from the observer: poor sighting conditions, quality of observing equipment, and observer inexperience all contribute to declining detection likelihood as distance increases. Distance sampling provides a robust approach to estimating density and allows for the calculation of less biased density estimates.

The repeated sampling design of the PSSS makes this dataset suitable for an occupancy modeling framework, in which the probability of detection can be modeled alongside occupancy. Auxiliary data collected during each survey are suitable for the detection process of the model.

Measures of effort are innate to the dataset. Survey duration can be used to make effort corrections to counts.

_Is there a spatial imbalance in the sampling design?_ Since this survey is shore-based, there will be a species sampling bias. Specifically, birds that use nearshore habitats will be detected and counted more often than birds that use offshore habitats. This dataset may therefore be less suitable for modeling seabird habitat use, for example.

This PSSS survey was designed to be similar to the BCCWS, with some notable differences:

| BCCWS                    | PSSS                      |
| ------------------------ | ------------------------- |
| Survey the second Sunday | Survey the first Saturday |
| Sept-April               | Oct-April                 |
| 1km count distance       | 300m count distance       |
| Survey route             | Survey point              |

## Data Use Examples <a href="#psss4.7" id="psss4.7"></a>

Ward EJ, Marshall KN, Ross T, Sedgley A, Hass T, Pearson SF, Joyce G, Hamel NJ, Hodum PJ, Faucett R. 2015. _Using citizen-science data to identify local hotspots of seabird occurrence._ PeerJ 3:e704 https://doi.org/10.7717/peerj.704
