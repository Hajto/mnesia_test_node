FROM elixir:1.4.5
COPY . /
RUN apt-get update && apt-get -y install dnsutils
CMD mix local.hex --force && mix deps.get && echo "Application started" &&  elixir --name $MY_POD_NAMESPACE@$MY_POD_IP --no-halt --cookie $ERLANG_COOKIE -S mix run