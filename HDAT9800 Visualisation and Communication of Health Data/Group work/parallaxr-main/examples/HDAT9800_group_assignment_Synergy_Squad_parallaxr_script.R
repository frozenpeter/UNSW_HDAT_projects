# Load packages
library(parallaxr)
library(purrr)

# Define the path to your Markdown files
all_md_str <- list.files(path = "path/to/your/markdown/folder", full.names = TRUE)

# Parse the Markdown files into a tibble
md_tibble <- all_md_str %>%
  purrr::map_dfr(parse_md)

# Generate the parallax scroll HTML document
generate_scroll_doc(path = "path/to/your/output/parallaxr-examples-output.html",
                    inputs = md_tibble)
