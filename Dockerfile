FROM rocker/r-ver:4.2.2

# Install system dependencies required for R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    build-essential \
    zlib1g-dev \
    && apt-get clean

# Install R packages from CRAN
RUN R -e "install.packages(c('devtools', 'pacman'), repos = 'https://cloud.r-project.org')"

# Ensure devtools is installed correctly by loading it
RUN R -e "library(devtools)"

# Install GitHub packages
RUN ["R", "-e", "devtools::install_github('TESS-Laboratory/chmloader', dependencies = TRUE)"]
RUN ["R", "-e", "devtools::install_github('rstudio/leaflet', dependencies = TRUE)"]

# Set the default command to launch R
CMD ["R"]

