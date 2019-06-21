# docker-rshiny
This serves as a GitHub repository where images can either be built directly from or pulled from our [gru/wu/rshiny repository on dockerhub](https://cloud.docker.com/u/gruwu/repository/docker/gruwu/rshiny). The docker images serve images for our RShiny-applications, for example, [materialflows.net](https://www.materialflows.net) and [SCP Hotspot Analysis](http://scp-hat.lifecycleinitiative.org/).

## How to use it?

### Remote
In your `docker-compose.yml` use `gruwu/rshiny` as your image.

e.g.

```yaml
services:
  app:
    container_name: shiny
    image: gruwu/rshiny
    # or with tag to get specific version:
    # image: gruwu/rshiny:2019-04-02
```

### After a download / git clone
You can either build it with `docker build . -t example_name` (make sure to navigate to the directory first) and then use this `example_name` as your `image:` as in [Remote](#remote).

You can also state a `build context`. Just create a directory (e.g. `docker-rshiny`) with a `Dockerfile`, `shiny-server.conf`, and `shiny-server.sh`, inside your project directory, adjust packages to your needs and then modify the `docker-compose.yml` to use `build` instead of `image`.

```yaml
services:
  app:
    container_name: shiny
    # image: gruwu/rshiny
    build:
      context: ./docker-rshiny/
```

## How to adjust it?
The most common use case will be that you need to [add or remove a package dependency](#add-or-remove-a-package-dependency). If you can think of anything else that might be of use, open an issue.

### Add or remove a package dependency
For this, you just add your desired package at the end of the additions to ` && install2.r --error \`, where there is no `\` anymore (e.g. after `leaflet.extras`). Or, in case you want to delete it, you remove the line of the package that you do not need.

```Dockerfile
&& install2.r --error \
  ...
  leaflet.extras \
  the_cran_package_i_need
```

Alternatively, or if you need a specific version or a GitHub package, you can add the following:

```Dockerfile
# install plotly version 4.9
RUN R -e "install.packages('https://cran.r-project.org/src/contrib/plotly_4.9.0.tar.gz', repos = NULL)"
```

### Test any changes
Navigate to the `test_app` directory, then type `docker-compose up -d`. This builds the `app` inside the `test_app` folder with every docker-setup in the directory. With that you can test compatibility of your app with new versions or also older versions, other R versions or package versions, etc.

The apps will be deployed between the ports `:80` (build in the main directory), `:81` (2019-04-02 version) and `:84` (2019-05-28 version).
