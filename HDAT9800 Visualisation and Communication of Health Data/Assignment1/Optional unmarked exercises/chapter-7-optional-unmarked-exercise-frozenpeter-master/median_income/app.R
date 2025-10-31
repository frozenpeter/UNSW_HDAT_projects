#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)
library(rgdal)
library(rgeos)
library(raster)

# Data loading and preparation we only want to do once

LL_LAT <- -(34 + 4 / 60 + 59.77 / 3600)
LL_LONG <- 150 + 28 / 60 + 4.84 / 3600

UR_LAT <- -(33 + 34 / 60 + 22.43 / 3600)
UR_LONG <- 151 + 23 / 60 + 23.81 / 3600

CED_polys = readOGR(file.path("..", "CED_2016_AUST.shp"))
CED_polys$CED_CODE_2016 = factor(paste0("CED", CED_polys$CED_CODE16))

gClip <- function(shp, bb){
  if (class(bb) == "matrix") {
    b_poly <- as(extent(as.vector(t(bb))), "SpatialPolygons")
  } else {
    b_poly <- as(extent(bb), "SpatialPolygons")
  }
  # to make the warning about proj4 strings go away we can
  # set the projection for our bounding box to be the same as used
  # by the CED shape data (taken from the .prj file)
  proj4string(b_poly) = "+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs"
  raster::crop(shp, bb)
}

bb <- c(LL_LONG, UR_LONG, LL_LAT, UR_LAT)
Sydney_polys <- gClip(CED_polys, bb)

palette_fn <- colorNumeric(c("white", "orange"), c(0, 1000))

# read in population info
CED_popinfo <- read.csv(file.path("..", "2016 Census PEP Commonwealth Electoral Divisions for AUST", "2016Census_P01_AUS_CED.csv"))

# read in CED info
CED_info <- read.csv(file.path("..", "CED_2016_AUST.csv"))

# add the CED prefix to the CED codes
# sum the areas of the CED components
# join the population info for each CED into the table
# calculate the resulting population density
# put it all back into CED_info for later use
CED_info <- CED_info %>%
  mutate(CED_CODE_2016 = paste0("CED", CED_info$CED_CODE_2016)) %>%
  group_by(CED_CODE_2016, CED_NAME_2016) %>%
  summarise(total_area = sum(AREA_ALBERS_SQKM)) %>%
  left_join(CED_popinfo) %>%
  mutate(pop_density = Tot_P_P / total_area)

#
# Fill in your assignment work below here
#

# 1. Load the national income data and the per-electorate income data here [1 mark]
#    Looking at the _Metadata_2016_PEP_DataPack.xlsx_ file we can see that selected medians and averages are in the P02 files
#    Uncomment these lines and fill in the arguments to read.csv() as appropriate

# AUST_medians <- read.csv(...)
# CED_medians <- read.csv(...)

# 2. Extend the `CED_medians` data by adding a column with the difference of the median family income
#    from the national median family income: [1 mark]

# CED_medians$Med_tot_family_inc_weekly_diff <- ...

# 3. Define the colouring scale bounds [1 mark]
#    You'll want to manually examine the data to determine these

# MIN_DIFF = ...
# MAX_DIFF = ...

# 4. Join the `CED_medians` data to the `Sydney_polys` polygons data frame (as in the population density example). [1 mark]

# Sydney_polys@data <- left_join(...)

# 5. Define the colour palette. (You'll want three colours.) [1 mark]

# palette_fn <- colorNumeric(..., c(MIN_DIFF, MAX_DIFF))

# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Median income from 2016 census"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # add the custom.tiles checkbox here for part 7 if necessary
      # checkboxInput(...)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("median.map")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  output$median.map <- renderLeaflet({
    # 6. Draw the map with appropriately coloured polygons and an appropriately titled legend.
    #    (You'll want to add `labFormat = labelFormat(prefix = "$")` in the `addLegend()` function.) [4 marks]
    
    # the.map <- leaflet() %>%
    #   addTiles(..) %>%
    #   addPolygons(...) %>%
    #   addLegend(...)
    # the.map
    
    # 7. For an extra mark, change the map to use the different provider tiles as shown in the population density example
    #    and the different layering to have labels on top of the polygons. [1 mark]
    #    Do this by making turning the map creation into an if/else contruct and adding a 'custom.tiles' checkbox to the UI,
    #    i.e. instead of the above
    
    if (input$custom.tiles) {
      # use custom tiles
      
      # the.map <- leaflet() %>%
      #   addProviderTiles(..) %>%
      #   addPolygons(...) %>%
      #   addProviderTiles(..) %>%
      #   addLegend(...)
      
    } else {
      # the normal map as above
      
      # the.map <- ...
    }
    the.map
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

