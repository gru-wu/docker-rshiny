# Get shiny server with tidyverse installed already
FROM rocker/shiny-verse:3.5.2

# Install a few dependencies for packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  lbzip2 \
  libfftw3-dev \
  libgdal-dev \
  libgeos-dev \
  libgsl0-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libhdf4-alt-dev \
  libhdf5-dev \
  liblwgeom-dev \
  libproj-dev \
  libnetcdf-dev \
  libv8-dev \
  libsqlite3-dev \
  libssl-dev \
  libudunits2-dev \
  tk-dev \
  unixodbc-dev \
  && install2.r --error \
    rgdal \
    rgeos \
    sp \
    sf \
    plotly \
    shinydashboard \
    pool \
    maps \
    maptools \
    rgeos \
    sf \
    shinyjs \
    V8 \
    rnaturalearth \
    RPostgreSQL \
    leaflet \
    DT \
    BAMMtools \
    ggseas

# Copy configuration files into the Docker image
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf

# Make the ShinyApp available at port 80
EXPOSE 80

# Copy further configuration files into the Docker image
COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
