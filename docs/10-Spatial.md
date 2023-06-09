---
output:
  pdf_document: default
  html_document: default
editor_options: 
  markdown: 
    wrap: 72
---

# Spatial Data {#SD10}


<style type="text/css">
.table tr:nth-child(even) { background: #eee; }
</style>

## Overview

Previous research has identified a suite of biophysical predictors important in predicting the distribution and habitat use of sea ducks and coastal birds (Table 1). However, likely owing to the international border dividing the Salish Sea, many of these environmental/biophysical layers have yet to be compiled or used for trans-boundary habitat modeling. Furthermore, there are numerous available data sets that have yet to be tested in predicting the distribution of sea ducks that could be important (Table 2). The purpose of this chapter is to give an overview of spatial data that can support international sea duck habitat models in the Salish Sea. At the end of this chapter the user will know:

1.  What spatial data is available for modeling in the Salish Sea

2.  Where to get the data

3.  The limitations of the data (e.g., spatial resolution and temporal scale)

4.  How to work with different types of data

------------------------------------------------------------------------

**Table 1.** Summary of biophysical predictors used in modeling sea duck distribution and habitat use.

| Covariate                      |    Type     | Citations                                                   |
|:-----------------|:----------------:|:----------------------------------|
| Net Primary Productivity       |   Aquatic   | Lamb et al. 2020; Rickbeil et al. 2014                      |
| Sea Surface Temperature        |   Aquatic   | Lamb et al. 2020; Rickbeil et al. 2014; Zipkins et al. 2010 |
| Salinity                       |   Aquatic   | Lamb et al. 2020                                            |
| Sediments                      |   Aquatic   | Rickbeil et al. 2014                                        |
| Distance to Nearest Shoreline  |   Spatial   | Lamb et al. 2020                                            |
| Bottom Depth (Bathymetry)      |   Spatial   | Lamb et al. 2020; Zipkins et al. 2010                       |
| Slope/Ocean Floor Topography   |   Spatial   | Lamb et al. 2020; Zipkins et al. 2010                       |
| Bay or Otherwise               |   Spatial   | Zipkins et al. 2010                                         |
| Climate During Migration       |   Climate   | Zipkins et al. 2010                                         |
| Monthly Winter Temperature     |   Climate   | Rickbeil et al. 2014                                        |
| Monthly Winter Precipitation   |   Climate   | Rickbeil et al. 2014                                        |
| Shore Zone                     | Terrestrial | Rickbeil et al. 2014                                        |
| Latitude                       |   Spatial   | Lamb et al. 2020; Zipkins et al. 2010                       |
| Longitude                      |   Spatial   | Lamb et al. 2020                                            |
| Spatial Autocorrelation        |    Other    | Zipkins et al. 2010                                         |
| Temporal Autocorrelation       |    Other    | Zipkins et al. 2010                                         |
| Offset or Covariate for Effort |    Other    | Zipkins et al. 2010; Michel et al. 2021                     |

**Table 2.** Summary of potential biophysical predictors not previously tested in modeling sea duck distribution and habitat use.

| Covariate            |  Type   |
|:---------------------|:-------:|
| Sea Vessel Traffic   | Spatial |
| Bottom Patches       | Spatial |
| Distribution of Prey | Spatial |
| Aquatic Vegiation    | Spatial |

------------------------------------------------------------------------

## Available Data

Below you will find a collection of available data sets that could be used in sea duck habitat suitability analysis. The data sets provided here have been guided by previous literature and may not be comprehensive. When available newer or better data sets have been included to replace out of date sources. Some covariates in Table 1 have been excluded as they are specific to the research being conducted (latitude/longitude, autocorrelation, and effort). A suite of data sets that have not been previously tested have also been included here. Not all of these data sets are trans boundary in nature but have been included for special use cases and could be updated if and when a corresponding data set becomes available.

### Net Primary Productivity

Net Primary Productivity (NPP), the measure of energy or biomass accumulation by primary producers, influences the distribution of consumers at greater trophic levels. With the launch of ocean-observing satellites, reasonable estimates of ocean primary production have become available. Numerous models exist for determining NPP, however, the vertical general productive model (VGPM) is a common standard and is a function of chlorophyll, available light, and photosynthetic efficiency (O'Malley 2012). Alternatively, the concentration chlorophyll-*a* has been used as an index of NPP as it related to phytoplankton biomass (Moses et al. 2009).

#### Data Sources

| Dataset                                                                                                                | Format       | Unit              | Resolution (km^2^) | Timescale                  | Source        |
|:------------|:-----------|:-----------|:-----------|:-----------|:-----------|
| [Vertical General Productive Model](http://orca.science.oregonstate.edu/1080.by.2160.monthly.hdf.vgpm.m.chl.m.sst.php) | HDF          | mgC m^-2^ day^-1^ | 100                | Monthly or 8day: 2002-2021 | O'Malley 2012 |
| [Chlorophyll-*a*](https://oceancolor.gsfc.nasa.gov/cgi/browse.pl?sen=amod)                                             | netCDF (.nc) | mg m^-3^          | 1                  | Daily: 2002-Present        | MODIS         |

#### Data Use Considerations

Both datasets are freely available to download and use from their respective links in the table above. User sign up might be required.

The VGPM has a few flaws that might limit its usability for habitat suitability modeling. Firstly, its resolution of approximately 10km by 10km is a bit coarse. Furthermore, the model is limited to calculations south of 49^o^ N in December and 53^o^ N in January. With the northern most point of the Salish Sea Bio-region being at 50.8^o^ N the VGPM would not cover the full extent of the study area of interest.

Chlorophyll-*a* data from MODIS on the other hand comes with better resolution and timescale, however, this comes at a cost of file size and the number of files which can be cumbersome to deal with. Furthermore, even though the data set has a daily temporal scale, cloud cover can lead to missing data. To overcome this issue one could use MODIS Level 3 data that provides averages at 8-days or monthly at a resolution of 4 km which could be problematic.

### Sea Surface Temperature

Sea Surface Temperature (SST), can also influence the distribution of species based on their thermal needs (Lamb et al. 2020; Zipkins et al. 2010).

#### Data Sources

| Dataset                                                                                                                                                                               | Format       | Unit | Resolution (km^2^) | Timescale           | Source                            |
|:---------------|:----------|:----------|:----------|:----------|:----------|
| [MODIS Aqua 11 um Day/Night Sea Surface Temp](https://oceancolor.gsfc.nasa.gov/cgi/browse.pl?sub=level3&per=CU&day=19331&set=10&ndx=0&mon=19297&sen=amod&rad=0&frc=0&dnm=D@M&prm=SST) | netCDF (.nc) | C    | 1                  | Daily: 2002-Present | MODIS                             |
| [AVHRR Pathfinder SST](https://www.ncei.noaa.gov/products/avhrr-pathfinder-sst)                                                                                                       | netCDF (.nc) | C    | 16                 | Daily: 1981-Present | NOAA/NASA AVHRR Pathﬁnder Program |
| [MUR-SST](https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplMURSST41.graph)                                                                                                          | netCDF (.nc) | C    | 1                  | Daily: 2003-Present | PODAAC                            |

#### Data Use Considerations

MODIS, Pathfinder, and MUR-SST data are freely accessible to download at their respective links above. MODIS data comes in a higher resolution but might be more cumbersome to work with given there are two satellite passes per day resulting in large file downloads. Pathfinder data is ready to use immediately and has day and night averages. Furthermore, like Chlorophyll-*a* data from MODIS, daily data can often be incomplete depending on cloud cover in the region of interest on a given day. An alternative would be to use MODIS level 3 data which averages over 8 day or monthly periods but at the cost of a lower resolution of 4km.

MUR-SST data from the Physical Oceanography Distributed Active Archive Center is possibly a good solution to overcome the problems with the first two data sources. This data set uses data from multiple sensors that have been calibrated with each other to provide SST data that is consistant in time and space. This allows for high spatial resolution without data-voids due to cloud contamination.

### Salinity

Salinity has been shown to influence sea duck distribution. Lamb et al. (2020) found that during the winter 4 species of sea duck selected positively for salinity.

#### Data Sources

| Dataset                                                             | Format       | Unit   | Resolution (km^2^) | Timescale           | Source                 |
|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|
| [SMAP Salinity V5.0](https://www.remss.com/missions/smap/salinity/) | netCDF (.nc) | g kg-1 | 1600/4900          | 8-Day: 2015-Present | Remote Sensing Systems |

#### Data Use Considerations

The SMAP Salinity V5.0 provides global coverage of sea surface salinity at a temporal scale of 8 days and at scales of 40km or 70km resulting in very poor spatial resolution (1600 km^2^ and 4900 km^2^ respectively). Furthermore, the 70km product is considered the official product and is based on smoothing of the 40 km product which can be noisy. Given this it would be very difficult to use this layer in a meaningful way to model sea duck habitat usage in the Salish Sea.

### Distance to Nearest Shoreline

Lamb et al. (2020) identified distance to nearest shore as a predictor in sea duck distribution during winter, however, this differed among species. This covariate was included along with bottom slope and depth as a proxy for fine-scale variation in things like currents and eddies.

#### Data Sources

| Dataset                                                                          | Format           | Resolution (km) | Timescale | Source                                                       |
|:-----------|:-----------|:-----------|:-----------|:-----------|
| [World Vector Shoreline](https://shoreline.noaa.gov/data/datasheets/wvs.html)    | Shapefile (.shp) | NA              | Static    | Global Self-consistent Hierarchical High-Resolution Database |
| [Prototype Global Shoreline Data](https://dnc.nga.mil/dncp/DNC/PrototypeGSD.php) | Shapefile (.shp) | NA              | Static    | National Geospatial-Intelligence Agency                      |

#### Data Use Considerations

Both data sets are freely available for download at their respective links in the above table. Word Vector Shoreline (WVS) data is in the form of land polygons whereas the Prototype Global Shoreline (PGS) data comes in the form of lines. The PGS data is based on 2000 Landsat imagery (\~30m resolution) which is finer than the WVS which at it's finest scale is about \~2.5km. Both data sets are old with newer imagery only being used to fill in gaps.

### Bottom Depth (Bathymetry) and Ocean Floor Topography (Slope)

Bottom depth and topography have been shown to influence sea duck distribution likely due to a number of factors. Mostly because these species rely heavily on benthic organisms, such as mollusks, sea ducks will prefer shallower areas for foraging where they can reach the sea floor that is supportive of prey populations (Lamb et al. 2020; Zipkins et al. 2010). Bottom depth and topography may also act as proxies for finer scale processes such as currents and eddies (Lamb et al. 2020).

#### Data Sources

| Dataset                                                                                                                                                | Format                             | Unit | Resolution (km^2^) | Timescale | Geography | Source                                           |
|:----------|:----------|:----------|:----------|:----------|:----------|:----------|
| [2-minute Gridded Global Relief Data, (ETOPO2) v2](https://www.ncei.noaa.gov/products/etopo-global-relief-model)                                       | geoTiff (.geotiff) or netCDF (.nc) | m    | 0.2025             | Static    | US/CAD    | National Centers for Environmental Information   |
| [Coastal Relief Model US](https://www.ncei.noaa.gov/products/coastal-relief-model)                                                                     | netCDF (.nc)                       | m    | 0.0081             | Static    | US        | National Centers for Environmental Information   |
| [Canadian Hydrographic Service Non-Navigational (NONNA) Bathymetric Data](https://open.canada.ca/data/en/dataset/d3881c4c-650d-4070-bf9b-1e00aabf0a1d) | geoTiff (.geotiff) and others      | m    | 0.1 or 1           | Static    | CAD       | Canadian Hydrographic Service                    |
| [Salish Sea Bathymetry Basemap](https://salish-sea-atlas-data-wwu.hub.arcgis.com/maps/f23310e286614728a823ae84ab865cc1/about)                          | geoTiff (.geotiff)                 | m    | 0.0081             | Static    | US/CAD    | Salish Sea Atlas (Western Washington University) |

#### Data Use Considerations

All data sets are freely available for download using their respective links above. Ocean floor topography can be calculated using bathymetry and guidelines on how to do this will be covered in the data use guide below.

Both the US Coastal Relief Model and the Canadian Hydrographic Service data are included for completeness, however, these data sets are not trans-boundary in nature and are at different spatial scales which limits their use for trans-boundary sea duck modeling.

ETOPO2 bathymetry data is a global data set at a resolution of 15 Arc-Seconds (\~450m) which would be a suitable solution to using different data sets from the US and Canada. Another alternative which is specific to the Salish Sea Bioregion is bathymetry data from Western Washington University's Salish Sea Atlas. This data set was compiled using two different data sets from the US and Canada and is at a finer resolution than ETOPO2 data (3 Arc-seconds or \~90m). This data set is only suitable to use for work done within the Salish Sea Bioregion as the raster has been clipped to that boundary.

### Climate

Climatic variables such as the North Atlantic Oscillation (NAO) index has been shown to influence the distribution of wintering sea ducks (Zipkins et al. 2010). The NAO index is related to the climatic variability and has been shown to affect the marine environment and ultimately ecological processes in plants and animals. Positive values are associated with more winter storms of greater intensity. More specific to the pacific region is the Pacific Decadal Oscillation (PDO) which will be included here as it pertains to the Salish Sea. Rickbeil et al. (2014) found weak support for atmospheric variables (temperature and precipitation) predicting occurrence, however, these are included below for reference.

#### Data Sources

| Dataset                                                                               | Format   | Unit     | Resolution (km^2^) | Timescale                | Source                                         |
|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|
| [Pacific Decadal Oscillation (PDO)](https://www.ncei.noaa.gov/access/monitoring/pdo/) | tabular  | NA       | NA                 | Monthly: 1854-present    | National Centers for Environmental Information |
| [ClimateNA](https://climatena.ca/)                                                    | Multiple | Multiple | 0.64               | Annual, Seasonal, Yearly | Wang et al. 2016                               |

#### Data Use Considerations

All data sets are freely available using their respective links above. The PDO provides a single monthly index for the Pacific Ocean. ClimateNA on the other hand allows you to extract many monthly, seasonal, and annual climate variables (e.g Mean Temperature and Precipitation) from free point locations. This includes historical and future predicted values. The data can be accessed using the ClimateNA software, API, or R package. The major limitation to both of these data sources is that the finest temporal resolution is down to a given month.

### Shore-zone

Rickbeil et al. (2014) found that including more detailed shore-zone data from the Physical shore-zone mapping system for British Columbia provided modest improvements over only using remotely sensed environmental data for modeling the distributions of coastal bird species in BC.

#### Data Sources

| Dataset                                                                                                                                   | Format             | Unit        | Resolution (km^2^) | Timescale | Geography | Source                                           |
|:----------|:----------|:----------|:----------|:----------|:----------|:----------|
| [Physical shore-zone mapping system for British Columbia](https://open.canada.ca/data/en/dataset/5644a2ca-9e30-43af-914c-b6fe02748199)    | wms/kml            | Categorical |                    | Static    | CAD       | Howes et al 1997                                 |
| [Washington State ShoreZone Inventory](https://www.dnr.wa.gov/programs-and-services/aquatics/aquatic-science/nearshore-habitat-inventory) | geodatabase (.gdb) | Categorical |                    | Static    | US        | Washington State Department of Natural Resources |

#### Data Use Considerations

Shore-zone mapping of both British Columbia and Washington was both done during the late 1990s using a comparable methodology based on Howes (1994). At the time of writing this the British Columbia shore-zone data is difficult to access and work with. Many links to download the data are broken leaving the only available data to be accessed via WMS or .kml. WMS is image based which makes extracting the data extremely difficult and the .kml option has known issues. Alternatively, the Washington data is easy to access in the form of a geodatabase at the link in the above table. Both data sets should be able to be used together (when available) but one important thing to note is that given their age they may not be representative of today's shore zone.

### Sea Vessels

#### Data Sources

| Dataset                                                                                               | Format           | Timescale | Geography | Source                                          |
|:-----------|:-----------|:-----------|:-----------|:-----------|
| [Vessel Traffic Routes](https://open.canada.ca/data/en/dataset/6ab2803a-aace-4e60-83ed-44a7e0ccd1d8)  | shapefile (.shp) | Static    | CAD/US    | Fisheries and Oceans Canada                     |
| [Shipping Fairways, Lanes, and Zones for US waters](https://www.fisheries.noaa.gov/inport/item/39986) | shapefile (.shp) | Static    | US        | National Oceanic and Atmospheric Administration |
| [WSDOT - Ferry Routes](https://geo.wa.gov/datasets/WSDOT::wsdot-ferry-routes/about)                   | shapefile (.shp) | Static    | US        | Washington State Department of Transportation   |
| [AIS Vessel Transit Counts](https://marinecadastre.gov/data/)                                         | raster           | 2015-2021 | US/CAD    | U.S. Coast Guard                                |

#### Data Use Considerations

Both Canada and the US have data on sea vessel routes within the Salish Sea. The Canadian Vessel Traffic Routes data set contains information on ferry routes, mandatory direction of traffic flow, separation lines and zones. To be able to use this data in modeling sea duck distribution one would have to do a bit of research to understand what all of the different layers mean using the [Canadian Chart 1 Symbols, Abbreviations and Terms](https://www.charts.gc.ca/publications/chart1-carte1/sections/m-tracks/tracks-eng.html#section). This is not as simple as using the Shipping Fairways, Lanes, and Zones for US waters which clearly shows shipping lanes in Washington. Washington State ferry routes have been included as they are not shown in the Shipping Fairway data set.

The AIS Vessel Transit counts is an interesting data set that is primarily meant to be US but also spans into the Canadian side of the Salish Sea. This data set is a summary of each time a vessel track passes through a 100m grid cell. Ultimately showing areas of high or low traffic. Furthermore this can be broken down by vessel type: All, Cargo, Fishing, Passenger, Pleasure/Sailing, Tanker, and Tug/Tow.

### Bottom Patches

#### Data Sources

| Dataset                                                                                                                    | Format           | Unit        | Timescale | Geography | Source                      |
|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|
| [Nearshore Bottom Patches for Pacific Canada](https://open.canada.ca/data/en/dataset/6cda0f8d-110e-423d-8d7a-bf8a40eaa26e) | shapefile (.shp) | Categorical | Static    | CAD       | Fisheries and Oceans Canada |

#### Data Use Considerations

The nearshore bottom patches data set for the Pacific Coast of Canada provides continuous substrate map to a depth of 50m off the coast of BC. Substrate is a key indicator of habitat in this important ecosystem where data collection is challenging and expensive. Horizontal accuracy of this data ranges from meters to 10s of meters due to source data and data processing. Areas with higher data density are likely to be more accurate. Unfortunately, at this time there does not seem to be an analogous product for the southern Salish Sea. Habitat mapping has been done here but only in select locations that does not cover the entirety of the southern Salish Sea (see [here](https://pubs.er.usgs.gov/publication/ds935)).

### Distribution of Prey

| Dataset                                                                                                     | Format           | Unit        | Timescale | Geography | Source                                |
|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|
| [Commercial Shellfish Harvest Sites](https://geo.wa.gov/datasets/WADOH::commercial-harvest-sites/about)     | shapefile (.shp) | NA          | Current   | US        | Washington State Department of Health |
| [British Columbia Aquaculture](https://open.canada.ca/data/en/dataset/522d1b67-30d8-4a34-9b62-5da99b1035e6) | CSV              | NA          | Current   | CAD       | Fisheries and Oceans Canada           |
| [Pacific Herring spawn index](https://open.canada.ca/data/en/dataset/d892511c-d851-4f85-a0ec-708bc05d2810)  | CSV              | NA          | 1951-2022 | CAD       | Fisheries and Oceans Canada           |
| [Herring Spawning Locations](https://geo.wa.gov/datasets/wdfw::herring-spawning/about)                      | shapefile (.shp) | NA          |           | US        | Washington Dept of Fish and Wildlife  |
| [Southern Salish Sea Herring Biomass](https://pspwa.app.box.com/s/jogxmuw51h2wghaow1kywpguek1u4epe)         | Excel (.xlsx)    | Metric Tons | 1973-2002 | US        | Washington Dept of Fish and Wildlife  |

#### Data Use Considerations

Aquaculture locations in British Columbia and Washington portions of the Salish Sea are both available from their respective links above. Data from Washington are provided in a spatial point layer whereas BC data is provided in a tabular format which contains latitude and longitude coordinates which can easily be converted to a spatial point layer as well. Both data sets simply provide spatial locations of aquaculture locations with the BC data set differing slightly as it includes other aquaculture locations in addition to shellfish. Only current locations of license holders are shown which do not appear to include historical locations.

Fisheries and Oceans Canada provides a yearly Herring Spawn Index for approximately 300 [sections](https://pacgis01.dfo-mpo.gc.ca/FGPPublic/Pacific_Herring_Spawn_Index_Data/Pacific_Herring_Section_Maps.pdf) along the coast of British Columbia. This is a relative index of Herring Spawn biomass. There is currently no analogous data set for the United States, however, actual biomass has been estimated by the Washington Department of Fish and Wildlife for the Puget Sound. Furthermore, for the same region there is a data set of spawning habitat although survey dates go as far back as 1969 and may not be representative today and there does not appear to be an equivalent data set for BC.

### Aquatic Vegetation

| Dataset                                                                                                                                        | Format           | Timescale | Geography | Source                                           |
|:-----------|:-----------|:-----------|:-----------|:-----------|
| [British Columbia Marine Conservation Analysis](https://bcmca.ca/)                                                                             | shapefile (.shp) | 2006-2013 | CAD       | BC Conservation Foundation                       |
| [Eelgrass Extent - Coastal British Columbia](https://catalogue.hakai.org/dataset/ca-cioos_0219e1d6-8dfc-4718-b89b-ea3dff06a70d)                | shapefile (.shp) | 2016      | CAD       | Hakai Institute                                  |
| [Washington State ShoreZone Inventory](https://data-wadnr.opendata.arcgis.com/search?groupIds=6156be63723248acb386917641ff397f)                | shapefile (.shp) | 1994-2000 | US        | Washington State Department of Natural Resources |
| [Washington Marine Vegetation Atlas](https://www.dnr.wa.gov/programs-and-services/aquatics/aquatic-science/washington-marine-vegetation-atlas) | geoJSON          |           | US        | Washington State Department of Natural Resources |

#### Data Use Considerations

The British Columbia Marine Conservation Analysis provides a suite of data on the aquatic vegetation in British Columbia's coastal waters. Available data includes information on Kelp, Surfgrass, Ditch Grass, and Eelgrass. Data sets vary and contain multiple sources per species (e.g. Eelgrass polygons, Priority Eelgrass Habitat, and Eelgrass Biobands). Metadata for each of these different data sets can be found [here](https://bcmca.ca/datafiles/individualfiles/bcmca_eco_vascplants_eelgrass_polygons_metadata.htm).

A predicted data set representing polygons of Eelgrass for the BC Coast is available from the Hakai Institute. Currently data is not directly downloadable, however, a data request can be made to data\@hakai.org. This data set uses coastline ShoreZone and bathymetry data to predict Eelgrass extent. More information can be found using the link in the above table.

The Washington State ShoreZone Inventory contains data on aquatic vegetation for Washington state. Data from this survey is old coming from aerial video collected in 1994-2000. Information on Eelgrass, Dunegrass, Surfgrass, and Kelp is available in a linear format indication areas of continuous or patchy presence along the shore.

The Washington Marine Vegetation Atlas provides spatial information on the vegetation that grows in nearshore areas for the southern Salish Sea. This data set consists of 2000 polygon areas that have been surveyed from 2 to 56 times and the presence or absence of different vegetation is reported (Seagrass, Kelp, and Macroalgae). Because this data only tells you presence absence information on abundance is not provided. Data is not easily downloadable, however, it can be queried or downloaded using R or GIS software. Below you will find instructions on accessing the data using R.

### Additional Data Sources

Below is a table with a list of additional data sources not covered above which may or may not be useful in modeling sea duck distribution in the Salish Sea. Each source contains a link where you can download and discover additional data and notes are provided to give an overview of what is available.

| Additional Data Source                                                                                                                       | Notes                                                                                                                                                                                                                                                                                                                                                                                                         |
|-----------------------|-------------------------------------------------|
| [Salish Sea Atlas](https://wp.wwu.edu/salishseaatlas/data/)                                                                                  | The Salish Sea Atlas from Western Washington University is an open access digital book that contains cultural and environmental geospatial data sets for the Salish Sea Bioregion. Some data sets included are sea depth (mentioned above), landcover, total annual precipitaiton, and impervious surfaces.                                                                                                   |
| [Bio-ORACLE](https://bio-oracle.org/)                                                                                                        | Bio-ORACLE is a data source for GIS Rasters that provide global geophysical, biotic, and environmental data for marine surface and benthic areas. Data is proved at a resolution of approximately 9.2 km squares. Example data sets included are Chlorophyll concentration, current velocity, sea surface temperature, and salinity. Furthermore, data can be downloaded using the R package 'sdmpredictors.' |
| [The British Columbia Marine Conservation Analysis (2006--2013)](https://bcmca.ca/)                                                          | In addition to information on aquatic vegetation, the BCMCA contains a suite of additional data sets for BC coastal waters including tidal currents, Shorezone exposure, algae, invertebrates, birds, and mammals to name a few. It is important to note that data is \> 10 years old and is only available for BC.                                                                                           |
| [Washington Coastal Atlas](https://apps.ecology.wa.gov/coastalatlasmap)                                                                      | In addition to information on aquatic vegetation, the Washington Coastal Atlas contains many other useful data sources specific to Shoreline, Ocean, Wetland, Administrative, and Land Cover. The interactive map allows you to view data and links to downloading (when available) are provided in layer information.                                                                                        |
| [BC Coastal Resource Information Management System](https://www2.gov.bc.ca/gov/content/data/geographic-data-services/topographic-data/coast) | The B.C. Coastal Resource Information Management System (CRIMS) is an interactive tool for viewing and downloading coastal and marine data for British Columbia. The development of this tool is ongoing meaning new layers can be added as they become available.                                                                                                                                            |

## Working With Different Data Sets in R

Coming soon....
>>>>>>> ab168c426e4b4c544534843877c4fa5c83c19d58
