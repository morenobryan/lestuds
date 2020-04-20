FROM elixir:1.10-alpine AS phoenix_base

# Need inotify for watchers to work
#      npm for the assets
#      bash for the test watcher
RUN apk --no-cache --update add inotify-tools npm bash

# Update hex and rebar
RUN mix do local.hex --force, \
  local.rebar --force

WORKDIR /app

# Not a standard ENV var for mix.
# This is read in mix.exs to reconfigure the path to store dependencies
ENV MIX_DEPS_PATH /opt/mix/deps

# Move the build path out of /app so the build artifacts only ever live in
# the docker image/container and not ever over a mounted volume
ENV MIX_BUILD_PATH_ROOT /opt/mix/build

COPY mix.exs mix.lock ./

COPY docker/ensure_deps.sh /opt/bin/ensure_deps

RUN mix deps.get

# Prepend /opt/bin to the PATH for binaries we add to the image
ENV PATH "/opt/bin:${PATH}"

EXPOSE 4000

CMD [ "mix", "phx.server" ]
