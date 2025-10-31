[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/Vjpi-BmL)
# HDAT9800 2024 Individual Assessment 3

Please see instructions for this assessment on the HDAT9800 course web site at https://hdat9800.cbdrh.med.unsw.edu.au/individual_assessment_3.html

## Marking -- Tim Churches

As noted on the Assessments Overview page, Individual Assessment 3 will build on the work done for Individual Assessment 2. The data to be used is the Zigong heart failure data, which should be loaded in the same way as Individual Assessment 2 iei store a copy of teh data in a directory call zigong outside but at the same levels as your assessment project directory.

Individual Assessment 3 requires that you select three charts from your Assessment 2 solution, or if you prefer, one of more new charts, and add a degree of interactivity to each of them using Shiny for R. Interactivity should include the ability to choose which variables (columns) are used in at least two of the three charts, and for at least one chart, the ability to filter or restrict the data shown in the chart to several subsets. The ability to vary at least one other aspect of each chart, such as axis scaling or axis range restriction should also be provided.

You may present the Shiny “app” as a traditional Shiny app, or you may embed Shiny in an R Markdown or Quarto document, or use a framework such as shinydashboard. Embedding interactivity in an HTML slide deck created using R Markdown and knitr or Quarto is also fine.

You may use ggplot2 charts or other types of charts supported by R and Shiny, but you must use Shiny to provide the interactivity described above. Additional interactivity provided by dynamic charts types as provided by Plotly or similar is also fine, but must be in addition to the required use of Shiny.

However, all software components need to be installable from CRAN using the standard R package installation procedures. Please do not use packages which need to be installed from GitHub. The reason for this is that your instructors must be able to easily install all the packages used in order to mark your assignment, since they will need to run the application on their laptop. Marks will be deducted for assignment solutions which require installation or configuration of software components not hosted via CRAN.

The task descriptions are quite open-ended, and some marks will be reserved and awarded for more ambitious solutions eg providing interactivity which provides some analytical facility and visualises the results. It is not compulsory to add such extensions, and most of the marks will be awarded for fulfilling the assessment tasks as described above using methods and techniques covered in the core course content.

> 20/24
> Comments: Probably better as a Shiny app or shinydashboard, but the three apps are nonetheless good and show mastery of the Shiny basics, well done!

