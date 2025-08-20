FROM rocker/geospatial:4.2.2

# Metadata
LABEL maintainer="treeHeightMaps_R Project" \
      description="Docker container for Tree Canopy Height Maps analysis using R" \
      version="1.0.0"

# Install additional R packages needed for treeHeightMaps
# Note: rocker/geospatial already includes: tidyverse, sf, terra, leaflet, and spatial dependencies
RUN R -e "options(repos = c(CRAN = 'https://cloud.r-project.org')); \
    install.packages(c('pacman', 'maptiles', 'tidyterra', 'classInt', 'htmlwidgets', 'units'), \
    dependencies = TRUE, Ncpus = 2)"

# Create working directory and copy project files
WORKDIR /app
COPY example/ /app/example/
COPY README.md /app/

# Create helper scripts for users
RUN echo '# Tree Height Maps R Container' > /app/getting_started.R && \
    echo '# This container includes most packages needed for tree height mapping' >> /app/getting_started.R && \
    echo '' >> /app/getting_started.R && \
    echo '# To install the chmloader package (requires internet):' >> /app/getting_started.R && \
    echo '# install.packages("devtools")' >> /app/getting_started.R && \
    echo '# devtools::install_github("TESS-Laboratory/chmloader")' >> /app/getting_started.R && \
    echo '' >> /app/getting_started.R && \
    echo '# Load required packages:' >> /app/getting_started.R && \
    echo 'library(terra)' >> /app/getting_started.R && \
    echo 'library(sf)' >> /app/getting_started.R && \
    echo 'library(tidyverse)' >> /app/getting_started.R && \
    echo 'library(leaflet)' >> /app/getting_started.R && \
    echo 'library(htmlwidgets)' >> /app/getting_started.R && \
    echo '' >> /app/getting_started.R && \
    echo '# Example scripts are available in the example/ directory' >> /app/getting_started.R && \
    echo '# Run: source("example/tree_canopy_height_1m.R")' >> /app/getting_started.R

# Create an informational script that lists available packages
RUN echo 'cat("Tree Height Maps Docker Container\\n")' > /app/info.R && \
    echo 'cat("Available example scripts:\\n")' >> /app/info.R && \
    echo 'cat(paste("  -", list.files("example", pattern="\\\\.R$"), collapse="\\n"), "\\n\\n")' >> /app/info.R && \
    echo 'cat("Key R packages included:\\n")' >> /app/info.R && \
    echo 'pkgs <- c("terra", "sf", "tidyverse", "leaflet", "htmlwidgets", "ggplot2")' >> /app/info.R && \
    echo 'for(pkg in pkgs) { if(require(pkg, quietly=TRUE, character.only=TRUE)) cat("  ✓", pkg, "\\n") else cat("  ✗", pkg, "\\n") }' >> /app/info.R && \
    echo 'cat("\\nTo get started, run: source(\\"getting_started.R\\")\\n")' >> /app/info.R

# Set the default command to show info and launch R
CMD ["R", "--no-restore", "-e", "source('/app/info.R')"]

