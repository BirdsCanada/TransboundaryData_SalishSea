---
output:
  pdf_document: default
  html_document: default
editor_options: 
  chunk_output_type: console
---

# Data Processing {#Data9}



> **Before continuing with this chapter, please review the content in Chapters 2-7. It is the responsibility of the data user to understand the various data collection protocols, stipulations around data access, and data use considerations.**

Start by loading the packages needed for this chapter


```r
#install.packages("remotes")
#remotes::install_github("BirdsCanada/naturecounts")

library(naturecounts)
library(tidyverse)
library(stringr)
library(auk)
library(measurements)
library(reshape2)
library(reshape)
```

## Data Schema {#Data9.1}

The purpose of this chapter is to provide the data user R script which will enable the compilation of disparate avian data sources into a standardized format (also known as a schema). The format selected for the purposes of this project was the Bird Monitoring Data Exchange ([BMDE](https://naturecounts.ca/nc/default/nc_bmde.jsp)), which is the core standard of [NatureCounts](https://naturecounts.ca/nc/default/main.jsp) a node of the [Avian Knowledge Network](https://avianknowledge.net/). The BMDE includes 169 core fields for capturing all metric and descriptors associated with bird observations. You can use the naturecounts R package and the following scripts to view the BMDE core fields. A copy of the BMDE table is also in the `BMDE` folder of this directory, which provides additional descriptions of the core columns.


```r
BMDE<-meta_bmde_fields("core")
```

Any data owners wishing to contribute their data to the NatureCounts database should complete the metadata form, also found in the BMDE folder, and reach out to Catherine Jardin: [cjardine\@birdscanada.org](mailto:cjardine@birdscanada.org){.email}, Birds Canada's Data Analyst.

## Species Codes {#Data9.2}

A crucial steps to combining datasets is the inclusion of a common species code. Let's compile the complete species list now for use later in the data compilation. The data tables you will need can be accessed using the naturecounts R package.


```r
sp.code<-meta_species_codes()
sp.code<-sp.code %>% filter(authority=="BSCDATA") %>% select(-authority, -species_id2, -rank) %>% distinct()

sp.tax<-meta_species_taxonomy()
sp.tax<-sp.tax %>% select(species_id, scientific_name, english_name) %>% distinct()

sp<-left_join(sp.code, sp.tax, by="species_id")
sp<-sp %>% distinct(english_name, .keep_all = TRUE)
```

## Data Manipulation {#Data9.3}

All data sets need to be manipulated before they are used for an analysis. Anyone that uses big datasets for research will tell you that it often takes more time to manipulate and filter the data than doing the actual statistical analysis. I therefore cannot cover all the possible data manipulations you will do, but will give you some sample script to help compile a contemporary dataset of birds using the tansboundary waters of the Salish Sea.

To accommodate the R scripts in this chapter, data samples for each dataset are provided in the `Data` folder. These samples are structured in the same format you will receive the raw data from the data owner.

There are data column in the raw dataset that are not carried over to the BMDE. We do retain any information which could be used for effort correction, but some auxiliary data is lost which could bee used if developing a occupancy model. If you are a data user, you should inspect the raw data columns to ensure there is nothing that you need dropped from the final datatable. You can change the code below to retain additional columns as needed.

### BCCWS & BCMA {#Data9.3.1}

We start with two Canadian datasets that are already in the BMDE schema and accessible through [NatureCounts](https://naturecounts.ca/nc/default/main.jsp). The [BCCWS](#BCCWS2) and [BCMA](##BCMA3) are accessible through the NatureCounts web portal or directly using the naturecounts R package. Since the BCCWS is Access Level 3, you need to make a [data request](https://naturecounts.ca/nc/default/searchquery.jsp). Once your NatureCounts data request has been approved you will receive an email confirmation, which will contain your `request_id`. This number will be used to download your newly acquired dataset into R. The BCMA is open access, Level 5, and therefore a data `request_id` is not required.

If you are new to the naturecounts R package, I recommend you start by reviewing the [Introductory R Tutorial](https://birdscanada.github.io/NatureCounts_IntroTutorial/). Those materials will not be repeated here.

Below is some sample code for downloading the BCCWS and BCMA datasets. You will replace the `request_id` and `username` with your own credentials. To retrieve the core BMDE columns, you will want the `fields_set` to be set to "core" (as below).


```r
library(naturecounts) 

BCCWS<-nc_data_dl(collection="BCCWS", username = "YOUR USERNAME", info="MY REASON", fields_set = "core")

BCMA<-nc_data_dl(collection="BCMA", username = "YOUR USERNAME", info="MY REASON", fields_set = "core")
```

Working with the sample datasets.


```r
BCCWS<-read.csv("Data/BCCWS_sample.csv") 
BCMA<-read.csv("Data/BCMA_sample.csv")  

#select only core BMDE columns, since they seem to vary
library(naturecounts)
BMDE<-meta_bmde_fields("core")
BMDE_col<-unique(BMDE$local_name)

BCCWS<-BCCWS %>% select(all_of(BMDE_col)) 
BCMA<-BCMA %>% select(all_of(BMDE_col)) 

#There seems to be some duplicates in the full BCCWS dataset that need removed. 
BCCWS<-BCCWS %>% distinct(RouteIdentifier, SpeciesCode, YearCollected, MonthCollected, DayCollected, DecimalLatitude, DecimalLongitude, .keep_all=TRUE)

#Assign SurveyAreaIdentifier to RouteIdentifier for BCMA
BCMA$RouteIdentifier<-BCMA$SurveyAreaIdentifier
```

### PSSS {#Data9.3.2}

The data will be received in an .xlsx file. Save as a .csv in the `Data` folder for processing using the following scripts. We will work with the sample dataset here which has the same formatting as the full dataset that you will receive.

Note: the sample dataframe is 50 rows long, but the output dataframe will be 65. How can this be!? This is because the raptors are recorded in rows with the other data and are extracted into their own rows to match the BMDE. This makes the data frame longer.


```r
PSSS<-read.csv("Data/PSSS_sample.csv")

PSSS$lat<-sub(" W.*", "", PSSS$position)  
PSSS$long<-sub(".*W", "", PSSS$position)

PSSS$lat = gsub('N', '', PSSS$lat)
PSSS$long = gsub('W', '', PSSS$long)

PSSS$DecimalLatitude = measurements::conv_unit(PSSS$lat, from = 'deg_dec_min', to = 'dec_deg')
PSSS$DecimalLatitude<-as.numeric((PSSS$DecimalLatitude))
PSSS$DecimalLongitude = measurements::conv_unit(PSSS$long, from = 'deg_dec_min', to = 'dec_deg')
PSSS$DecimalLongitude<-as.numeric(PSSS$DecimalLongitude)
PSSS$DecimalLongitude=PSSS$DecimalLongitude*(-1)

#break apart survey_date and reform into day, month, year
PSSS<-PSSS %>% separate(survey_date, into=c("Date", "del"), sep=" ") %>% select(-del) %>% separate(Date, into=c("YearCollected", "MonthCollected", "DayCollected"), sep="-") 
#wrangle raptor data into the long format since each species identification should be in a unique row. 
raptor1<-PSSS %>% filter(raptor1 != "") %>% mutate(common_name = raptor1, bird_count = raptor1_count, notes= raptor1_affect)%>%  select(-raptor1, -raptor2, -raptor3, -raptor1_count, -raptor2_count, -raptor3_count, -raptor1_affect, -raptor2_affect, -raptor3_affect) 

raptor1<-raptor1 %>% group_by(site_name, common_name, YearCollected, MonthCollected, DayCollected) %>% mutate(bird_count=sum(bird_count)) %>% distinct(common_name, site_name, YearCollected, MonthCollected, DayCollected, .keep_all=TRUE)

raptor2<-PSSS %>% filter(raptor2 != "") %>% mutate(common_name = raptor2, bird_count = raptor2_count, notes= raptor2_affect)%>%  select(-raptor1, -raptor2, -raptor3, -raptor1_count, -raptor2_count, -raptor3_count, -raptor1_affect, -raptor2_affect, -raptor3_affect) 

raptor2<-raptor2 %>% group_by(site_name, common_name, YearCollected, MonthCollected, DayCollected) %>% mutate(bird_count=sum(bird_count)) %>% distinct(common_name, site_name, YearCollected, MonthCollected, DayCollected, .keep_all=TRUE)

raptor3<-PSSS %>% filter(raptor3 != "") %>% mutate(common_name = raptor3, bird_count = raptor3_count, notes= raptor3_affect) %>%  select(-raptor1, -raptor2, -raptor3, -raptor1_count, -raptor2_count, -raptor3_count, -raptor1_affect, -raptor2_affect, -raptor3_affect) 

raptor3<-raptor3 %>% group_by(site_name, common_name, YearCollected, MonthCollected, DayCollected) %>% mutate(bird_count=sum(bird_count)) %>% distinct(common_name, site_name, YearCollected, MonthCollected, DayCollected, .keep_all=TRUE)

PSSS<-PSSS %>%  select(-raptor1, -raptor2, -raptor3, -raptor1_count, -raptor2_count, -raptor3_count, -raptor1_affect, -raptor2_affect, -raptor3_affect) 

#bind raptor data back with PSSS data
PSSS<-rbind(PSSS, raptor1)
PSSS<-rbind(PSSS, raptor2)
PSSS<-rbind(PSSS, raptor3)

#remove rows with missing common name
PSSS<-PSSS %>% filter(common_name !="")

#remove bearing and distance because we want each species/ site/ date to be a single row in the data set similar to BBCWS

PSSS<-PSSS %>% select(-bearing, -dist)

#Now summarize the records per species/ site/ date
PSSS<-PSSS %>% group_by(site_name, common_name, YearCollected, MonthCollected, DayCollected) %>% mutate(bird_count=sum(bird_count)) %>% distinct(common_name, site_name, YearCollected, MonthCollected, DayCollected, .keep_all=TRUE)

#replace Thayer's Gull with Ivory Gull
PSSS<-PSSS %>% mutate(common_name = ifelse(common_name == "Thayer's Gull", "Ivory Gull", common_name))

#Merge with species ID
PSSS<-merge(PSSS, sp, by.x=c("common_name"), by.y= ("english_name"), all.x=TRUE)
  
#rename data columns to match BMDE
PSSS<-PSSS %>% dplyr::rename(CommonName =common_name, SurveyAreaIdentifier= survey_site_id, Locality = site_name, MinimumElevationInMeters=elevation, MaximumElevationInMeters=elevation, TimeObservationsStarted=start_time, TimeCollected = start_time, TimeObservationsEnded=end_time, ObservationCount = bird_count, ObservationCount2=large_flock_best, ObsCountAtLeast = large_flock_min, ObsCountAtMost = large_flock_max, FieldNotes=notes, Collector = name, ScientificName=scientific_name, SpeciesCode=species_code, AllSpeciesReported=is_complete)

PSSS$RouteIdentifier<-PSSS$Locality
PSSS$BasisOfRecord <- "Observation"
PSSS$CollectionCode <- "PSSS"
PSSS$Continent <-"North America"
PSSS$Country<-"United States"
PSSS$StateProvince<-"Washington"
PSSS$ProtocolType <- "PointCount"
PSSS$ProtocolSpeciesTargeted <- "Waterbirds"
PSSS$ProtocolURL= "https://seattleaudubon.org/wp-content/uploads/2021/01/PSSS_Protocol_2014-15.pdf"
PSSS$SurveyAreaShape = "300 m"
#PSSS$EffortUnit1 = "Party-hours"
PSSS$ObservationDescriptor = "Total Count"
PSSS$ObservationDescriptor2 = "Large flock best estiamte" 

#Now that we have specified all the data columns we can, we will create the BMDE standardized data table. 

#Identify the missing columns of data
BMDE_col<-unique(BMDE$local_name)

missing<-setdiff(BMDE_col, names(PSSS))
PSSS[missing]<-" "
PSSS<-PSSS[BMDE_col]
```

### PSEMP {#Data9.3.3}

The data will be downloaded as a .gdb file, which is a proprietary format of ESRI meaning the data are not suited for exchange with other applications. My suggestion is that you (or your GIS analyst) import the data layers into ArcGIS, and export tables in .txt. format for import into Excel. Then save as .csv in the `Data` directory of this project.

The tables provided will include:

-   PSEMP_Survey_Observations (PSEMP_sample.csv): This is a point layer storing processed bird observation data recorded during the winter fixed-wing aerial shorebird surveys. There are two observers in the plane, one on each side facing outward, that record their observations into an audio recording device along with timestamp information and position data from an on-board GPS receiver. This data is later transcribed into tab-delimited files along with a timestamped track-log for the plane (also tab-delimited). This source data are then imported into GIS format and a series of geoprocessing scripts are run which project these points spatially 63 meters at right angles to either side of the plane as well as filtering them (to reduce the chance of double counting) and adding additional attribute information.

> **You will want to add the X and Y coordinates to this table before you export it from ArcGIS. If you are not familiar with how to do this, you will find some useful instructions [here](https://support.esri.com/en/technical-article/000002217).**

-   PSEMP_SurveyRoutes: This is a polyline GIS data layer representing the flight path of the fixed wing plane recorded (initially as a series of point locations) during the winter fixed-wing aerial shorebird surveys.

-   PSEMP_SurveyArea: This is a polygon data layer that represents the area considered to be visually surveyed during the annual winter fixed-wing aerial shorebird surveys. The data consist of rectangular strips that run parallel to the flight path of the plane. The strips are 50 meters wide and are centered 63 meters to either side of the plane. Locations of shorebird observations recorded along the flight path are spatially projected into the center of these strips. The purpose of the strips is to provide an estimate of surveyed area as well as serving as inputs in a process wherein some shorebird observations are removed from areas of survey strip overlap in an effort to minimize the chances of double counting birds.

-   Species (PSEMP_species.csv): This table lists the avian species groups recorded during the winter fixed-wing aerial shorebird surveys. It provides species common and scientific names as well as the species codes (TaxoNameID) necessary to crosswalk these species to group membership (for composite groups analyzed) and to other WDFW databases.

-   PSEMP_Group: This table provides a list of composite groups of species surveys. Some of these groups were included in subsequent statistical analysis; these groups are noted in the "StatsRun" attribute.

-   SpeciesPSEMP_Group: This associative table allows species observations to be crosswalked to composite groups that they participate in.

-   PSEMP_SpeciesObservation_Attribute.xlsx: This is an extra table that was attained from the PSEMP group directly. It contains descriptors of the `PSEMP_Survey_Observations` layer. A copy of this table is saved in the `Data` director.

We will work with the sample dataset here which has the same formatting as the full dataset that you will receive through the online download.


```r
PSEMP<-read.csv("Data/PSEMP_sample.csv") #note the x and y were added in ArcGIS before export.

#Get species code information from the NatureCounts R package (duplicate scripts)
sp.code<-meta_species_codes()
sp.code<-sp.code %>% filter(authority=="BSCDATA") %>% select(-authority, -species_id2, -rank) %>% distinct()

sp.tax<-meta_species_taxonomy()
sp.tax<-sp.tax %>% select(species_id, scientific_name, english_name) %>% distinct()

sp<-left_join(sp.code, sp.tax, by="species_id")
sp<-sp %>% distinct(english_name, .keep_all = TRUE)

#load the PSEMP species table
sp_PSEMP<-read.csv("Data/PSEMP_species.csv")
sp_PSEMP<-sp_PSEMP %>% select(TaxoNameID, PSEMP_CommonName, PSEMP_SpeciesCode, PSEMP_SciName1) %>% distinct() %>% filter(TaxoNameID>=1)

#some species codes need changed in order to properly link this with the sp table from the NatureCounts database. 
sp_PSEMP<-sp_PSEMP %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Cormorant, Brandt's", "BRAC", PSEMP_SpeciesCode)) %>% 
mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Plover, American golden", "AMGP", PSEMP_SpeciesCode)) %>%  mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Duck, harlequin", "HARD", PSEMP_SpeciesCode))  %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Gull, herring", "HERG", PSEMP_SpeciesCode)) %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Gull, Heermann's", "HEEG", PSEMP_SpeciesCode))  %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Shoveler, northern", "NSHO", PSEMP_SpeciesCode))  %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Crow, northwestern", "NOCR", PSEMP_SpeciesCode))  %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Hawk, red-tailed", "HAHA", PSEMP_SpeciesCode))  %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Gull, Thayer's", "ICGU", PSEMP_SpeciesCode))  %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Swan, trumpeter", "TRUS", PSEMP_SpeciesCode))  %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Goose, white-fronted", "GWFG", PSEMP_SpeciesCode))  %>% mutate(PSEMP_SpeciesCode=ifelse(PSEMP_CommonName=="Pelican, American white", "AWPE", PSEMP_SpeciesCode)) %>% 
filter(PSEMP_SpeciesCode!="HAPO") %>% 
select(-TaxoNameID, -PSEMP_CommonName, -PSEMP_SciName1)

#join species tables
sp_PSEMP<-merge(sp_PSEMP, sp, by.x="PSEMP_SpeciesCode", by.y="species_code", all.x=TRUE)

#join to observation data
PSEMP<-left_join(PSEMP, sp_PSEMP, by="PSEMP_SpeciesCode")

#remove any species that start with 'U' as unidentified 

PSEMP<-PSEMP %>% filter(!is.na(species_id))

#join to the area table
area_PSEMP<-read.csv("Data/PSEMP_SurveyArea.csv")
area_PSEMP<-area_PSEMP %>% select(TransectID, SurveyYear, Shape_Length, Shape_Area)
area_PSEMP<-area_PSEMP %>% distinct(TransectID, SurveyYear, .keep_all = TRUE)

PSEMP<-left_join(PSEMP, area_PSEMP, by=c("TransectID", "SurveyYear"))

#Separate data and time field into separate columns
PSEMP$DateTimeFromLog<-as.Date(PSEMP$ObservationDateTime)
PSEMP<-PSEMP %>% separate(ObservationDateTime, c("YearCollected", "MonthCollected", "del"), sep="-")
PSEMP<-PSEMP %>% separate(del, c("DayCollected", "TimeCollected"), sep=" ") 

#rename columns to match BMDE
PSEMP<-PSEMP %>% dplyr::rename(RouteIdentifier=TransectID, ProtocolType=TransectType, CollectorNumber
= ObserverID, SamplingEventIdentifier=ObservationID, BearingInDegrees=ObservationDegreesDTrue, DecimalLatitude=Y, DecimalLongitude=X, ScientificName = scientific_name, SpeciesCode=PSEMP_SpeciesCode, 
CommonName=english_name, SurveyAreaSize=Shape_Area, Remarks=ObservationComment)

#1-Observation on shoreline transect; 2-Observation on open water transect; Unsure why some years are Null

PSEMP<-PSEMP %>% mutate(ProtocolType=ifelse(ProtocolType==1, "Shoreline Transect", ifelse(ProtocolType==2, "Open Water Transect", "Null")))

PSEMP$Locality<-PSEMP$RouteIdentifier
PSEMP$BasisOfRecord <- "Observation"
PSEMP$CollectionCode <- "PSEMP"
PSEMP$Continent <-"North America"
PSEMP$Country<-"United States"
PSEMP$StateProvince<-"Washington"
PSEMP$ProtocolSpeciesTargeted <- "Waterbirds"
PSEMP$InstitutionCode<-"PSEMP"
PSEMP$NumberOfObservers<-2

#Remove non-unique observations and sum results per location/ date (double observer)
PSEMP<-PSEMP %>% group_by(RouteIdentifier, SpeciesCode, YearCollected, MonthCollected, DayCollected, DecimalLatitude, DecimalLongitude) %>% mutate(ObservationCount=sum(ObservationCount)) %>% distinct(RouteIdentifier, SpeciesCode, YearCollected, MonthCollected, DayCollected, DecimalLatitude, DecimalLongitude, .keep_all=TRUE)

#Now that we have specified all the data columns we can, we will create the BMDE standardized data table. #Identify the missing columns of data
BMDE_col<-unique(BMDE$local_name)

missing<-setdiff(BMDE_col, names(PSEMP))
PSEMP[missing]<-" "
PSEMP<-PSEMP[BMDE_col]
```

### eBird {#Data9.3.4}

You will make an online request for eBird data scoped to the geographic region and temporal scale of choice. In this instance, I would request all the data for Washington and British Columbia from 2002-present. Each region needs to be requested separately. Once you have received the raw data files, you can save them in the `Data` directory of this folder. They will be BIG! Due to the large size of this dataset, it must be filtered to a smaller subset of desired observations before reading into R. This filtering is most efficiently done using [auk: eBird Data Extraction and Processing with AWK](https://cornelllabofornithology.github.io/auk/) a Unix utility and programming language for processing column formatted text data. This package acts as a front end for AWK, allowing users to filter eBird data before import into R.

There will be several files in the .zip folder along with your raw data, including: BCRCodes, IBACodes, USFWSCodes, recommend citation, terms of use, and the metadata file.

We will once again work with the sample dataset here which has the same formatting as the full dataset that you will receive through the online download.


```r
#start by setting the working directory of the abd files to the data directory of this project, where your data files should be saved

#getwd() # your current working directory
#auk_set_ebd_path("C:/Users/dethier/Documents/ethier-scripts/DataCompile-SDJV/Data/", overwrite=FALSE) # my current working directory (sample code)

WA_in<-"Data/eBirdWA_sample.txt"
WA_out<-"Data/WA_filter.txt"

ebird_WA<-WA_in %>% auk_ebd() %>% 
  #define filters
  auk_bcr(bcr=5) %>% 
  #auk_protocol("eBird Pelagic Protocol") %>% 
  auk_protocol("Stationary") %>% 
  auk_filter(file=WA_out, overwrite=TRUE) %>% 
  read_ebd()

BC_in<-"Data/eBirdBC_sample.txt"
BC_out<-"Data/BC_filter.txt"

ebird_BC<-BC_in %>% auk_ebd() %>% 
  #define filters
  auk_bcr(bcr=5) %>% 
  #auk_protocol("eBird Pelagic Protocol") %>% 
  auk_protocol("Stationary") %>% 
  auk_filter(file=BC_out, overwrite=TRUE) %>% 
  auk_complete() %>% 
  read_ebd()

ebird_data<-rbind(ebird_BC, ebird_WA)

#separate data and time columns
ebird_data<-ebird_data %>% separate(observation_date, into=c("YearCollected", "MonthCollected", "DayCollected"), sep="-") 
  
#rename columns
ebird_data<-ebird_data %>% dplyr::rename (GlobalUniqueIdentifier=global_unique_identifier, 
DateLastModified=last_edited_date,  
TaxonConceptID=taxon_concept_id, 
CommonName=common_name, 	
ScientificName=scientific_name, 
ObservationCount=observation_count, 
Country=country_code, 
StateProvince=state, 
SurveyAreaIdentifier=locality_id,
TimeCollected=time_observations_started, 
CollectorNumber=observer_id, 
SamplingEventIdentifier=sampling_event_identifier, 
ProtocolType=protocol_type, 
ProtocolCode=protocol_code, 
ProjectCode=project_code, 
DistanceFromStart=effort_distance_km,
SurveyAreaSize=effort_area_ha,
NumberOfObservers=number_observers,
AllIndividualsReported=all_species_reported,
Remarks=trip_comments,
Remarks2=species_comments, 
DecimalLatitude= latitude,
DecimalLongitude=longitude,
Locality=locality
)

#Assign species_id and SpeciesCode
ebird_data<-merge(ebird_data, sp, by.x="CommonName", by.y="english_name") 
#Some species may be lost in this merge. Looking for a way to fix this using the naturecounts package. 

ebird_data<-ebird_data %>% dplyr::rename(SpeciesCode=species_code)

ebird_data$RouteIdentifier<-ebird_data$Locality
ebird_data$BasisOfRecord <- "Observation"
ebird_data$CollectionCode <- "EBIRD"
ebird_data$InstitutionCode<-"Cornell"
ebird_data$Continent <-"North America"
ebird_data$ProtocolURL<- "https://support.ebird.org/en/support/solutions/articles/48000950859-guide-to-ebird-protocols"

ebird_data<-ebird_data %>% mutate(DurationInHours = duration_minutes/60)

#Now that we have specified all the data columns we can, we will create the BMDE standardized data table. 

#Identify the missing columns of data
BMDE_col<-unique(BMDE$local_name)

missing<-setdiff(BMDE_col, names(ebird_data))
ebird_data[missing]<-" "
ebird_data<-ebird_data[BMDE_col]
```

### CBC {#Data9.3.5}

To access CBC data you must contact Audubon at [cbcadmin\@audubon.org](mailto:cbcadmin@audubon.org){.email}. A online form will be send to you to complete. When completing this form, scope the data to the geographic and temporal scale you require. You will also be asked if you want the auxiliary data included, such as effort and weather. Select yes to all options so that you have a complete dataset to work with.

You will receive the raw data compressed in a Box folder, which you can download and save to the `Data` directory associated with this project. You will also be given links to download the "cbc_field_definitions_2013.pdf", which details the information in each data column, and the "CBCEditorialCodes.pdf", which defines the modifiers used when recording species. Both of these files are saved in the `Data` directory of this project.

The tables provided will include:

-   CBC_Circle_Species_Report: the raw counts of each species seen in each circle in each year

-   CBC_Effort_Many_Types: for each count circle in each year, this table details the mode of data collection (e.g., car, foot), distance traveled, and the number of hours the survey took.

-   CBC_Effort_Summary_Report: for each count in each year, this table details additional types of data collection effort, including field versus feeder counters, min and max parties, feeder hours, nocturnal hours, and nocturnal distance. These data are often used for effort correction.

-   CBC_Weather_Report: for each count circle in each year, this table details all th weather covarites collected during the survey.

-   CBC_Count_History_Report: this table detail when each count circle was run and in which years. This can be used to zero-fill the data matrix.

We will once again work with the sample dataset here which has the same formatting as the full dataset that you will receive through the online download.


```r
#load Species Data
CBC<-read.csv("Data/CBC_Circle_Species_sample.csv")

#separate columns
CBC<-CBC %>% separate(subnational_code, into=c("del", "StateProvince"), sep="-") %>% select(-del)

CBC<-CBC %>% separate(cnt_dt, into=c("date", "del"), sep=" ") %>% select(-del)
CBC<-CBC %>% separate(date, into=c("MonthCollected", "DayCollected", "YearCollected"), sep="/")

#rename columns
#circle ID = RouteIdentifier
CBC<-CBC %>% dplyr::rename(RouteIdentifier=abbrev, Locality=name, DecimalLatitude= latitude, DecimalLongitude=longitude, Country=country_code, CommonName = com_name, ScientificName=sci_name, ObservationCount = how_many)

#load effort measurements

CBC_eff<-read.csv("Data/CBC_Effort_Many_Types_Report.csv")

#convert from miles to km
CBC_eff<-CBC_eff %>% mutate(dist_km = ifelse(distance_unit=="Miles", distance*1.609344, distance)) %>% select(-distance, -OID_)

#create total distance travelled
CBC_eff<-CBC_eff %>% group_by(abbrev, name, count_yr) %>% summarize(dis_tot=sum(dist_km), hour_tot=sum(hours)) 

#rename columns
CBC_eff<-CBC_eff %>% dplyr::rename(RouteIdentifier=abbrev, Locality=name,  DurationInHours = hour_tot, DistanceFromStart= dis_tot)

#join tables
CBC<-left_join(CBC, CBC_eff, by=c("RouteIdentifier", "Locality", "count_yr"))

#Remove subspecies since this does not allow tables to link 
CBC$CommonName<-gsub("\\s*\\([^\\)]+\\)", "", as.character(CBC$CommonName))

#replace Thayer's Gull with Ivory Gull
CBC<-CBC %>% mutate(CommonName = ifelse(CommonName == "Thayer's Gull", "Ivory Gull", CommonName))

CBC<-merge(CBC, sp, by.x="CommonName", by.y="english_name")
CBC<-CBC %>% select(-ScientificName) %>% rename(ScientificName = scientific_name, SpeciesCode=species_code)

CBC$BasisOfRecord <- "Observation"
CBC$CollectionCode <- "CBC"
CBC$Continent <-"North America"
CBC$ProtocolSpeciesTargeted <- "All birds"
CBC$InstitutionCode<-"Audubon"
CBC$ProtocolURL="https://www.audubon.org/conservation/science/christmas-bird-count"

#Now that we have specified all the data columns we can, we will create the BMDE standardized data table. 

#Identify the missing columns of data
BMDE_col<-unique(BMDE$local_name)

missing<-setdiff(BMDE_col, names(CBC))
CBC[missing]<-" "
CBC<-CBC[BMDE_col]
```

### All Data Combined {#Data9.3.6}

Now that all the datasets are in the BMDE format, we can simply bind these together into a single dataset.


```r
dat<-rbind(BCCWS, BCMA, PSSS, PSEMP, ebird_data, CBC)

dat$YearCollected<-as.numeric(dat$YearCollected)
dat$MonthCollected<-as.numeric(dat$MonthCollected)
dat$DayCollected<-as.numeric((dat$DayCollected))
dat$ObservationCount<-as.numeric((dat$ObservationCount))
```

## Zero-filling dataframe {#Data9.4}

Now that you have a complete dateframe you will notice that in the `ObervationCount` column there are no zero counts. This is because surveyors only count what is present at a site, as opposed to what is not present (i.e., zero counts). Properly zero-filling your dataframe is important for most research purposes. It tells you when a site was surveyed, but a species of interest was not detected.

To property zero-fill a dataframe you will want to create an `events matrix` using the full dataset (i.e., one which covers the temporal and spatial scale of interest). This `event matrix` will tell us which sites were surveyed and when. Then we can use this matrix to add the zeros during a species specific analysis. We don't add all the zeros to the occurrence dataset, because this would get very large.

**Note: the creation of the events matrix assumes that at least one species was detected at each survey point. This assumption is nearly always true**


```r
#create the events matrix
event<-NULL
events<-dat %>% select(YearCollected, MonthCollected, DayCollected, DecimalLatitude, DecimalLongitude, RouteIdentifier) %>% distinct()

#example of how to use the events matrix to zero-fill for Surf Scoter

SUSC<-dat %>% filter(SpeciesCode=="SUSC")
SUSC<-left_join(events, SUSC, by=c("YearCollected", "MonthCollected", "DayCollected", "DecimalLatitude", "DecimalLongitude", "RouteIdentifier"))

species<-"SUSC"

SUSC<-SUSC %>% mutate(ObservationCount = replace(ObservationCount, is.na(ObservationCount), 0),
               SpeciesCode = species)
```

## Checking and removing duplicates {#Data9.5}

Because some people use eBird to submit there data for various programs, there is a potential for duplicates in the full dataset. The `events matrix` does not allow multiple observations/ reports on the same day at the same location (latitude & longitude), so by merging your species specific table to the events matrix, you should eliminate duplicates. If you want to ensure there are no duplicates you can run the following sample code.


```r
distinct<-dat %>% distinct(YearCollected, MonthCollected, DayCollected, TimeCollected, DecimalLatitude, DecimalLongitude, SpeciesCode, ObservationCount, RouteIdentifier, Locality, .keep_all=TRUE)
```

## Assigning survey period {#Data9.6}

Winter surveys more than often straddle two calendar years (e.g., start in October 2021 and end in April 2022). When doing an analysis you are often interested in 'year' as a covarite or random effect. We will call this data column survey `Period`, and will assign this the start year of the surveys.

NOTE: The PSEMP dataset contains the `SurveyYear` which is the end year of the survey period. We removed this during data processing but will add it back here.


```r
dat$Period <- ifelse(dat$MonthCollected %in% c(8:12), dat$YearCollected, 
	dat$YearCollected-1) 
```

## Remove out of range species/ unsuitable habitat {#Data9.7}

Some surveys, like the CBC and eBird, are not specifically targeted towards sea ducks or other species of interest. We will therefore have surveys that are not of value to our assessment. There are several ways to filter these data, but what I find easy is identifying survey locations where an individual is not repeatably identified (e.g., \<=1), and remove these from the `events` list used for zero-filling.

NOTE: I would work this into your data processing loop if doing this for many species

Let's use SUSC again as an example.


```r
site.summ <- melt(dat, id.var = c("RouteIdentifier", "SpeciesCode"), measure.var = "ObservationCount")

site.summ <- cast(site.summ, RouteIdentifier + SpeciesCode ~ variable, sum)

site.sp.list <- unique(subset(site.summ, select = c("RouteIdentifier", "SpeciesCode"), ObservationCount > 1))

site.SUSC.list<-site.sp.list %>% filter(SpeciesCode=="SUSC") #this will be your 'range' list for SUSC. You can used this to remove out of range or rare records. 

test<-left_join(site.SUSC.list, SUSC, by=c("SpeciesCode", "RouteIdentifier"))
```
