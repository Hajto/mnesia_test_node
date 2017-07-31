FROM elixir:1.4.5
COPY . /
RUN apt-get update && apt-get -y install dnsutils
RUN mix compile
CMD dig A $APP_NAME.default.svc.cluster.local && echo "Application started" &&  iex --name $MY_POD_NAMESPACE@$MY_POD_IP --no-halt --cookie $ERLANG_COOKIE -S mix run