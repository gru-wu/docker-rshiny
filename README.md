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
