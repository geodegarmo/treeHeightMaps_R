# Tree Canopy Height Maps
<!DOCTYPE html>
<html>
<body>

<p>A place to create and share code of newly made maps of canopy tree heights.</p>

<p>Meta and the World Resources Institute launched a global map of tree canopy height at a 1-meter resolution, allowing the detection of single trees on a global scale. Both the canopy height data and the models used to create the data are free and publicly available (Tolan, Couprie, et al. 2024). The maps were created using machine learning models on high-resolution worldwide Maxar satellite imagery. The details of the model used to create the data set are described in Tolan et al. (2024).</p>

<h1>Working With RStudio</h1>

<p>Download R/RStudio at this link: https://posit.co/download/rstudio-desktop </p>


<h2>GitHub Resources</h2>

<p>A great resource for using basemaps in R to produce the interactive maps using Leaflet, Carto, and TESS-Laboratories:</p> 

Leaflet:              https://github.com/Leaflet/Leaflet

Carto:                https://github.com/CartoDB/basemap-styles

TESS-Laboratories:    https://github.com/TESS-Laboratory/chmloader

<h2>Docker</h2>

This repository includes a comprehensive Docker container that provides all the necessary dependencies and tools for tree canopy height mapping analysis. The container is built on the `rocker/geospatial` base image and includes R 4.2.2 with pre-installed packages.

### Quick Start with Docker

**Option 1: Pull from GitHub Container Registry (Recommended)**
```bash
docker pull ghcr.io/geodegarmo/treeheightmaps_r:latest
docker run --rm -it ghcr.io/geodegarmo/treeheightmaps_r:latest
```

**Option 2: Build Locally**
```bash
# Clone the repository
git clone https://github.com/geodegarmo/treeHeightMaps_R.git
cd treeHeightMaps_R

# Build the Docker image
docker build -t treeheightmaps .

# Run the container
docker run --rm -it treeheightmaps
```

### Container Features

The Docker container includes:

- **R 4.2.2** with optimized geospatial libraries
- **Pre-installed packages**: `terra`, `sf`, `tidyverse`, `leaflet`, `htmlwidgets`, `ggplot2`
- **Example scripts** ready to run in the `/app/example/` directory
- **Helper scripts** for getting started and package installation
- **Comprehensive documentation** accessible within the container

### Available Packages

The container comes with these key packages pre-installed:
- `terra` - For raster data processing and spatial analysis
- `sf` - For vector spatial data handling
- `tidyverse` - For data manipulation and visualization
- `leaflet` - For interactive mapping
- `htmlwidgets` - For creating HTML-based visualizations
- `maptiles` - For downloading map tiles
- `tidyterra` - For terra integration with tidyverse
- `classInt` - For class interval calculations

### Docker Usage Examples

**Interactive R Session:**
```bash
docker run --rm -it treeheightmaps
```

**Run a Specific Script:**
```bash
docker run --rm -v $(pwd)/data:/app/data treeheightmaps R -e "source('example/tree_canopy_height_1m.R')"
```

**Mount Local Directories:**
```bash
# Mount data and output directories
docker run --rm -it \
  -v $(pwd)/data:/app/data \
  -v $(pwd)/output:/app/output \
  treeheightmaps
```

**Using Docker Compose:**
```bash
# Start the container with volume mounts
docker-compose up treeheightmaps

# Or start RStudio Server on http://localhost:8787
docker-compose up rstudio
```

### Package Installation

The example scripts now automatically handle the installation of required packages, including the `chmloader` package from TESS-Laboratory. When you run an example script for the first time, it will automatically:

1. Install `devtools` and `pacman` if not already present
2. Install the `chmloader` package from GitHub if not already installed
3. Install an updated version of `leaflet` if needed

**Manual Installation (if needed):**
```r
# Inside the container or R session
install.packages("devtools")
devtools::install_github("TESS-Laboratory/chmloader")
```

**Note:** An internet connection is required for GitHub package installation.

### Container Commands

When you start the container, it automatically displays:
- Available example scripts
- Installed package status  
- Getting started instructions

To run the examples:
```r
# List available scripts
list.files("example")

# Run an example (modify coordinates as needed)
source("example/tree_canopy_height_1m.R")
```  

<h2>Getting Started</h2>

Make a directory and then clone the github.

In Terminal:
`mkdir globalTreeHeight && git clone https://github.com/geodegarmo/treeHeightMaps_R.git`


<h2>References</h2>

<p>Tolan, Jamie, Camille Couprie, John Brandt, Justine Spore, Tobias Tiecke, Tracy Johns, and Patrick Nease. 2024. “Using Artificial Intelligence to Map the Earth’s 
  Forests.” Meta Sustainability. https://sustainability.fb.com/blog/2024/04/22/using-artificial-intelligence-to-map-the-earths-forests/.

Tolan, Jamie, Hung-I Yang, Benjamin Nosarzewski, Guillaume Couairon, Huy V. Vo, John Brandt, Justine Spore, et al. 2024. “Very High Resolution Canopy Height Maps from RGB   Imagery Using Self-Supervised Vision Transformer and Convolutional Decoder Trained on Aerial Lidar.” Remote Sensing of Environment 300 (January): 113888.       
  https://doi.org/10.1016/j.rse.2023.113888.</p>


</body>
</html>


