# HDAT9800 2024 Chapter 2 optional unmarked exercise


This optional, unmarked exercise is intended to help you practice and self-assess your understanding of the core curriculum material in the HDAT9800 course. It is optional, and is unmarked. However, you may wish to seek help or feedback from your course instructors if you do attempt the exercise and are unsure about any aspects of it. Please see the instructions on the [Optional Unmarked Exercises page](https://hdat9800.cbdrh.med.unsw.edu.au/optional_unmarked_exercises.html) for seeking feedback.

## Due date: there is no due date

Your task is to create a simple report as an Rmarkdown document using _knitr_

The skeleton has been created for you in the chapter-2-exercise.Rmd file (it is just the standard R markdown skeleton file).

Do the following and commit your changes to git at the very least after each numbered point.

  1. Change the author and date in the metadata

  2. Change the report to have 3 sections with 2nd level headings (using `##`)
 
    * Introduction
    * Discussion
    * Conclusion

We're going to be writing a report discussing flight delays for a handful of airlines
in the `nycflights13` data.

We'll be using the `dplyr`, `nycflight13` and `ggplot2` libraries. We don't cover `ggplot2` until Chapter 3 but for this 
assessment all the `ggplot2`  code you need is provided below.

  3. In the `setup` chunk add code to load the three libraries 

```
library(dplyr)
library(nycflights13)
library(ggplot2)
```

  4. Write a single short paragraph for the **Introduction** to say what this report is about. Don't worry too much about what you say here, just  make some attempt to describe the report.
  
  5. In the **Discussion** section, include the code below in a code chunk and add some explanatory text about what the code does.

```
delay <- flights %>%
         group_by(tailnum, carrier) %>%
         summarise(count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)) %>%
         filter(count > 20, dist < 2000, carrier %in% c('UA', 'DL', 'AA', 'US')) %>%
         left_join(airlines)
```

  6. Include another code chunk in the **Discussion** section to plot these data as follows,  and a paragraph describing the **construction** or **architecture**  of the plot (what type of chart it is, what data it shows, any other characteristics. Do not discuss what the plot shows or reveals (see task 7).

```
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2, color="blue") +
  geom_smooth(color="red") + scale_size_area() +
  labs(x="Distance (miles)",
       y="Delay (minutes)",
       size="# of flights") +
  ggtitle("Flight delay") +
  facet_grid(. ~ name)
```

  7. Finally, fill in the **Conclusion** with some discussion about what is revealed by the the plot. Do not spend too much time on this, just one or two sentences will do.

After your final commit, push your exercise repository back up to GitHub.


